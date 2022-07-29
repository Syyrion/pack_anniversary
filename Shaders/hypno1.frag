uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 color1;
uniform vec3 color2;

void main() {
	
	vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/(u_resolution.y / 80.0); // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	st.y += 3.0 * sin(st.x*0.4 + u_time); // domain distortion funny waves
	st.x += 3.0 * sin(st.y*0.4);
	
	float color = max(sin(st.x * 3.0) + 0.1, 0.0); // goes from -1 to 1, so we use max to keep it constrained

	gl_FragColor = vec4(mix(color1, color2, color), 1.0); // mix the 2 colors based on the stripes

}