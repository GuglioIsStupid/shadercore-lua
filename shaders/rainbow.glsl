extern float time;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    vec4 texcolor = Texel(texture, uv);
    texcolor.r = 0.5 + 0.5 * sin(time + uv.x * 10.0);
    texcolor.g = 0.5 + 0.5 * sin(time + uv.y * 10.0);
    texcolor.b = 0.5 + 0.5 * sin(time + uv.x * 10.0 + uv.y * 10.0);
    return texcolor * color;
}
