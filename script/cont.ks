clearscreen.
run bodyprops.
when status <> "PRELAUNCH" and stage:solidfuel < 0.1 then { 
    print "T+" + round(missiontime) + " Booster separation.". 
    stage. 
}    
// event handler for staging
set trg2 to 0.
when status <> "PRELAUNCH" and stage:liquidfuel < 0.1 then { 
    if stage:liquidfuel > 0 {
        print "T+" + round(missiontime) + " WARNING! remaining liquidfuel: " + stage:liquidfuel. 
    }
    print "T+" + round(missiontime) + " Stage 1 separation.". 
    stage. 
    print "stage complete.". 
    set trg2 to missiontime + 2.
    print "when complete.". 
}
when trg2 > 0 and missiontime > trg2 then {
    print "T+" + round(missiontime) + " Stage 2 ignition.". 
    stage. 
    print "when complete.". 
}
run ltoa.
