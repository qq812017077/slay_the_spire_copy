shader_type particles;
struct DisplayParameters{
	float scale;
	float lifetime;
};

struct DynamicParameters {
	float rotation;

};

uniform vec4 color = vec4(1.0,1.0,1.0,1.0);
uniform vec2 initial_rot_angle = vec2(0,0);
uniform float lifetime_randomness = 0.5;
uniform vec3 emission_shape_offset = vec3(0.);
uniform vec3 emission_shape_scale = vec3(1.);
uniform vec3 emission_box_extents = vec3(100, 100, 0.);

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
float deg_to_rad(float angle)
{
	return angle / 180.0 * PI;
}

vec2 rot_to_dir(float angle_degrees){
	float angle_radians = deg_to_rad(angle_degrees);
	return vec2(cos(angle_radians), -sin(angle_radians));
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

void apply_scale(inout mat4 trans, float scale){
	trans[0].xyz *= sign(scale) * max(abs(scale), 0.001);
	trans[1].xyz *= sign(scale) * max(abs(scale), 0.001);
	trans[2].xyz *= sign(scale) * max(abs(scale), 0.001);
}
vec3 calculate_initial_position(inout uint alt_seed) {
	float x = rand_from_seed(alt_seed) * 2.0 - 1.0;
	float y = rand_from_seed(alt_seed) * 2.0 - 1.0;
	float z = rand_from_seed(alt_seed) * 2.0 - 1.0;

	vec3 pos = vec3(x, y,z) * emission_box_extents;
	return pos * emission_shape_scale + emission_shape_offset;
}

float pow2_out_mix(float s, float e, float w){
	return mix(s, e, pow(w,2));
}

void start() {
	// Called when a particle is spawned.
	uint alt_seed = hash(NUMBER + uint(1) + RANDOM_SEED);
	DisplayParameters display_params;
	DynamicParameters dynamic_params;
	display_params.scale = 1.0;
	display_params.lifetime = (1.0 - lifetime_randomness * rand_from_seed(alt_seed));
	dynamic_params.rotation = randf_range(initial_rot_angle.x, initial_rot_angle.y, alt_seed);

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
		CUSTOM.z = randf_range(200, 900, alt_seed); // speed
		CUSTOM.w = LIFETIME * display_params.lifetime;

		USERDATA1.x = randf_range(0, 360, alt_seed); // rotation
		USERDATA1.y = randf_range(5, 30, alt_seed); // wave intensity
		USERDATA1.z = randf_range(-20, 20, alt_seed); // wave speed

		USERDATA2.x = CUSTOM.z; // start speed
		USERDATA2.y = randf_range(0.1, 0.5, alt_seed); // speed target

	}

}

void process() {
	CUSTOM.y += DELTA;


	CUSTOM.z = pow2_out_mix(USERDATA2.x, USERDATA2.y, CUSTOM.y / CUSTOM.w);
	VELOCITY.xy = rot_to_dir(USERDATA1.x) * CUSTOM.z;

	apply_rot(TRANSFORM, deg_to_rad(USERDATA1.x));
	float lasttime = CUSTOM.w - CUSTOM.y;
	USERDATA1.x += cos(lasttime * USERDATA1.z) * USERDATA1.y * DELTA * 20.0;
	apply_scale(TRANSFORM, lasttime / CUSTOM.w * 1.5);
	//VELOCITY.x = = mix(VELOCITY.x, 0.0, 1.0 - pow(1.0 - CUSTOM.y / CUSTOM.w, 2.0));

	COLOR.xyz = color.xyz;
	if (CUSTOM.y > CUSTOM.w) {
		ACTIVE = false;
	}
}
