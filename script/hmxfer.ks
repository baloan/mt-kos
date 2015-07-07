declare parameter refbody, tgtbody.
// perform a Hohmann transfer orbit (moon - moon, planet - planet)
// wait for next hohmann transfer orbit alignment
run hmxalign(refbody, tgtbody).
run waitfor(hmxalign).
// prepare inclination for burn
run incnode(refbody, tgtbody).
run exenode.
// transfer burn
run soinode(+90, vhe).
run exenode.
// hohmann transfer
run warpinsoi(tgtbody).
// insertion burn
run perinode(rb/2).
run exenode.
// circularise
run bodyprops.
run perinode(rb/2).
