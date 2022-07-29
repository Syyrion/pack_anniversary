uniform vec2 u_resolution;
uniform float u_skew;

uniform vec3 color1;
uniform vec3 color2;

float random(vec2 px) { // as close to random number 0 - 1 as we can get
    return fract(sin(px.x * 100. + px.y * 458.54) * 9949.65);
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    st.y /= skewmult;
	
	float color = smoothstep(0.0, 1.0, length(st));
	color += mix(-0.015, 0.015, random(st)); // dithering for smoothness
	
    gl_FragColor = vec4(mix(color2, color1, color), 1.0);
}