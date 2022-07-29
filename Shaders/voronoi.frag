// patricio gonzalez vivo wrote most of this. absolutely love it
// https://thebookofshaders.com/12/

uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 color1;
uniform vec3 color2;

float random(vec2 px) { // as close to random number 0 - 1 as we can get
    return fract(sin(px.x * 100.87 + px.y * 458.54) * 9949.65);
}

vec2 random2( vec2 p ) { // thanks patricio
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
    // Scale
    st *= 7.0;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);

    float m_dist = 1.;  // minimum distance
	vec2 m_point;
	
	
    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(x), float(y));

            // Random position from current + neighbor place in the grid
            vec2 point = random2(i_st + neighbor);

			// Animate the point
            //point = 0.5 + 0.5*sin(u_time + 6.2831*point);

			// Distance to the point
            float dist = distance(f_st, neighbor + point);

            if ( dist < m_dist ) {
				// Keep the closer distance
				m_dist = dist;

				// Keep the position of the closer point
				m_point = point;
			}
        }
    }

    // Draw the min distance (distance field)
    float color = random(m_point);

    gl_FragColor = vec4(mix(color1, color2, color), 1.0);
}
