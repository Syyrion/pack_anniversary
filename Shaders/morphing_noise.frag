// "FBM Morphing Noise" by fishy: https://www.shadertoy.com/view/7tcBD8

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_skew;
uniform float u_rotation;

mat2 r(float t) {
    return mat2(cos(t), -sin(t), sin(t), cos(t));
}

float erp(float x, float k) {
    return x < 0.5 ? pow(2.0 * x, k) * 0.5 : 1. - pow(2.0 * (1.0 - x), k) / 2.;
}

vec2 hash(vec2 p) {
    vec3 p3 = fract(p.xyx * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yzx + 33.33);
    return (fract((p3.xx + p3.yz) * p3.zy) - 0.5) * 2.0;
}

float perlinNoise(vec2 p, float s) {
    mat2 r = r(u_time * 2.0);
    vec2 tlVal = r * hash(vec2(floor(p.x), ceil(p.y)));
    vec2 blVal = r * hash(vec2(floor(p.x), floor(p.y)));
    vec2 trVal = r * hash(vec2(ceil(p.x), ceil(p.y)));
    vec2 brVal = r * hash(vec2(ceil(p.x), floor(p.y)));
    vec2 tlOffset = p - vec2(floor(p.x), ceil(p.y));
    vec2 blOffset = p - vec2(floor(p.x), floor(p.y));
    vec2 trOffset = p - vec2(ceil(p.x), ceil(p.y));
    vec2 brOffset = p - vec2(ceil(p.x), floor(p.y));
    float tl = dot(tlOffset, tlVal);
    float bl = dot(blOffset, blVal);
    float tr = dot(trOffset, trVal);
    float br = dot(brOffset, brVal);
    float a = mix(bl, tl, erp(fract(p.y), s));
    float b = mix(br, tr, erp(fract(p.y), s));
    return mix(a, b, erp(fract(p.x), s)) / 2.0 + 0.5;
}

float fbm(in vec2 x, float s, in float H) {
    float G = exp2(-H);
    float f = 1.0;
    float a = 1.0;
    float t = 0.0;
    for(int i = 0; i < 8; i++) {
        t += a * perlinNoise(f * x, s);
        f *= 2.0;
        a *= G;
    }
    return t * 0.5;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    uv.xy -= 0.5;
    uv.y *= u_resolution.y / u_resolution.x;

    // Rotation and skew modifier borrowed from "hexagon_tiles.frag"
    float skewmult = (1.0 / (u_skew + 1.0));
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult);
    uv = uv * rot;

    float h = fbm(uv * 10.0, 2.0, 0.5);
    gl_FragColor = gl_Color * vec4(vec3(h), 1.0);
}