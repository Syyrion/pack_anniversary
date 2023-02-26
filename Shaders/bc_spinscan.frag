//inspired by ufo

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_skew;
uniform float u_rotation;
uniform int u_scanning;
uniform int u_dead;

#define pi 3.141592653589793642848

void main() {
    vec2 st = (gl_FragCoord.xy - 0.5 * u_resolution.xy)/u_resolution.y;
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s, -s, c);
    st = st * rot;

    vec3 color = vec3(0.0);
    //scans 2/3 the way around per half beat (d/t)
    float speed = 2.0 * ( (pi/3.0) / (45.0/240.0) );

    float theta = atan(st.y, st.x) - u_time * speed * sign(u_skew);
    
    if (u_scanning == 1) {
    	color += fract(theta * 1.5/pi); // triangle
        
        if (u_skew < 0.0) {
        	color = 1.0 - color; // point the other direction
        	color = color * 2.5 - 1.5;
    	} else {
        	color = color * 4.0 - 3.0; // blue and white are different sizes for some reason
    	}
    }
    
    color = clamp(color, 0.0, 1.0);
    
    color += step(mod(atan(st.y, st.x) + (pi/6.0) + 0.01, (pi/3.0)), 0.02); // panel outlines

    if(u_dead != 1) {
        if(u_skew < 0.0) {
            color.x = 0.0;
        }
    }

    gl_FragColor = vec4(color, 1.0);
}