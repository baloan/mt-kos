declare parameter tgtbody.
// warp until leaving bodies' soi
print "T+" + round(missiontime) + " Waiting to enter SOI of " + tgtbody:name.
set soiflag to False.
run soi(tgtbody).
when body:name = tgtbody:name then {
    print "T+" + round(missiontime) + " Entered SOI of " + body:name.
    set done to 1.
    set soiflag to True.
}
run warpdist(tgtbody, soi).
wait until soiflag.
wait 1.