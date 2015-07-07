// launch to orbit in vacuum (no atmosphere)
set ov to sqrt(mu/rb).           // orbital velocity for circular orbit
print "Orbit v: " + round(ov) + " for low " + body:name + " orbit in " + round(lorb/1000) + "km".
print "T+" + round(missiontime) + " All systems GO!".
wait 1.
print "T+" + round(missiontime) + " Ignition.".
lock steering to up + R(0, 0, 90).
// takeoff thrust
set r to rb + altitude.
set ag to mu/r^2.          // gravitational accelaration
set ta to maxthrust/mass.  // thrust accelaration
lock throttle to min(15*ag/ta, 1).
wait (1-altitude/lorb)*4.
print "T+" + round(missiontime) + " Orbital orientation turn".
// control speed and attitude
set ot to round(missiontime).
until apoapsis > lorb {
    set ar to alt:radar.
    set vsm to velocity:surface:mag.
    // control attitude
    set r to rb + altitude.
    set ag to mu/r^2.          // gravitational accelaration
    set vt2 to velocity:orbit:mag^2 - verticalspeed^2. // tangential velocity
    set ac to vt2/r.           // centrifugal accelaration
    set avert to ag - ac.      // vertical external acceleration
    set ta to maxthrust/mass.  // thrust accelaration
    set yaw to arccos(avert/ta).
    set np to up + R(0, -yaw, 90).
    lock steering to np.
    if abs(sin(np:pitch) - sin(facing:pitch)) < 0.03 and abs(sin(np:yaw) - sin(facing:yaw)) < 0.03 and throttle < 1 {
        lock throttle to 1.
        print "T+" + round(missiontime) + " Full thrust. Gear up.".
        toggle gear.
    }
    // dashboard
    print "alt:radar: " + round(ar) + "  " at (0,32).
    print "altitude: " + round(altitude) + "  " at (20,32).
    print "v:orbit: " + round(velocity:orbit:mag) + "  " at (0,33).
    print "vt: " + round(sqrt(vt2)) + "  " at (20,33).
    print "yaw: " + round(yaw) + "  " at (0,34).
    print "apoapis: " + round(apoapsis/1000,1) + "  " at (0,35).
    print "periapis: " + round(periapsis/1000,1) + "  " at (20,35).
    wait 0.1.
}
lock throttle to 0.
print "T+" + round(missiontime) + " Apoapsis at " + round(apoapsis/1000,2) + "km".
set np to up + R(0, -yaw, 0).
wait until abs(sin(np:pitch) - sin(facing:pitch)) < 0.02 and abs(sin(np:yaw) - sin(facing:yaw)) < 0.02 and abs(sin(np:roll) - sin(facing:roll)) < 0.02.
wait 1.                 // BUG: without this wait aponode calculations are incorrect!
run aponode(apoapsis).
run exenode.
