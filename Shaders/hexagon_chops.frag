uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 color1;
uniform vec3 color2;

#define speed -4.0
#define pi 3.1415926

// returns a hexagonal version of "length." thanks the art of code
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
	
	float angle = atan(st.y, st.x);
    float dist = HexDist(st * 25.0) + ceil(sin(angle * 3.0)); // highly recommend messing around with the numbers here. you can do some cool stuff. and replace HexDist with length
	float color = ceil(sin(dist * pi + u_time * speed));
	
	// what is causing the rogue pixels?
	
    gl_FragColor = vec4(mix(color1, color2 * 0.85, color), 1.0);
}