// Mission Control: Mun Minmus Kerbin return
// b) Mun to Minmus
clearscreen. 
run bodyprops.
// avoid running out of electricity on the dark side
run ltov.
// perform a Hohmann transfer orbit (moon - moon, planet - planet)
// wait for next hohmann transfer orbit alignment
run hmxalign(Mun, Minmus).
run waitfor(hmxalign).
// prepare inclination for burn
run hmxinc(Mun, Minmus).
run exenode.
// transfer burn
run soinode(+90, vhe).
run exenode.
run tts.
run warpoutsoi.
run warpinsoi(Minmus).
// insertion burn
run perinode(rb/2).
run exenode.
// circularise
run bodyprops.
run perinode(rb/2).
