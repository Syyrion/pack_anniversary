uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 u_color;


void main() {
	vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/(u_resolution.y / 80.0);
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
		
	vec3 color2 = u_color * 0.5;
	
	//st.x += 25.0 * sin(st.y*0.07); // domain distortion funny waves
	st.x += 3.0 * sin(st.y*1.4);
	
	float color = max(sin(st.x * 3.0) - 0.4, 0.0); // constrain it to 0 and above
	
	gl_FragColor = vec4(mix(u_color, color2, color), 1.0); // mix the 2 colors based on the stripes

}