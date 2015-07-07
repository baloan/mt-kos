declare parameter refbody, tgtbody.
// calculate wait time for planetary alignment
print "T+" + round(missiontime) + " Hohmann window from " + refbody:name + " to " + tgtbody:body:name.
if refbody:body:name <> tgtbody:body:name {
    print "T+" + round(missiontime) + " ERROR! " + refbody:name + " and " + tgtbody:name + " have different parent bodies".
    print "T+" + round(missiontime) + " refbody: " + refbody:name + ": " + refbody:body:name.
    print "T+" + round(missiontime) + " tgtbody: " + tgtbody:name + ": " + tgtbody:body:name.
    // end program
}
// move origin to central body (i.e. Kerbin)
set ctrbody to refbody:body.
set p0ref to refbody:position - ctrbody:position.
set p0tgt to tgtbody:position - ctrbody:position.
// orbital periods
set smaref to (2*ctrbody:radius + refbody:apoapsis + refbody:periapsis)/2.
set smatgt to (2*ctrbody:radius + tgtbody:apoapsis + tgtbody:periapsis)/2.
set opref to 2*pi*sqrt(smaref^3/ctrbody:mu).
set optgt to 2*pi*sqrt(smatgt^3/ctrbody:mu).
// Hohmann transfer orbit period
set smahoh to (smaref + smatgt)/2.      // use average altitude
set ophoh to 2*pi*sqrt(smahoh^3/ctrbody:mu).
set thoh to ophoh/2.                    // time of Hohmann transfer
// relative orbital angle
set atgt0 to vang(p0ref, p0tgt).       // TODO: make safe 360deg
set tla to 360*thoh/optgt.             // target's lead angle 
// find time when atgt(t) + tla = aref(t) + 180' 
// atgt(t) = atgt(0) + 360*t/optgt; aref(t) = aref(0) + 360*t/opref
// atgt(0) + 360*t/optgt + tla = aref(0) + 360*t/opref + 180'
// t = (aref(0)+180'-atgt(0)-tla)/(360*(1/optgt-1/opref)); aref(0) = 0
set talign to (180-atgt0-tla)/(360*(1/optgt-1/opref)).
print "T+" + round(missiontime) + " " + refbody:name + ", at 0', orbit in " + round(opref/60) + "min".
print "T+" + round(missiontime) + " " + tgtbody:name + ", at " + round(atgt0) + "', orbit in " + round(optgt/60) + "min".
print "T+" + round(missiontime) + " + travels " + round(tla) + "' during transfer " + round(thoh/60) + "min.".
print "T+" + round(missiontime) + " Transfer window in " + round(talign/60) + "min".
