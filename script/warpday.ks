// wait for day, i.e. until dawn
// prerequisite: on the ground
set ps to V(0,0,0) - body:position.
set pk to Sun:position - body:position.
set daynight to vdot(ps, pk).                // positive day , negative night
set eastwest to vdot(pk, velocity:orbit).    // positive when orbiting towards Sun, negative away
set atgt to 90.
if daynight < 0 {
    print "Waiting for sunrise.".
    set a to vang(ps, pk).
    set atgt to 90.
    if eastwest > 0 {
        set adawn to a - atgt.
    } else {
        set adawn to 360 - atgt - a.
    }
    set rp to 2 * pi * ps:mag / velocity:orbit:mag. // rotational period
    set dt to rp/360*adawn.
    run warpfor(dt).
} else {
    print "Nothing to do during daytime.".
}
