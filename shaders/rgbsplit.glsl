extern float time;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    float offset = 0.01 * sin(time * 10.0);
    float r = Texel(texture, uv + vec2(offset, 0.0)).r;
    float g = Texel(texture, uv + vec2(-offset, 0.0)).g;
    float b = Texel(texture, uv).b;
    return vec4(r, g, b, 1.0) * color;
}
