declare parameter bd.
// parameter type: body
set sma to (bd:apoapsis + 2*bd:body:radius + bd:periapsis)/2.
set soi to sma*(bd:mu/bd:body:mu)^0.4.
print "soi for " + bd:name + ": " + round(soi/1000) + "km".
