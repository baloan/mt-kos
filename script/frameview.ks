// display ship & mun coordinates
// note change in mun dv when ship is in kerbin orbit < 100km 
clearscreen.
set trgt to Mun.
until 0 {
    set pm0 to trgt:position - body:position.
    set ps0 to V(0,0,0) - body:position.
    wait 1.

    set pm to trgt:position - body:position.
    set ps to V(0,0,0) - body:position.
    set vm to pm - pm0.
    // print "Mun: " + pm.
    set pmu to (1/pm:mag)*pm.
    print trgt:name at (0,25).
    print "   P(" + round(pm:x/1000,4) + "," + round(pm:y/1000,4) + "," + round(pm:z/1000,4) + ")" at (0,26).
    print "|p|: " + round(sqrt(pm:x^2+pm:y^2+pm:z^2)/1000) at (30,26).
    print "Pbar(" + round(pmu:x,4) + "," + round(pmu:y,4) + "," + round(pmu:z,4) + ")" at (0,27).
    print "   v(" + round(vm:x,4) + "," + round(vm:y,4) + "," + round(vm:z,4) + ")" at (0,28).
    print "|v|: " + round(vm:mag) at (30,28).
    set ma to arctan(pmu:x/pmu:z).
    if pmu:z < 0 { set ma to ma + 180. }
    print "omg: " + round(ma,3) at (30,27).
    
    set vs to ps - ps0.
    // print "Ship: " + ps.
    set psu to (1/ps:mag)*ps.
    set sa to arctan2(psu:x,psu:z).
    if psu:z < 0 { set sa to sa + 180. }
    print "Ship" at (0,31).
    print "   P(" + round(ps:x/1000,4) + "," + round(ps:y/1000,4) + "," + round(ps:z/1000,4) + ")" at (0,32).
    print "|p|: " + round(ps:mag/1000) at (30,32).
    print "Pbar(" + round(psu:x,4) + "," + round(psu:y,4) + "," + round(psu:z,4) + ")" at (0,33).
    print "   v(" + round(vs:x,4) + "," + round(vs:y,4) + "," + round(vs:z,4) + ")" at (0,34).
    print "|v|: " + round(vs:mag) at (30,34).
    set sa to arctan(psu:x/psu:z).
    if psu:z < 0 { set sa to sa + 180. }
    print "omg: " + round(sa,3) at (30,33).
}

