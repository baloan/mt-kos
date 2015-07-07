declare parameter ecoh.
// ecoh: engine cut-off height
// start descent at periapsis
print "T+" + round(missiontime) + " De-orbit burn starts in " + round(eta:periapsis) + "s".
print "T+" + round(missiontime) + " Setting up ship for maneuver.".
run warpfor(eta:periapsis - 60).
lock steering to retrograde.
wait until abs(retrograde:pitch - facing:pitch) < 0.1 and abs(retrograde:yaw - facing:yaw) < 0.1.
run warpfor(eta:periapsis).
set tset to 0.
lock throttle to tset.
set ga to mu/(rb + periapsis)^2.
set vt to ga * 100.
set v0 to vt * 1.0.
set v1 to vt * 1.2.
clearscreen.
print "T+" + round(missiontime) + " Starting de-orbit burn, decelerate to " + round(vt*1.1) + "m/s.".
set vom to velocity:orbit:mag.
until (abs(altitude-alt:radar) > 1 or (abs(altitude-alt:radar) < 1 and alt:radar < lorb/2)) and vom < vt*1.1 {
    set vom to velocity:orbit:mag.
    if vom > v1 { set tset to 1. }
    if vom > v0 and vom < v1 { set tset to (vom - v0) / (v1 - v0). }
    if vom < v0 { set tset to 0. }
    print "velocity:orbit: " + round(vom) + "  " at (0,35).
    wait 0.01.
}
print "T+" + round(missiontime) + " Radar active, ar: " + round(alt:radar) + ", alt: " + round(altitude).
// emulate retrograde:surface
lock steering to (-ship:velocity:surface):direction + R(0,0,90).
set alt1 to alt:radar.
set alt0 to 150.
set dalt to alt1 - alt0.
set vstart to velocity:surface:mag.
set vend to 30.
until alt:radar < alt0 {
    set vt to ((vstart - vend) * (alt:radar - alt0) / dalt) + vend.
    set v0 to vt * 1.0.
    set v1 to vt * 1.2.
    set vom to velocity:surface:mag.
    if vom > v1 { set tset to 1. }
    if vom > v0 and vom < v1 { set tset to (vom - v0) / (v1 - v0). }
    if vom < v0 { set tset to 0. }
    print "alt:radar: " + round(alt:radar) + "  " at (0,33).
    print "vt: " + round(vt, 1) + "  " at (20,33).
    print "vert: " + round(verticalspeed,1) + "  " at (0,34).
    print "vsfc: " + round(surfacespeed,1) + "  " at (20,34).
    print "vsm: " + round(velocity:surface:mag,1) + "  " at (0,35).
    print "(x,y,z): " + round(velocity:surface:x,1) + "," + round(velocity:surface:y,1) + "," + round(velocity:surface:z,1) + "  " at (20,35).
    wait 0.01.
}
print "T+" + round(missiontime) + " High gate, killing surface speed".
print "T+" + round(missiontime) + " Gear down".
toggle gear.
set alt1 to alt:radar.
set alt0 to 10.
set dalt to alt1 - alt0.
set vstart to -verticalspeed.
set vend to 0.
when surfacespeed < 0.3 and alt:radar < 15 then {
    print "T+" + round(missiontime) + " Low gate, descend for touchdown".
    set alt1 to alt:radar.
    set alt0 to ecoh * 0.6.
    set dalt to alt1 - alt0.
    set vstart to 3.
    set vend to 0.1.
}
set ot to missiontime.
until alt:radar < ecoh * 1.1 {
    // calculate burn vector
    set vup to -1 * body:position:normalized.
    set f to min(surfacespeed, 3).
    set vbrake to vup - (f/3 * velocity:surface:normalized).
    lock steering to vbrake:direction + R(0,0,90).
    // calculate gravitation neutral throttle setting (hover throttle)
    set ga to mu/(rb + altitude)^2.
    set maxa to maxthrust/mass.
    set thover to ga/maxa.
    // calculate throttle
    set vt to ((vstart - vend) * (alt:radar - alt0) / dalt) + vend.
    set vom to -verticalspeed.
    if vom > vt {
        set v1 to vt * 1.5.
        set tset to min(thover + (vom-vt)/(v1-vt) * (1-thover), 1).
    }
    if vom < vt {
        set v0 to vt * 0.5.
        set tset to max((vom-v0)/(vt-v0) * thover, 0).
    }
    if missiontime > ot {
        print "alt:radar: " + round(alt:radar) + "  " at (0,33).
        print "vt: " + round(vt, 1) + "  " at (20,33).
        print "vert: " + round(verticalspeed,1) + "  " at (0,34).
        print "vsfc: " + round(surfacespeed,1) + "  " at (20,34).
        print "vsm: " + round(velocity:surface:mag,1) + "  " at (0,35).
        print "(x,y,z): " + round(velocity:surface:x,1) + "," + round(velocity:surface:y,1) + "," + round(velocity:surface:z,1) + "  " at (20,35).
        set ot to missiontime + 0.5.
    }
    wait 0.01.
}
set tset to 0.
lock steering to up + R(0,0,90).
print "T+" + round(missiontime) + " Wait to settle down - with autopilot using reaction wheels".
set settled to 0.
until settled {
    set old to facing.
    wait 1.
    if abs(old:pitch-facing:pitch) < 0.05 and abs(old:yaw-facing:yaw) < 0.05 and abs(old:roll-facing:roll) < 0.05 {
        set settled to 1.
    }
}
print "T+" + round(missiontime) + " This is " + body:name + " base, " + ship:name + " has landed.".
print "T+" + round(missiontime) + " Fuel after landing: " + round(stage:liquidfuel).
