shader_type spatial;
uniform float strength;
//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {
	ALBEDO = vec3(0.88, 1.0, 0.0);
	ALPHA = strength;// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
