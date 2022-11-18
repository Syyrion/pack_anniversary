#version 130
uniform vec2 resolution;
uniform float time;
uniform float skew;
uniform float offset;
uniform float close_factor;
const vec4 particle_color = vec4(100.0, 100.0, 255.0, 100.0) / 255.0;
const float distance_add = 0.15;
#define PI 3.1415926538


void main() {
	if(gl_Color == particle_color) {
		gl_FragColor = gl_Color;
	} else {
		float res = resolution.x > resolution.y ? resolution.y : resolution.x;
		vec2 coords = (gl_FragCoord.xy - 0.5 * resolution.xy) / vec2(res * 1.7777777777777, res);
		float origdistance = sqrt(coords.x * coords.x + coords.y * coords.y) + distance_add;
		coords.y *= skew;
		coords.y += offset;
		float distance = sqrt(coords.x * coords.x + coords.y * coords.y) + distance_add;
		gl_FragColor = gl_Color * distance * close_factor;
		if(gl_Color == vec4(1.0, 1.0, 1.0, 1.0)) {
			gl_FragColor = gl_Color * distance * close_factor;
			gl_FragColor.a = 1.0 - gl_Color.a * origdistance * close_factor;
		} else {
			float x = mod((atan(coords.x / coords.y) - time + distance * 6.0) / PI * 2.0, 1.0);
			float y = x * (1.0 - x);
			float distFac = mod(distance * 30.0, 1.0);
			gl_FragColor.rg = gl_FragColor.rg * clamp(y + 1.0 + distFac * (distFac - 1.0), 0.0, 1.0);
			gl_FragColor.a = 1.0;
			gl_FragColor *= 1.4;
		}
	}
}
