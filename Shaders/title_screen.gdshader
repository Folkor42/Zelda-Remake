shader_type canvas_item;

uniform vec4 origin:source_color;
uniform vec4 new:source_color;
uniform float blink_intensity = 0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	// Define a threshold for the comparison
	uvec4 uint_color = uvec4(round(color * 2.0));
	uvec4 uint_origin = uvec4(round(origin * 2.0));
	if (uint_color == uint_origin){
		COLOR = mix(color, new, blink_intensity * color.a);
	}

}
