// warp until leaving bodies' soi
set refbody to body.
print "T+" + round(missiontime) + " Waiting to leave SOI of " + refbody:name.
set soiflag to False.
run soi(refbody).
when body:name <> refbody:name then {
    print "T+" + round(missiontime) + " Entered SOI of " + body:name.
    set done to 1.
    set soiflag to True.
}
run warpdist(refbody, soi).
wait until soiflag.
wait 1.