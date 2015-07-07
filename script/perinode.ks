declare parameter alt.
// create periapsis maneuver node
print "T+" + round(missiontime) + " Periapsis maneuver, orbiting " + body:name.
print "T+" + round(missiontime) + " Apoapsis: " + round(apoapsis/1000) + "km -> " + round(alt/1000) + "km".
print "T+" + round(missiontime) + " Periapsis: " + round(periapsis/1000) + "km".
// constants: mu, rb
run bodyprops.
// present orbit properties
set vom to velocity:orbit:mag.  // actual velocity
set r to rb + altitude.         // actual distance to body
set ra to rb + periapsis.        // radius in periapsis
set va to sqrt( vom^2 + 2*mu*(1/ra - 1/r) ). // velocity in periapsis
set a to (periapsis + 2*rb + apoapsis)/2. // semi major axis present orbit
// future orbit properties
set r2 to rb + periapsis.    // distance after burn at periapsis
set a2 to (alt + 2*rb + periapsis)/2. // semi major axis target orbit
set v2 to sqrt( vom^2 + (mu * (2/r2 - 2/r + 1/a - 1/a2 ) ) ).
// setup node 
set deltav to v2 - va.
print "T+" + round(missiontime) + " Periapsis burn: " + round(va) + ", dv:" + round(deltav) + " -> " + round(v2) + "m/s".
set nd to node(time:seconds + eta:periapsis, 0, 0, deltav).
add nd.
print "T+" + round(missiontime) + " Node created.".

