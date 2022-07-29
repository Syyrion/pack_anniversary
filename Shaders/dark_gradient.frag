uniform vec2 u_resolution;
uniform vec3 u_color;

float random(vec2 px) { // as close to random number 0 - 1 as we can get
    return fract(sin(px.x * 100. + px.y * 458.54) * 9949.65);
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
    vec3 black = vec3(0.000,0.000,0.000);
	
	float color = smoothstep(-0.5, 0.5, st.y);
	color += mix(-0.005, 0.005, random(st)); // dithering for smoothness
	
    gl_FragColor = vec4(mix(u_color/15.0, black, color), 1.0);
}