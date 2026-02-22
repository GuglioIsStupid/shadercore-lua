extern float time;
extern vec2 resolution;

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords) {
    uv.y += sin(uv.x * 10.0 + time * 2.0) * 0.05;
    vec4 texcolor = Texel(texture, uv);
    return texcolor * color;
}
