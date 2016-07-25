// By Mark Turner (MarkAndJester).
// Script to spot land at a designated LAT/LONG on the Mun.
// Note: you must have a pretty good periapsis overhead to begin with.
// i.e. use "run prep. run landlongnode." first.

declare parameter targetlat is 0.	//-0.096944 - 0.03. // About 100m south of launchpad at KSC.
declare parameter targetlong is 47.	//-74.5575.
set landingtarget to LATLNG(targetlat, targetlong).

set pi to Constant:PI.

clearscreen.
sas off.
rcs on.	// This may be an option for some landers without a good gyro???
set steer to HEADING(270,0).
lock STEERING to steer.
set throt to 0.
lock THROTTLE to throt.

set kp to 0.5.
set ki to 0.
set kd to 0.
set PIDthrottle1 to PIDLOOP(kp, ki, kd, 0, 1).
set PIDthrottle2 to PIDLOOP(kp, ki, kd, 0, 1).	// Need to have a clean PID for the final 100m descent phase.

set currentAltitude to ALT:RADAR.
set LandingSiteMultiplier to 0.
set currentDistance to 0.

set runmode to 81.

until STATUS = "LANDED" or STATUS = "SPLASHED"
{	
	if runmode = 80	// Fire engines to fly closer to target before final descent.
	{						
		set LandingMode to "Power towards target.   ".
		set vecBoostBack to landingtarget:ALTITUDEPOSITION(max(landingtarget:TERRAINHEIGHT, 0) + currentAltitude * 1.30).
		set vecSurfaceVelocity2 to VELOCITY:SURFACE.
		set homeangle to VANG(vecBoostBack, vecSurfaceVelocity2).

		set vecBoostBack:MAG to 10.
		set vecSurfaceVelocity2:MAG to 10.
		set drawvecSurfaceVelocity to VECDRAWARGS(V(0,0,0), vecSurfaceVelocity2, blue, "Surface Velocity", 1, true).
		set drawvecsteer to VECDRAWARGS(V(0,0,0), vecBoostBack, red, "Steer above landing target", 1, true).
		
		set vecLandingSite to landingtarget:ALTITUDEPOSITION(landingtarget:TERRAINHEIGHT).
		set drawvecLandingSite to VECDRAWARGS(V(0,0,0), vecLandingSite, yellow, "Landing Site", 1, true).
		
		// Once heading in the right direction with sufficient speed, set to coast.
		if homeangle < 45 and AIRSPEED > landingtarget:DISTANCE / 100
		{
			set runmode to 81.
			set drawvecSurfaceVelocity:show to FALSE.
		}
		else
		{
			set steer to vecBoostBack.
			set throt to 1.
			set drawvecsteer:show to TRUE.
			set drawvecSurfaceVelocity:show to TRUE.
		}.
	}.
	
	if runmode = 81	// Coast back.
	{
		set LandingMode to "Coasting towards target.".
		set throt to 0.
		set steer to SRFRETROGRADE.
		
		set vecLandingSite to landingtarget:ALTITUDEPOSITION(landingtarget:TERRAINHEIGHT).
		set drawvecLandingSite to VECDRAWARGS(V(0,0,0), vecLandingSite, yellow, "Landing Site", 1, true).

		set vF to 0.
		set vI to GROUNDSPEED.
		set a to SHIP:MAXTHRUST/SHIP:MASS.
		set d to ABS((vF^2 - vI^2) / (2 * a)).	// Gives slam speed not taking into account change in mass via the Tsiolkovsky rocket equation!
		
		// haversine measures curved distance between points.
			set lng1 to SHIP:LONGITUDE.
			set lat1 to SHIP:LATITUDE.
			set lng2 to targetlong.
			set lat2 to targetlat.
			set dlat to abs(lat2 - lat1).
			set dlng to abs(lng2 - lng1).
			set a to sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlng/2)^2.
			set c to 2 * arcsin(sqrt(a))*pi/180.
			set currentDistance to (BODY:RADIUS + ALTITUDE) * c.
		
		if currentDistance <= d * 2	or currentDistance < 100 //25000
		{
			set runmode to 90.
			set lastDistance to currentDistance.
		}.
    }.
	
	
	if runmode = 90	// Descend and land.
	{
		if ALT:RADAR > 1000
		{                
			// haversine measures curved distance between points.
			set lng1 to SHIP:LONGITUDE.
			set lat1 to SHIP:LATITUDE.
			set lng2 to targetlong.
			set lat2 to targetlat.
			set dlat to abs(lat2 - lat1).
			set dlng to abs(lng2 - lng1).
			set a to sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlng/2)^2.
			set c to 2 * arcsin(sqrt(a))*pi/180.
			set currentDistance to (BODY:RADIUS + ALTITUDE) * c.
			
		
			set LandingMode to "Descending to 1000m.    ".
			set vecUP to V(0,0,1).
			set vecUP:DIRECTION to UP.
			if ALT:RADAR > 1000
				set vecUP:MAG to -VERTICALSPEED / 5.	// Keeps vertical speed to about - 15m/s during deceleration.
			else
				set vecUP:MAG to 22.					// Until below 1000ft. Then this forces UP vector to not flip over low to the ground.
			set LandingSiteMultiplier to 8.
			
			if currentDistance > lastDistance and currentDistance > 1000	// Oops, started burn too late and overshot the target. Keep burning until coming back.
			{
				set runmode to 80.
				//set throt to 1.
			}
			else
			{
				set PIDthrottle1:SETPOINT TO GROUNDSPEED + 10000.	// The PID shits itself with tiny or swinging +ve to -ve values, so add 10000...
				set throt to PIDthrottle1:UPDATE(TIME:SECONDS, (currentDistance / 25) + 10000).
			}.
			set lastDistance to currentDistance.
		}
		else	// if ALT:RADAR < 1000 then set AIRSPEED (and not GROUNDSPEED nor -VERTICALSPEED) to -ALT:RADAR/10.
		{						
			set LandingMode to "Final 1000m descent.    ".
			GEAR ON.
			set vecUP to V(0,0,1).
			set vecUP:DIRECTION to UP.
			set vecUP:MAG to 22.					// Forces UP vector to not flip over low to the ground.
			set LandingSiteMultiplier to 10.		// Strengthens the pull to the target.
			set PIDthrottle2:SETPOINT TO AIRSPEED + 10000.	// Slow to the AIRSPEED, so set this as the setpoint. Adding 10000 to prevent low/-ve values.
			set throt to PIDthrottle2:UPDATE(TIME:SECONDS, ALT:RADAR/10 + 10000).
		}.
		
		set vecLandingSite to landingtarget:ALTITUDEPOSITION(landingtarget:TERRAINHEIGHT).
		set drawvecLandingSite to VECDRAWARGS(V(0,0,0), vecLandingSite, yellow, "Landing Site", 1, true).
		set vecLandingSite:MAG to LandingSiteMultiplier.//vecLandingSite:MAG/50..
	
		set vecSurfaceVelocity to -VELOCITY:SURFACE.
		set vecSurfaceVelocity:MAG to 10.			// Using 10 instead of 1 so when drawn it sticks out of the craft.
		
		set steer2 to vecLandingSite + vecSurfaceVelocity + vecUP.
		
		set vecAlwaysUP to V(0,0,1).
		set vecAlwaysUP:DIRECTION to UP.
		if ALT:RADAR <= 1000 and VANG(steer2, vecAlwaysUP) > 90	// Forces the ship to be pointing away from the ground when at low altitude.
		{
			// Mirror V' steer vector V about a plane with normal n. V'=V-2*n*(V dot n)/|n|^2
			set steer to steer2 - 2 * vecAlwaysUP:NORMALIZED * vdot(steer2, vecAlwaysUP:NORMALIZED)/vecAlwaysUP:NORMALIZED:MAG^2.
			print "Upside down!" at (5, 15).
		}
		else
		{
			set steer to steer2.
			print "           " at (5, 15).
		}.
	
		set drawvecsteer to VECDRAWARGS(V(0,0,0), steer, red, "steer", 1, true).
		set drawvecUP to VECDRAWARGS(V(0,0,0), vecUP, blue, "UP", 1, true).
		set drawvecLandingSite2 to VECDRAWARGS(V(0,0,0), vecLandingSite, blue, "LandingSite", 1, true).
		set drawvecSurfaceVelocity to VECDRAWARGS(V(0,0,0), vecSurfaceVelocity, blue, "-SurfaceVelocity", 1, true).
		
		wait 0.
	}.
	
		// Print stuff.
		print "Program : " + LandingMode at (5,1).
		print "Horizontal distance : " + round(currentDistance) + "     " at (5,3).
		print "Ground speed x 25   : " + round(GROUNDSPEED * 25) + "     " at (5,4).
		print "Ground speed(Horiz) : " + round(GROUNDSPEED) + "     " at (5,5).
		print "Vertical Speed      : " + round(VERTICALSPEED, 1) + "     " at (5, 6).
		print "Radar altitude      : " + round(ALT:RADAR) + "     " at (5,7).
		print "Radar / 10           : " + round(ALT:RADAR / 10, 1) + "     " at (5,8).
		print "Airspeed            : " + round(AIRSPEED, 1) + "     " at (5,9).
}.

set throt to 0.
set drawvecsteer to false.
set drawvecUP to false.
set drawvecLandingSite2 to false.
set drawvecSurfaceVelocity to false.
set drawvecLandingSite to false.
