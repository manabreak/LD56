shader_type canvas_item;

void fragment() {
	vec2 uv = UV;
	uv = abs(uv - 0.5) * 2.0;
	vec2 vig = vec2(0.25 / (1.0 / TEXTURE_PIXEL_SIZE));
	vig = smoothstep(vec2(0), vig, 1.0 - uv);
	COLOR = vec4(0, 0, 0, 1.0 - vig.x * vig.y);
}