shader_type canvas_item;
render_mode blend_mix;

instance uniform float alpha = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float tex_alpha = texture(TEXTURE, UV).a;

// Output:0
	COLOR.rgb = vec3(0,0,0);
	COLOR.a = tex_alpha * 0.2 * alpha;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}