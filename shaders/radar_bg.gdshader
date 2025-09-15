shader_type canvas_item;

uniform float cell_size = 16;
uniform float cell_spacing = 2;
uniform vec4 line_color : source_color; //Now called source_color in Godot 4

varying vec2 v;

uniform vec4 bg_color : source_color;

void vertex() {
	v = VERTEX;
}

void fragment() {
	COLOR.a = 0.;
	float step_size = cell_size + cell_spacing;
	float ratio = cell_spacing / step_size;
	// Grid
	if (fract(v.x / step_size) < ratio || fract(v.y / step_size) < ratio) COLOR = line_color;
	else COLOR = bg_color;
}