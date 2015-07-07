declare parameter tgtperi.
// setup a Hohmann transfer orbit from Mun/Minmus to Kerbin
// prerequisite: ship in circular orbit
print "T+" + round(missiontime) + " Hohmann transfer to Kerbin, orbiting " + body:name.
// move origin to central body (i.e. Kerbin)
set ps to V(0,0,0) - body:position.
set pk to body:body:position - body:position.
// hohmann orbit properties, s: ship, m: mun, 0: mun orbit, 1: hohmann transfer, 2: earth orbit
// major semi axis
set sma1 to pk:mag.
set smah to ( pk:mag + tgtperi )/2.
set vmun to sqrt(body:body:mu / pk:mag).   // Mun's orbital velocity
set vh to sqrt(vmun^2 - body:body:mu * (1/smah - 1/sma1)). // Hohmann velocity
set vhe to vmun - vh.                   // hyperbolic excess velocity
print "T+" + round(missiontime) + " " + body:name + ": " + round(vmun) + ", Hohmann: " + round(vh) + " m/s".
print "T+" + round(missiontime) + " Hyperbolic excess: " + round(vhe) + " m/s".
if body:name = "Mun" {
    set aeject to -99.
}
if body:name = "Minmus" {
    set aeject to -93.
}
print "T+" + round(missiontime) + " Ejection angle " + round(aeject) + " deg".
set done to 0.
until done {
    run soinode(aeject, vhe).
    // CAVEAT: Kerbin does not register as encounter so encounter reports "None". Extend for other planets.
    if encounter = "None" {
        set done to 1.
    } else {
        print "T+" + round(missiontime) + " entering " + encounter + " soi during transfer, waiting one orbit.".
        run warpfor(ops).     // dirty: using soinode's variable
        remove nextnode.
    }
}
