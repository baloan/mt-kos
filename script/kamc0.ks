// Kerbal automated mission challenge
clearscreen.
run checkvessel("Mun Lander 1b").
copy prep to 1.
toggle gear.      // BUG: KSP requires to toggle gear initially as nop
run bodyprops.
run warpday.
list parts in prts.
when status <> "PRELAUNCH" and stage:solidfuel < 0.1 then { 
    print "T+" + round(missiontime) + " Booster separation.". 
    stage. 
}    
// event handler for staging
set trg2 to 0.
when prts[19]:resources[0]:amount < 0.1 then { 
    if stage:liquidfuel > 0 {
        print "T+" + round(missiontime) + " WARNING! remaining liquidfuel: " + stage:liquidfuel. 
    }
    print "T+" + round(missiontime) + " Stage 1 separation.". 
    stage. 
    set trg2 to missiontime + 1.
}
when trg2 > 0 and missiontime > trg2 then {
    print "T+" + round(missiontime) + " Stage 2 ignition.". 
    stage. 
}
when prts[14]:resources[0]:amount < 0.1 then {
    if stage:liquidfuel > 0 {
        print "T+" + round(missiontime) + " WARNING! remaining liquidfuel: " + stage:liquidfuel. 
    }
    print "T+" + round(missiontime) + " Stage separation and ignition.". 
    stage. 
}
run ltoa.
run hohnode(Mun).
run exenode.
run tts.
run warpinsoi(Mun).
run bodyprops.
// injection
run perinode(rb/2).
run exenode.
// circularise
run perinode(rb/2).
run exenode.
// lower orbit for landing
run landnode(lorb/2).
run exenode.
run landv(3).
