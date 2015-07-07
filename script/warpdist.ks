declare parameter refbody, dist.
// warp until crossing distance 
// warp    (0:1) (1:5) (2:10) (3:50) (4:100) (5:1000) (6:10000) (7:100000)
// min alt        atmo   atmo   atmo    120k     240k      480k       600k
print "T+" + round(missiontime) + " Waiting to crossing " + round(dist/1000) + "km of " + refbody:name.
print "T+" + round(missiontime) + " Wait start: " + time:calendar + ", " + time:clock.
set done to 0.
set dist0 to refbody:position:mag.
if dist0 > dist {
    set dir to -1.
    set f to 5.
    when refbody:position:mag < dist then {
        print "T+" + round(missiontime) + " Closer than " + round(dist/1000) + "km".
        set done to 1.
    }
} else {
    set dir to +1.
    set f to 1.
    when refbody:position:mag > dist then {
        print "T+" + round(missiontime) + " Farther than " + round(dist/1000) + "km".
        set done to 1.
    }
}
set wp to 0.
set oldwp to 0.
set oldwarp to warp.
set dist0 to refbody:position:mag.
set td0 to missiontime.
until done {
    set wp0 to warp.
    set wf to 1.
    if wp0 = 1 { set wf to 5. }
    if wp0 = 2 { set wf to 10. }
    if wp0 = 3 { set wf to 50. }
    if wp0 = 4 { set wf to 100. }
    if wp0 = 5 { set wf to 1000. }
    if wp0 = 6 { set wf to 10000. }
    if wp0 = 7 { set wf to 100000. }
    if missiontime > td0 + wf/4 {
        // calculate radial velocity
        set dist1 to refbody:position:mag.
        set td1 to missiontime.
        set vr to (dist1 - dist0) / (td1 - td0).   // radial velocity, vr > 0 is out
        set rt to (dist - dist1) / vr.             // remaining time to soi
        // print "dr: " + round((dist1-dist0)/1000) + ", dt: " + round(td1-td0) + ", vr: " + round(vr) + ", rt: " + round(rt).
        set wp to 0.
        if rt > f * 5      { set wp to 1. }
        if rt > f * 10     { set wp to 2. }
        if rt > f * 50     { set wp to 3. }
        if rt > f * 100    { set wp to 4. }
        if rt > f * 1000   { set wp to 5. }
        if rt > f * 10000  { set wp to 6. }
        if rt > f * 100000 { set wp to 7. }
        if wp0 <> wp {
            set warp to wp.
            wait 0.1.
        }
        set dist0 to refbody:position:mag.
        set td0 to missiontime.
    }
    if wp <> oldwp or warp <> oldwarp {
        set pctsoi to refbody:position:mag/dist.
        set oldwp to wp.
        set oldwarp to warp.
        print "T+" + round(missiontime) + " Warp " + oldwarp + "/" + wp + ", at " + round(pctsoi*100) + "% soi, remaining: " + round(rt/60) + "min".
    }
    wait 0.1.
}
set warp to 0.
// set dt to time:seconds - t0.
print "T+" + round(missiontime) + " Wait end: " + time:calendar + ", " + time:clock.
