// by Mark Turner (MarkAndJester).
// Script to change inclination to the initial bearing from where we are to point to a 2nd supplied latlng.
// Maths from http://www.braeunig.us/space/orbmech.htm and http://www.movable-type.co.uk/scripts/latlong.html

set pi to Constant:PI.
set circumference to pi * 2 * (BODY:RADIUS + ALTITUDE).	// C = pi * d.
	
declare parameter p2lat is 10.
declare parameter p2long is 47.	// Set to exact target and not 5 degrees early as with my spotland.ks. Will work out time to descend based on overTarget.
set p2 to LATLNG(p2lat, p2long).

function RADIANS
{
	declare parameter deg.
	local rad is deg * pi / 180.
	return rad.
}

// This function gets run twice. Once to create an ititial node, and a second time with rotation of Mun allowed for.
function calculations
{
	// setup Initial and Final inclination and longitude of AN (Ascending Nodes).
	set incI to ORBIT:INCLINATION.										// Current orbital Inclination.
	set lngI to ORBIT:LONGITUDEOFASCENDINGNODE - Body:ROTATIONANGLE.	// Ascending Node (AN) of currrent orbit.
	// ORBIT:LONGITUDEOFASCENDINGNODE (LAN for short) gives this angle from Solar Prime Meridian and not the current body's LATLNG system!!!
	// Body:ROTATIONANGLE is the current position of 0 longitude in relation to ORBIT:LAN.
	set incF to p2:LAT.
	set lngF to p2:LNG - 90.	// Set AN to 90 degrees before target on 0 degrees latitude.

	// Vector dot product gives angle between 2 vectors.
	set a1 to sin(incI) * cos(lngI).
	set a2 to sin(incI) * sin(lngI).
	set a3 to cos(incI).

	set b1 to sin(incF) * cos(lngF).
	set b2 to sin(incF) * sin(lngF).
	set b3 to cos(incF).

	set inclinationChange to arccos(a1*b1 + a2*b2 + a3*b3).

	// Vector cross product gives normal to plane including 2 vectors.
	set c1 to a2*b3 - a3*b2.
	set c2 to a3*b1 - a1*b3.
	set c3 to a1*b2 - a2*b1.

	set latNode to arctan(c3 / SQRT(c1^2 + c2^2)).
	set lngNode to arctan(c2 / c1).
	if c1 < 0
		set lngNode to lngNode + 90.
	else
		set lngNode to lngNode + 270.
	
	set lngNode to lngNode - 360 * floor(lngNode / 180).	// Convert lngNode from 0 <= lngNode < 360 values into proper -180 < lngNode <= 180 values.
	
	
	// This value is not actually used, but it is good as a check that the node has been created with this value.
	set dV to sqrt(2 * VELOCITY:ORBIT:MAG^2 * ( 1 - cos(inclinationChange))).
	
	
	// Work out distance to node from here and now, then work out time to place node from now.
	// OK to use ALTITUDE which is altitude above mean "sea level" on the Mun.
	set lng1 to SHIP:LONGITUDE.
	set lat1 to SHIP:LATITUDE.
	set lng2 to lngNode.
	set lat2 to latNode.
	
	// Spherical Law of Cosines.
	// Need to convert to radians for this formula : radians = degrees * pi / 180.
	//set distanceToNode to ARCCOS( SIN(lat1 * pi/180)*SIN(lat2 * pi/180) + COS(lat1 * pi/180)*COS(lat2 * pi/180)*COS(lng2 * pi/180 - lng1 * pi/180) ) * (BODY:RADIUS + ALTITUDE).
	
	// haversine (full version of Spherical Law of Cosines). Gives same result as above, but supposedly more accurate over very short or very long distances.
	set dlat to abs(lat2 - lat1).	// Using ABS prevents sqrt -ve value in calculating c.
	set dlng to abs(lng2 - lng1).
	
    //set a to sin(dlat/2) * sin(dlat/2) + cos(lat1) * cos(lat2) * sin(dlng/2) * sin(dlng/2).
	set a to sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlng/2)^2.
    //set c to 2 * arctan2(sqrt(a), sqrt(1-a)).	// c is the angular distance in radians. This is the same as 2*arcsin(sqrt(a)).
	set c to 2 * arcsin(sqrt(a))*pi/180.	// arcsin outputs the angle. The original formula uses radians, but KSP gives arcsin as degrees, hence the conversion.
	set distanceToNode to (BODY:RADIUS + ALTITUDE) * c.
	

	// We will use the angle between the vectors vecShipPrograde and vecShipToNode.
	// If the angle is -ve, then the angle is obtuse (>90deg), and hence behind the ship in it's orbit.
	// e.g. If ship is at 0 deg and heading east, and the node is at -90deg, then VDOT() = -ve.
	// But, if ship is at 0 deg and heading west, and the node is at -90deg, then VDOT() = +ve.
	// So, this will work for both clockwise and anti-clockwise orbits.
	set vecShipToNode to LATLNG(latNode, lngNode):ALTITUDEPOSITION(ALTITUDE).
	set vecShipToNode:MAG to ALTITUDE.
	set vecShipPrograde to v(0,0,ALTITUDE).
	set vecShipPrograde:DIRECTION to SHIP:PROGRADE.
	// Vector drawing for fault-finding.
	//SET VSTT TO VECDRAWARGS(v(0,0,0), vecShipToNode, green, "vecShipToNode", 1, true).
	//SET VSP TO   VECDRAWARGS(v(0,0,0), vecShipPrograde, green, "vecShipPrograde", 1, true).
	if VDOT(vecShipPrograde, vecShipToNode) < 0
		set distanceToNode to circumference - distanceToNode.
		
		
	set timeToNode to distanceToNode / VELOCITY:ORBIT:MAG.

	
	// Now work out corrected heading and burn so there is no altitude change.
	// This is vector math. If we draw 2 vectors v1 and v2 extending out of a point (at the node), and given that we want v1 = v2 after the burn,
	// then we have a triangle with inclinationChange as the angle between v1 and v2, and dV as the distance between the ends of v1 and v2.
	// The back angle then = 180 - inclinationChange / 2. (180 degrees in a triangle).
	set angleRetrograde to (180-ABS(inclinationChange))/2.
	set thrustNormal to VELOCITY:ORBIT:MAG * sin(inclinationChange).
	set thrustPrograde to - ABS(thrustNormal) / tan(angleRetrograde).

	// This creates the node assuming the body does not rotate under the ship before we get there.
	set nd to node(TIME:SECONDS + timeToNode, 0, thrustNormal, thrustPrograde).
	add nd.
}

function printing
{
	print "Ship                  : LATLNG(" + round(lat1) + ", " + round(lng1) + ")".
	print "Node                  : LATLNG(" + round(lat2) + ", " + round(lng2) + ")".
	print "Target location       : LATLNG(" + round(p2:LAT) + ", " + round(p2:LNG) + ")".
	print "Inclination now       : " + round(incI, 2).
	print "Inclination new       : " + round(incF, 2).
	print "Ascending node now    : LATLNG(0, " + round(lngI) + ")".
	print "Ascending node new    : LATLNG(0, " + round(lngF) + ")".
	print "Angle Change          : " + round(inclinationChange, 2).
	print "dV for change         : " + round(dV, 2).
	print "distance to node      : " + round(distanceToNode).
	print "circumference at alt  : " + round(circumference).
	print "time to node          : " + round(timeToNode).
	print "angleRetrograde       : " + round(angleRetrograde, 2).
	print "thrustNormal          : " + round(thrustNormal, 2).
	print "thrustPrograde        : " + round(thrustPrograde, 2).
}

clearscreen.
calculations().
printing().

print " ".
print "Adjust target longitude to allow for".
print "rotation whilst maneuvers are performed,".
print "plus 1 full rotation of the orbit to".
print "apoapsis burn to lower periapsis for".
print "landing 180deg before the target.".
print " ".

set OrbitalPeriod to 2 * pi * sqrt(VELOCITY:ORBIT:MAG^3 / BODY:MU).

// Adjust for the body we are orbiting to rotate under us whilst we cruise to the node.
set shiptonodedegrees to 360 * timeToNode / BODY:ROTATIONPERIOD.
set adjustforshiptonodeseconds to sin(90 - ABS(ORBIT:INCLINATION)) * OrbitalPeriod * shiptonodedegrees / 360.
// Adjust for the body we are orbiting to rotate during the descent to periapsis to land with "run spotland(lat, lng)." after the node is created.
// Calculate node to target time, then add 1 orbit, as the target is 90 degrees after the ascending node, unlike the landlongnode / 2 !!!
// landlongnode creates a periapsis 7km above the mun above the target. Hence we fire the motor 180 degrees at the apoapsis.

	// haversine to find distance from the node to the target, and hence the time the target will move whilst we fly to it from the node.
	set lng1 to lngNode.
	set lat1 to latNode.
	set lng2 to p2:LNG.
	set lat2 to p2:LAT.
	set dlat to abs(lat2 - lat1).	// Using ABS prevents sqrt -ve value in calculating c.
	set dlng to abs(lng2 - lng1).
	
    set a to sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlng/2)^2.
	set c to 2 * arcsin(sqrt(a))*pi/180.	// arcsin outputs the angle. The original formula uses radians, but KSP gives arcsin as degrees, hence the conversion.
	set distanceNodeToTarget to (BODY:RADIUS + ALTITUDE) * c.

	// Target may be > 180 degrees from the node, but distanceNodeToTarget is measuring the distance of the short (retrograde) direction to the target!
	// erm, I will have to do this later... I need to create a vector from this node in the new PROGRADE direction...
	//if VDOT(vecNodePrograde, vecNodeToTarget) < 0
	//	set distanceNodeToTarget to circumference - distanceNodeToTarget.
	
	set timeNodeToTarget to distanceNodeToTarget / VELOCITY:ORBIT:MAG.

// The new node's inclination (nd:ORBIT:INCLINATION) is the same as the LAT of the target.
set adjustfororbitdegrees to 360 * (nd:ORBIT:PERIOD + timeNodeToTarget) / BODY:ROTATIONPERIOD.
set adjustfororbitseconds to sin(90 - ABS(ORBIT:INCLINATION)) * OrbitalPeriod * adjustfororbitdegrees / 360.

set p2lngadjustment to shiptonodedegrees + adjustfororbitdegrees.
print "Longitude adjustment  : " + round(p2lngadjustment, 2).	// Total longitude the target will move by before we reach the target.
set p2 to LATLNG(p2lat, p2long + p2lngadjustment).

// Now re-calculate based on adjusted longitude. This is not exact, as the time to node will change, but it will be pretty damn close now.
remove nd.
calculations().
printing().

set timeOverTarget to TIME:SECONDS + timeToNode + adjustforshiptonodeseconds + adjustfororbitseconds.
set timeAtTarget to timeOverTarget - TIME:SECONDS.

// Vector drawing for fault-finding.
//set nodePos to positionat(SHIP, TIME:SECONDS + timeToNode).
//set drawPos to VECDRAWARGS(v(0,0,0), nodePos, red, "timeToNode false node", 1, true).

//set spot to LATLNG(lat2, lng2).
//set vecspot to spot:ALTITUDEPOSITION(ALTITUDE).
//SET VD TO VECDRAWARGS(v(0,0,0), vecspot, green, "true node", 1, true).

SAS off.
set steer to nd.
LOCK STEERING to steer.
