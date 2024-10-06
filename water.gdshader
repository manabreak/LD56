shader_type canvas_item;

uniform float wave_speed = 3.0;
uniform float wave_freq = 32.0;
uniform float wave_width = 0.5;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
void fragment(){
	vec2 scale_UV = SCREEN_UV;
	vec2 wave_uv_offset;
	wave_uv_offset.x = cos((TIME * wave_speed) + UV.x + UV.y * wave_freq * 2.0) * wave_width * 0.01;
	COLOR = textureLod(SCREEN_TEXTURE, scale_UV + wave_uv_offset, 0.0);
}