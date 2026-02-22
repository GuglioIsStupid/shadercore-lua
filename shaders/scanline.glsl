extern float time;
extern vec2 resolution;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    vec4 texcolor = Texel(texture, uv);
    float scanline = sin(screen_coords.y * 1.5) * 0.1;
    texcolor.rgb -= scanline;
    return texcolor * color;
}
