uniform vec3 u_color;

void main() {
    gl_FragColor = vec4(u_color, gl_Color.a);
}