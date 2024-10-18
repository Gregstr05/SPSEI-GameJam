shader_type canvas_item;

uniform float health = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = vec4((UV.x*health)>0.01?0.0:1.0, 0.0, 0.0, 1.0);
	//COLOR = vec4(UV.x, 0.0, 0.0, 1.0);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
