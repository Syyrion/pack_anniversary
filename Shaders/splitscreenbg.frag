uniform vec2 u_resolution;
uniform float u_time;

// (a|x|^b+d/c)^(1-2d)
uniform vec4 u_s1_fnarg;
uniform vec4 u_s2_fnarg;
// Scroll Speed, Pattern Size, Dark%, DarkMult
uniform vec4 u_s1_scarg;
uniform vec4 u_s2_scarg;

// 2^3: S1 3 Sided, 2^2: S1 Rev Loop, 2^1: S2 3 Sided, 2^0: S2 Rev Loop
uniform int u_colconf;
// r,g,b
uniform vec3 u_s1_col1;
uniform vec3 u_s1_col2;
uniform vec3 u_s1_col3;
uniform vec3 u_s2_col1;
uniform vec3 u_s2_col2;
uniform vec3 u_s2_col3;

uniform float u_s1_sides;
uniform float u_s1_angle;
uniform float u_s1_skew;
uniform float u_s2_sides;
uniform float u_s2_angle;
uniform float u_s2_skew;

#define PI acos(-1.)
#define HASBIT(n,b) (mod(floor(float(n)/pow(2.,b)),2.)>.5)

float fn(float t, vec4 args) {
    return sign(args.x)*pow(abs(args.x)*pow(abs(t),args.y)+args.w/args.z,1.-2.*args.w);
}

vec3 getSegColor(mat3 colors, float seg, bool use3, bool rev) {
    int index = 0;
    if(!rev) index = int(mod(seg,use3?3.:2.));
    else for(int i=0; i<16; i++) {
        int dir = mod(float(i)/(use3?3.:2.),2.)<1.?1:0;
        if(i == int(seg) || i > int(seg)) {index += dir-1; break;}
        index += dir*2-1;
    }
    return index==0 ? colors[0] : index==1 ? colors[1] : colors[2];
}

void main() {
    // Coord & Var Setup
    vec2 grid = gl_FragCoord.xy/u_resolution.xy * vec2(2.) - vec2(1.);
    bool scr = grid.y > 0.;
    float sides = scr ? u_s1_sides : u_s2_sides;
    float angle = scr ? u_s1_angle : u_s2_angle;
    float skew  = scr ? u_s1_skew  : u_s2_skew;
    vec4  fnarg = scr ? u_s1_fnarg : u_s2_fnarg;
    vec4  scarg = scr ? u_s1_scarg : u_s2_scarg;
    mat3 colors = scr ? mat3(u_s1_col1,u_s1_col2,u_s1_col3):
    					mat3(u_s2_col1,u_s2_col2,u_s2_col3);
    grid = .5*vec2(2.*grid.x,2.*mod(grid.y,1.)-1.);
    grid *= mat2(
    	 cos(angle) * u_resolution.x/u_resolution.y, sin(angle) * skew,
        -sin(angle) * u_resolution.x/u_resolution.y, cos(angle) * skew
    );
    
    // Segment Setup
    float ang = PI+atan(-grid.y,-grid.x);
    float seg = floor(sides*ang/PI/2.);
    ang = 2.*PI/sides*(seg-1.-(sides-6.)/4.);
    grid *= mat2(cos(ang),sin(ang),-sin(ang),cos(ang));
    
    // Color Calculation
    vec3 color = getSegColor(colors,seg,HASBIT(u_colconf,scr?3.:1.),HASBIT(u_colconf,scr?2.:0.));
    color = mix(vec3(0.),color,mod(fn(grid.x,fnarg)+grid.y+u_time*scarg.x,scarg.y)>scarg.y*scarg.z?1.:scarg.w);
    gl_FragColor = vec4(color,1.);
}