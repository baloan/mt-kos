// Mission Control: Mun Minmus Kerbin return
// c) Minmus to Kerbin
clearscreen. 
run bodyprops.
run ltov.
run incnode(Minmus).
run exenode.
run krbnode(600000+15000).
run exenode.
run tts.
run warpoutsoi.
run bodyprops.
print "T+" + round(missiontime) + " Apoapsis: " + round(apoapsis/1000) + " Periapsis: " + round(periapsis/1000) + "km".
wait 1.
run aponode(15000).
if eta:apoapsis > eta:periapsis {
    set nd to nextnode.
    set nd:eta to 60.
}
run exenode.
run tts.
run warpfor(eta:periapsis/2).
run warpdist(Kerbin, rb+ha).
lock steering to retrograde.
when alt:radar < 1000 then {
    print "T+" + round(missiontime) + " Gear down.".
    toggle gear.
}
print "T+" + round(missiontime) + " Waiting for touchdown.".
wait until alt:radar < 5.
print "T+" + round(missiontime) + " Fuel after mission: " + round(stage:liquidfuel).
