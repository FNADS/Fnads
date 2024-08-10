shader_type canvas_item;

const float pixelation = 128.0;
uniform float transparency = 1.0;
uniform float jitter_frequenzy = 100;
uniform float jitter_amplitude = 5;

void fragment() {
    vec2 uv_jitter = vec2(sin(TIME * jitter_amplitude), cos(TIME * jitter_amplitude / 1.3)) * jitter_frequenzy;
    vec2 pixelated_UV = floor((UV + uv_jitter) * vec2(pixelation)) / vec2(pixelation);
	vec3 col = step(vec3(0.5),texture(TEXTURE, pixelated_UV).rgb);
    
    COLOR = vec4(col, transparency);
}