shader_type particles;

struct DisplayParameters{
	float scale;
	float lifetime;
};

struct DynamicParameters {
	float rotation;
};

uniform vec2 initial_rot_angle = vec2(0,0);
uniform float lifetime_randomness = 0.5;
uniform vec3 emission_shape_offset = vec3(0.);
uniform vec3 emission_shape_scale = vec3(1.);
uniform vec3 emission_box_extents = vec3(100, 100, 0.);
uniform float gravity = 1000.0;
uniform vec2 floor_range = vec2(100.0,450.0);


uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = (x >> uint(16)) ^ x;
	return x;
}

float rand_from_seed(inout uint seed) {
	int k;
	int s = int(seed);
	if (s == 0)
	s = 305420679;
	k = s / 127773;
	s = 16807 * (s - k * 127773) - 2836 * k;
	if (s < 0)
		s += 2147483647;
	seed = uint(s);
	return float(seed % uint(65536)) / 65535.0;
}

float randf_range(float l, float r, inout uint seed) {
	return mix(l, r, rand_from_seed(seed));
}
vec3 calculate_initial_position(inout uint alt_seed) {
	float x = rand_from_seed(alt_seed) * 2.0 - 1.0;
	float y = rand_from_seed(alt_seed) * 2.0 - 1.0;
	float z = rand_from_seed(alt_seed) * 2.0 - 1.0;
	
	vec3 pos = vec3(x, y,z) * emission_box_extents;
	return pos * emission_shape_scale + emission_shape_offset;
}

float deg_to_rad(float angle)
{
	return angle / 180.0 * PI;
}


float vel_to_rad(vec2 vel){
	vec2 nor_vel = normalize(vel);
	return atan(-nor_vel.y, nor_vel.x);
}
void apply_rot(inout mat4 trans, float rot_angle){
	trans[0].xyz = vec3(cos(rot_angle), -sin(rot_angle), 0.0);
	trans[1].xyz = vec3(sin(rot_angle), cos(rot_angle), 0.0);
	trans[2].xyz = vec3(0.0, 0.0, 1.0);
}
//void apply_scale(inout mat4 trans, vec3 scale){
	//trans[0].xyz *= sign(scale.x) * max(abs(scale.x), 0.001);
	//trans[1].xyz *= sign(scale.y) * max(abs(scale.y), 0.001);
	//trans[2].xyz *= sign(scale.z) * max(abs(scale.z), 0.001);
//}
void apply_scale(inout mat4 trans, float scale){
	trans[0].xyz *= sign(scale) * max(abs(scale), 0.001);
	trans[1].xyz *= sign(scale) * max(abs(scale), 0.001);
	trans[2].xyz *= sign(scale) * max(abs(scale), 0.001);
}
void start() {
	// Called when a particle is spawned.
	uint alt_seed = hash(NUMBER + uint(1) + RANDOM_SEED);
	DisplayParameters display_params;
	DynamicParameters dynamic_params;
	display_params.scale = randf_range(0.3, 2.0, alt_seed);
	display_params.lifetime = (1.0 - lifetime_randomness * rand_from_seed(alt_seed));
	dynamic_params.rotation = randf_range(initial_rot_angle.x, initial_rot_angle.y, alt_seed);
	
	VELOCITY.x = randf_range(-900.0, 900.0, alt_seed);
	VELOCITY.y = randf_range(-500.0, 1000.0, alt_seed);
	COLOR.r = randf_range(0.5, 1.0, alt_seed);
	COLOR.g = randf_range(0.4, 0.6, alt_seed);
	COLOR.b = randf_range(0.0, 0.2, alt_seed);
	COLOR.a = 1.0;
	
	if (RESTART_ROT_SCALE)
	{
		apply_rot(TRANSFORM, deg_to_rad(dynamic_params.rotation));
		apply_scale(TRANSFORM, display_params.scale);
	}
	
	if (RESTART_POSITION)
	{
		TRANSFORM[3].xyz = calculate_initial_position(alt_seed);
		TRANSFORM = EMISSION_TRANSFORM * TRANSFORM;
	}
	
	if (RESTART_CUSTOM)
	{
		CUSTOM = vec4(0.0);
		CUSTOM.x = display_params.scale;
		CUSTOM.y = 0.0;
		CUSTOM.z = TRANSFORM[3].y + randf_range(floor_range.x, floor_range.y, alt_seed);
		CUSTOM.w = LIFETIME * display_params.lifetime;
	}
	
	
}

void process() {
	// Called every frame on existing particles (according to the Fixed FPS property).
	VELOCITY.y += DELTA * gravity / CUSTOM.x;
	CUSTOM.y += DELTA;
	
	apply_rot(TRANSFORM, vel_to_rad(VELOCITY.xy));
	apply_scale(TRANSFORM, CUSTOM.x);
	if (TRANSFORM[3].y > CUSTOM.z)
	{
		VELOCITY.y = - VELOCITY.y * 0.75;
		TRANSFORM[3].y = CUSTOM.z - 0.5;
		VELOCITY.x *= 1.1;
	}
	
	if (CUSTOM.y < 0.1)
		COLOR.a = mix(0.0, 1.0, CUSTOM.y * 10.0);
	else
		COLOR.a = mix(1.0, 0.0, 1.0 - pow(1.0 - CUSTOM.y / CUSTOM.w, 2.0));
	if (CUSTOM.y > CUSTOM.w) {
		ACTIVE = false;
	}
}

