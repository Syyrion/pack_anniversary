uniform float u_skew;
uniform int u_dead;
//inspired by ufo
void main() {
    vec3 seco;
    if(u_dead == 1) {
        seco = vec3(1.0, 1.0, 1.0);
    }
    else if(u_skew > 0.0) {
        seco = vec3(1.0, 1.0, 1.0);
    } else {
        seco = vec3(0.0, 1.0, 1.0);
    }
    gl_FragColor = vec4(seco,1.0);
}