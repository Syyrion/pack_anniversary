uniform vec2 u_resolution;
uniform float u_time;
uniform float u_skew;
uniform int u_dd;
//inspired by ufo
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.y;
    st.y -= 0.5;
    float ratio = u_resolution.x/u_resolution.y;
    st.x -= 0.5*ratio;
    float skewmult = (1.0 / (u_skew + 1.0));
    
    
    float pi = 3.141592653589793642848;
    float s = sin(0.0);
    float c = cos(0.0);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult);
    st = st * rot;

    vec3 color = vec3(0, 0, 0);
    vec3 seco = vec3(1.0, 1.0, 1.0);
    float theta = atan(st.y/st.x);
    if(st.x < 0.0) {
        theta += pi;
    }
    if(floor(mod(floor((theta-(u_time*20.0))/(pi/3.0)), 2.0)) == 0.0) {
    } 
    else {
        
            theta = mod((theta-(u_time*20.0)), (pi)/3.0);
        float a = tan(theta);
        color = seco*a;
        color -= 0.5;
    }

    if(mod(atan(st.y, st.x)+(3.141592653589793642/6.0)+0.01,(3.141592653589793642/3.0)) < 0.02) {
        if(u_skew > 0.0) {
            color.xyz = vec3(1.0, 1.0, 1.0);
        } else {
            color.yz = vec2(1.0);
        }
    }

    if(u_skew < 0.0) {
        color.x = 0.0;
    }
    if(u_dd == 0) {
        color.x = 0.0;
    }

    gl_FragColor = vec4(color,1.0);
}