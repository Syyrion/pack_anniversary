// https://www.youtube.com/watch?v=VmrIDyYiJBA
// this is only possible because of The Art of Code and his amazing youtube tutorial on how to make hexagon tiles. 
// i strongly recommend watching it. i would never have figured this out

uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;

uniform vec3 u_color;

// returns a hexagonal version of "length" 
float HexDist(vec2 st) {
    st = abs(st);
    float c = dot(st, vec2(0.5, 0.866));
    c = max(c, st.x);
    
    return c;
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	float hexLength = HexDist(st); // we fuck up the domain in this shader, so to get the true hexagon length, we better do it first
	
	vec3 color2 = u_color * 0.75;
	
	st *= 30.0;
    
    vec2 ratio = vec2(1, 1.73);
    vec2 halp = ratio * 0.5;
    // make 2 sets of tilings, each 1 wide and 1.73 tall, with a half offset to each other 
    vec2 fst = mod(st, ratio) - halp;
    vec2 fst2 = mod(st - halp, ratio) - halp;
    
    //gt picks whichever has a shorter distance
    vec2 gt = dot(fst, fst) < dot(fst2, fst2) ? fst : fst2;
    
    float color = smoothstep(0.435, 0.46, HexDist(gt)); // borders
	
    gl_FragColor = vec4(mix(u_color, color2, color), 1.0);
}