shader_type canvas_item;

uniform vec4 origin:source_color;
uniform vec4 newColor:source_color;
uniform vec4 ignoreColor:source_color;

void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	
	if(distance(COLOR, origin) < 0.1)
		COLOR = newColor;
	else if (COLOR == ignoreColor)
		COLOR = current_pixel;
	else
		COLOR = mix(COLOR, newColor, 0.175);
		COLOR.a = current_pixel.a;
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
