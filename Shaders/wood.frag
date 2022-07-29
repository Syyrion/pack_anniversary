// patricio gonzalez vivo did all the work here. i only made some changes to make it fit OH better.
// thebookofshaders.com/11/

uniform vec2 u_resolution;
uniform float u_rotation;
uniform float u_skew;
uniform float u_time;

uniform vec3 color1;
uniform vec3 color2;

float random(vec2 px) {
    return fract(sin(px.x * 150.456 + px.y * 0.54) * (9919.65 + u_time/9.0)); // involving a bit of u_time makes the shader bubbly
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( random( i + vec2(0.0,0.0) ),
                     random( i + vec2(1.0,0.0) ), u.x),
                mix( random( i + vec2(0.0,1.0) ),
                     random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 rotate2d(float angle){
    return mat2(cos(angle), sin(angle),
                -sin(angle), cos(angle));
}

float lines(in vec2 pos, float b){
    float scale = 19.0;
    pos *= scale;
    return smoothstep(0.0, 0.5 + b * 0.5, sin(pos.x) + 0.25);
}

void main() {
    vec2 st = (gl_FragCoord.xy - u_resolution.xy*0.5)/u_resolution.y; // make st go from -0.5 to 0.5 instead of 0 to 1920
	
	float skewmult = (1.0 / (u_skew + 1.0));
    
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult); // rotate and scale the coordinates with the level
    st = st * rot;
	
	st += 2.6;
	
    vec2 pos = st.yx * 7.0; // i don't understand this shader much tbh. i just messed around with the numbers until i got something that looked ok

    pos =  pos * rotate2d(noise(pos));

    float color = lines(pos,.5);

    gl_FragColor = vec4(mix(color1, color2, color),1.0);
}
