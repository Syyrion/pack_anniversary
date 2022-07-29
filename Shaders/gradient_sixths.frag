uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;

uniform vec3 color1;
uniform vec3 color2;

float random(vec2 px) { // as close to random number 0 - 1 as we can get
    return fract(sin(px.x * 100. + px.y * 458.54) * 9949.65);
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	float angle = atan(st.y, st.x); // 0 to 1 around the center
	
	float color = cos(angle * 3.0) * 0.5 + 0.5;
	color += mix(-0.015, 0.015, random(st)); // dithering for smoothness
	
	angle = cos(angle * 3.0) * 0.5 + 0.5;
	
    gl_FragColor = vec4(mix(color1, color2, color), 1.0);
}