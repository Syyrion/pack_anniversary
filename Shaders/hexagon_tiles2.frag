// https://www.youtube.com/watch?v=VmrIDyYiJBA
// this is only possible because of The Art of Code and his amazing youtube tutorial on how to make hexagon tiles. 
// i strongly recommend watching it. i would never have figured this out

uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;

uniform vec3 color1;
uniform vec3 color2;

float random(vec2 px) { // as close to random number 0 - 1 as we can get
    return fract((sin(px.x * 641.2104) + cos(px.y * 158.545)) * 9949.65);
	// if you look closely, there are some streaks where the y value doesn't randomize right. i left those in as an easter egg because it's hard to fix
}


void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	st *= 8.8;
    
    vec2 ratio = vec2(1, 1.73);
    vec2 halp = ratio * 0.5;
    // make 2 sets of tilings, each 1 wide and 1.73 tall, with a half offset to each other 
    vec2 fst = mod(st, ratio) - halp;
    vec2 fst2 = mod(st - halp, ratio) - halp;
    
    //gt picks whichever has a shorter distance
    vec2 gt = dot(fst, fst) < dot(fst2, fst2) ? fst : fst2;
    
	vec2 id = floor(st - gt + 0.1); // some weird precision errors when just doing st - gt
	
	float color = random(id);
	

    gl_FragColor = vec4(mix(color1, color2, color), 1.0);
}