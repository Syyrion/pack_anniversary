uniform vec2 u_resolution;
uniform float u_time;
uniform float u_skew;
uniform float u_rotation;
uniform int u_scanning;
uniform int u_dead;
//inspired by ufo

//this is really ugly but otherwise the floor function acts up on certain machines
float bfloor(float n) {
    n = abs(n);
    int i = -1;
    for(int i = 0; i >-2; i++) {
        if(float(i)>n) {
    		return float(i-1);
        }
    }
    return float(i-1);
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.y;
    st.y -= 0.5;
    float ratio = u_resolution.x/u_resolution.y;
    st.x -= 0.5*ratio;
    float skewmult = (1.0 / (1.0));
    
    
    float pi = 3.141592653589793642848;
    float s = sin(u_rotation);
    float c = cos(u_rotation);
    mat2 rot = mat2(c, s / skewmult, -s, c / skewmult);
    st = st * rot;

    vec3 color = vec3(0, 0, 0);
    vec3 seco = vec3(1.0, 1.0, 1.0);
    float theta = atan(st.y/st.x);
    if(st.x < 0.0) {
        theta += pi;
    }
    if(u_scanning == 1) {
        if(u_skew > 0.0) {
            if(!(bfloor(mod(bfloor((theta-(u_time*(pi*3.0)*1.5))/(pi/3.0)), 2.0)) == 0.0)) {
                
                theta = mod((theta-(u_time*(pi*3.0)*1.5)), (pi)/3.0);
                float a = tan(theta);

                color = seco*a;
                color -= 0.5;
            }
        }
        else {
            if(!(bfloor(mod(bfloor((theta-(-1.0*u_time*(pi*3.0)*1.5))/(pi/3.0)), 2.0)) == 0.0)) {
                
                theta = mod((theta-(-1.0*u_time*(pi*3.0)*1.5)), (pi)/3.0);
                float a = tan(theta);

                color = 1.0-(seco*a);
            }
        }
    }

    if(mod(atan(st.y, st.x)+(3.141592653589793642/6.0)+0.01,(3.141592653589793642/3.0)) < 0.02) {
        if(u_dead == 1) {
            color.xyz = vec3(1.0, 1.0, 1.0);
        }
        else if(u_skew > 0.0) {
            color.xyz = vec3(1.0, 1.0, 1.0);
        } else {
            color.yz = vec2(1.0);
        }
    }

    if(u_skew < 0.0) {
        color.x = 0.0;
    }

    gl_FragColor = vec4(color,1.0);
}