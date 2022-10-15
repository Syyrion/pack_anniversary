uniform vec2 u_resolution;
uniform float u_skew;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.y;
    st.y -= 0.5;
    float ratio = u_resolution.x/u_resolution.y;
    st.x -= 0.5*ratio;
    float skewmult = (1.0 / (u_skew + 1.0));
    vec3 prim = vec3(0.0, 0.0, 0.0);
    vec3 seco = vec3(1.0, 1.0, 1.0);
    
    if(u_skew > 0.0) {
        seco = vec3(1.0, 1.0, 1.0);
    } else {
        seco = vec3(0.0, 1.0, 1.0);
    }

    float s = sin(0.0);
    float c = cos(0.0);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult);
    st = st * rot;
    vec3 color = prim;

    if(mod(atan(st.y, st.x)+(3.141592653589793642/6.0)+0.01,(3.141592653589793642/3.0)) < 0.02) {
        color = seco;
    }

    gl_FragColor = vec4(color, 1.0);
}