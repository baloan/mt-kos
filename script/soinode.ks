declare parameter aeject, vhe.
// aeject: body:prograde: +90 or body:retrograde: -90 escape orbit
// vhe: hyperbolic excess velocity
// prerequisite: ship in circular orbit
// calculate ship angular position for maneuver, move origin to central body (i.e. Mun)
set ps to V(0,0,0) - body:position.
set pc to body:body:position - body:position.
// angular positions
set ac to arctan2(pc:x,pc:z).
set as0 to arctan2(ps:x,ps:z).
// calculate deltav
print "T+" + round(missiontime) + " Periapsis maneuver, orbiting " + body:name.
print "T+" + round(missiontime) + " Apoapsis: " + round(apoapsis/1000) + "km -> soi excess " + round(vhe).
print "T+" + round(missiontime) + " Periapsis: " + round(periapsis/1000) + "km".
// present orbit properties
set ra to rb + (periapsis+apoapsis)/2.  // average radius (burn angle not yet known)
set vom to velocity:orbit:mag.          // actual velocity
set r to rb + altitude.                 // actual distance to body
set va to sqrt( vom^2 - 2*mu*(1/ra - 1/r) ). // average velocity 
// after burn velocity for desired velocity at soi 
set v2 to sqrt(vhe^2 - 2*mu*(1/soi - 1/ra)).
set deltav to v2 - va.
print "T+" + round(missiontime) + " Periapsis burn: " + round(va) + ", dv:" + round(deltav) + " -> " + round(v2) + "m/s".
// calculate burn angle (see also http://www.braeunig.us/space/orbmech.htm#hyperbolic)
set soe to v2^2/2 - mu/ra.              // specific orbital energy
set h to ra * v2.
set e to sqrt(1+(2*soe*(h/mu)^2)).      // eccentricity of hyperbolic orbit
set tai to arccos(-1/e).                // angle between the periapsis vector and the departure asymptote
set sma to -mu/(2*soe).
set ip to -sma/tan(arcsin(1/e)).        // impact parameter 
set aip to arctan(ip/soi).              // angle to turn leaving mun soi point on mun orbit
set asoi to tai - aip.
set aburn to ac + aeject + asoi.
set sma to (periapsis + 2*rb + apoapsis)/2. // semi major axis present orbit
set ops to 2 * pi * sqrt(sma^3/mu).      // ship orbital period
until aburn < as0 { set aburn to aburn - 360. }
set eta to (as0 - aburn)/360 * ops.
if eta < 60 { 
    set eta to eta + ops.
    print "T+" + round(missiontime) + " too close for maneuver, waiting for one orbit, " + round(ops/60,1) + "m".
}
print "T+" + round(missiontime) + " ship, orbital period: " + round(ops/60,1) + "m".
print "T+" + round(missiontime) + " | now: " + round(as0) + "', maneuver: " + round(aburn) + "' in " + round(eta/60,1) + "m".
set nd to node(time:seconds + eta, 0, 0, deltav).
add nd.
print "T+" + round(missiontime) + " Node created.".

