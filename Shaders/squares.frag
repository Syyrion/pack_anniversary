uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 color1;
uniform vec3 color2;

float box(vec2 _st, vec2 _size){ // thanks patricio gonzalez vivo
    _size = vec2(0.5)-_size*0.5;
    vec2 uv = smoothstep(_size,_size+vec2(1e-4),_st);
    uv *= smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
    return uv.x*uv.y;
}

void main(void){
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;

    st *= 15.0;

    // basically just adds a y offset half the time, and the other half of the time it adds an x offset
    st.x += (step(1.0, mod(st.y, 2.0)) - 0.5) * step(1.0, mod(u_time, 2.0)) * u_time * 2.0;
    
    st.y += (step(1.0, mod(st.x, 2.0)) - 0.5) * step(1.0, mod(u_time + 1.0, 2.0)) * u_time * 2.0;

    st = fract(st);


    vec3 color = vec3(box(st,vec2(0.82)));

    gl_FragColor = vec4(mix(color2, color1, color),1.0);
}
