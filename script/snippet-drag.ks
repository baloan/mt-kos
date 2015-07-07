set solidthrust to 4*250.
set liquidthrust to 2*215.
set drag to 0.
set t0vsm to velocity:surface:mag.
set t0 to time:seconds.
    // calculate acceleration and drag
    set dt to time:seconds-t0.
    set vsm to velocity:surface:mag.
    if dt > 1 {
        set dv to vsm - t0vsm.
        set da to dv/dt.
        // thrust acceleration ta, gravity acceleration ga
        if stage:solidfuel > 0 {
            set ta to (throttle * liquidthrust + solidthrust)/mass.
        }
        if stage:solidfuel = 0 {
            set ta to (throttle * maxthrust)/mass.
        }
        set ga to mu/(rb + altitude)^2.
        set drag to (ta - ga * cos(theta)) - da.
        set dc to drag * mass / vsm^2 * 1000.          // coefficient of drag
        // print "da: " + round(da,1) + "  " at (0,30).
        // print "ta: " + round(ta,1) + "  " at (10,30).
        // print "ga: " + round(ga,1)  + "  " at (20,30).
        // print "drag: " + round(drag,1) + "  "  at (30,30).
        // print "dc: " + round(dc,2) + "  "  at (30,31).
        set t0vsm to velocity:surface:mag.
        set t0 to time:seconds.
    }
