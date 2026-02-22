extern float time;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(texture, texture_coords);
    texcolor.r = texcolor.r * abs(sin(time));
    texcolor.g = texcolor.g * abs(cos(time));
    texcolor.b = texcolor.b * abs(sin(time + 1.0));
    return texcolor * color;
}
