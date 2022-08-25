#version 330 compatibility
uniform vec2 u_resolution;
uniform vec2 u_shift;
uniform vec4 u_color;
uniform vec4 u_pulsecolor;
uniform float u_random;
uniform int u_mode;

void main()
{
	float shadeW = 0.0;
	float shadeX = 0.0;
	float shade = 1.0;
	if(u_mode == 0) {
		shadeW = floor(((-abs(sin((gl_FragCoord.y/100.0)+((u_shift.x+gl_FragCoord.x)/50.0))*40.0)+abs(gl_FragCoord.y-u_resolution.y-u_shift.y-350.0))/(u_resolution.y/6.0)))/8.0;
		shade = shadeW;
	}
	else if(u_mode == 1) {
		shadeW = 1.0-(abs(gl_FragCoord.y-(u_resolution.y/2.0))/(u_resolution.y*2.0));
		shade = shadeW;
	}
	else if(u_mode == 2) {
		shadeW = floor(((-abs(sin((gl_FragCoord.y/100.0)+((u_shift.x+gl_FragCoord.x)/50.0))*40.0)+abs(gl_FragCoord.y-u_resolution.y-u_shift.y-350.0))/(u_resolution.y/6.0)))/8.0;
		shadeX = (mod(u_random+gl_FragCoord.y, gl_FragCoord.x)/gl_FragCoord.x);
		shade = shadeW * shadeX;
	}
    gl_FragColor = gl_Color * vec4( shade*u_color.r+u_pulsecolor.r , shade*u_color.g+u_pulsecolor.g , shade*u_color.b+u_pulsecolor.b , shade*u_color.a+u_pulsecolor.a);
}