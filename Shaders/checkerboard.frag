uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;

uniform vec3 color1;
uniform vec3 color2;

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	st *= 0.93; // a little bigger
	
    float color = 0.0;
	
    color += step(0.05, mod(st.x, 0.1)); // not anti aliased, but it looks fine
    color += step(0.05, mod(st.y, 0.1));
    color = mod(color, 2.0);
	
    gl_FragColor = vec4(mix(color1, color2, color),1.0);
}