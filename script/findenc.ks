// find transfer orbit to Mun/Minmus
clearscreen.
//remove nextnode.
set target to minmus.
run per1(target:altitude*1.2).
set nd to nextnode.
set eta to nd:eta.
set dv to nd:deltav:mag.
set minper to target:altitude.
set mintime to time:seconds.
// remember closest approach
set found to 0.
set lost to 0.
until lost {
    remove nd.
    set nd to node(time:seconds + eta + 1, 0, 0, dv).
    set eta to nd:eta.
    set n to n+1.
    add nd.
    print "eta:" + eta at (0,30).
    print "encounter:" + encounter at (0,31).
    if encounter = target:name { 
        // print "node:eta: " + round(eta) + ", periapsis: " + round(encounter:periapsis/1000) + "km".
        set found to 1.
        if encounter:periapsis < minper {
            set minper to encounter:periapsis.
            set mineta to time:seconds + eta.
        }
    }
    if encounter = "None" and found = 1 {
        set lost to 1.
    }
}
remove nd.
set nd to node(mineta, 0, 0, dv).
add nd.
print "node:eta: " + round(nd:eta) + ", periapsis: " + round(encounter:periapsis/1000) + "km".
