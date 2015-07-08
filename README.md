# mt-kos
Mission Toolkit for kOS

## Summary 
<<<<<<< HEAD
Provides a library of scripts for

=======
Provides a library of scripts for 
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git
1. launching with atmosphere and in vacuum (''ltoa'', ''ltov''). Staging to be managed using ''when'' commands from the main script.
1. landing orbit with periapsis 30 degree off the zenith (''landnode''). Enables landing on the sunny side.
1. land in vacuum (''landv''), same script for Mun and Minmus
1. highly accurate maneuver node execution program (''exenode''). Better than 0.1% deltav accuracy.
1. orbital maneuvering (''aponode'', ''perinode'')
1. Kerbin maneuvers for Mun and Minmus (''soinode'')
1. inclination maneuvers for Minmus transfer (''incnode'')
1. Mun and Minmus escape maneuvers to return to Kerbin on a low deltav trajectory (''krbnode'')

The scripts rely on physics and math to calculate the maneuver properties. Usually 2D there will be some vector math in the inclination and landing node scripts.

## Requirements 
<<<<<<< HEAD
Works with KSP 1.0.4 and [kOS 0.17.4](https://github.com/KSP-KOS/KOS/releases/tag/v17.4)
=======
Works with KSP 1.0.4 and [https://github.com/KSP-KOS/KOS/releases/tag/v17.4 kOS 0.17.4]
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

## What's new? 
<<<<<<< HEAD
1. [Kerbin](http://wiki.kerbalspaceprogram.com/wiki/Kerbin) - [Mun](http://wiki.kerbalspaceprogram.com/wiki/Mun)/[Minmus](http://wiki.kerbalspaceprogram.com/wiki/Minmus) transfer and return node creation
=======
1. [http://wiki.kerbalspaceprogram.com/wiki/Kerbin Kerbin] - [http://wiki.kerbalspaceprogram.com/wiki/Mun Mun]/[http://wiki.kerbalspaceprogram.com/wiki/Minmus Minmus] transfer and return node creation
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git
1. orbit inclination adjustment
1. ascent w/o atmosphere
1. descent & landing w/o atmosphere
1. ''warpinsoi'', ''warpoutsoi'' and ''warpdist'' scripts to wait for an soi change
1. ''exenode'' script improvements for better accuracy

## Mun & Minmus mission scripts 
Kerbal Automated Mission Challenge scripts. The Minmus missions illustrate how to customize the mission scripts for specific vessels.
<<<<<<< HEAD
###  Mun mission
=======
###  Mun mission 
1. Vessel: [http://ksp.baldev.de/kos/mtkv3 Mun Lander 1b]
#: `[http://ksp.baldev.de/kos/mtkv3/kamc0.txt run kamc0.]   // outbound`
#: `[http://ksp.baldev.de/kos/mtkv3/kamc1.txt run kamc1.]   // return`
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
1. Vessel: [Mun Lander 1b](http://ksp.baldev.de/kos/mtkv3)
=======
###  Minmus mission "Wikinger" 
1. This vessels' stage 2 separation requires two ''stage'' statements.
1. You'll know why I call it "Viking" when you see the lander.
1. Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1b]
#: `[http://ksp.baldev.de/kos/mtkv3/kamc2.txt run kamc2.]   // outbound`
#: `[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return`
###  Minmus mission 2 
1. This vessels' stage 2 separation requires one ''stage'' statements.
1. Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1c]
#: `[http://ksp.baldev.de/kos/mtkv3/kamc3.txt run kamc3.]   // outbound`
#: `[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return`
###  Known issues 
1. When planet and moon are aligned with the sun it may happen that the lander travels in the planet's or moon's shadow for prolonged times during transfer. During those periods of travel in the dark the battery may run empty and shut down the kOS module due to lack of electricity. This will stop the script and require manual restarting of the mission script to execute the remaining commands.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
> `run kamc0.   // outbound`
=======
## Launch & Landing scripts 
###  Launch to Orbit / Atmosphere 
:: `[http://ksp.baldev.de/kos/mtkv3/ltoa.txt run ltoa.]`
1. Thrust limited by [http://en.wikipedia.org/wiki/Max_Q max q] during ascent. Max q defaults to 7000.
1. Gravity turn: pitch depending on cos(altitude). Default: start at 1.000, ends at 50.000. I found these parameters to use least fuel. Can you configure it better?
1. Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using `when` clauses.
1. Compensating for atmospheric drag when coasting to apoapsis.
1. Time warp while coasting to apoapsis. 
1. Calculation of target velocity for circular orbit using ''aponode''.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
> `run kamc1.   // return`
=======
### Launch to Orbit / Vacuum
:: `run [http://ksp.baldev.de/kos/mtkv3/ltov.txt ltov].`
1. Thrust limited during initial ascent until craft points to the horizon. Thrust limit shall prevent reaching low orbit altitude during first 2 seconds (this is a problem on Minmus).
1. Gravity turn delayed by 2 seconds to gain some altitude (non-quantitative). Turn will reduce pitch to the horizon compensated for gravitation (which is approx 1 degree on Mun).
1. Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using `when` clauses.
1. Time warp while coasting to apoapsis. 
1. Calculation of target velocity for circular orbit using ''aponode''.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
###  Minmus mission "Wikinger" 
1. This vessels' stage 2 separation requires two ''stage'' statements.
1. You'll know why I call it "Viking" when you see the lander.
1. Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1b]
#: `[http://ksp.baldev.de/kos/mtkv3/kamc2.txt run kamc2.]   // outbound`
#: `[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return`
###  Minmus mission 2 
1. This vessels' stage 2 separation requires one ''stage'' statements.
1. Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1c]
#: `[http://ksp.baldev.de/kos/mtkv3/kamc3.txt run kamc3.]   // outbound`
#: `[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return`
###  Known issues 
1. When planet and moon are aligned with the sun it may happen that the lander travels in the planet's or moon's shadow for prolonged times during transfer. During those periods of travel in the dark the battery may run empty and shut down the kOS module due to lack of electricity. This will stop the script and require manual restarting of the mission script to execute the remaining commands.
=======
### Land / Vacuum 
:: `run [http://ksp.baldev.de/kos/mtkv3/landv.txt landv(ecoh)]. // ecoh: engine cut-off height`
1. Landing script works in four phases loosely based on the real [http://www.google.de/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCIQFjAA&url=http%3A%2F%2Fwww.hq.nasa.gov%2Falsj%2Fnasa-tnd-6846pt.1.pdf&ei=6nGoU4_gJcem4gTRg4GADg&usg=AFQjCNEm35GluOSoExObPW237HdfmSfQNw&sig2=8p_lUbw_5WHh0hx4mS6aEQ&bvm=bv.69411363,d.bGE Apollo mission descent planning]:
#1. deceleration from orbit (retrograde burn) until 1/4 of periapsis velocity or radar altimeter starts working
#1. retrograde burn while reducing velocity proportional to radar altitude
#1. high gate (150m): descend and reduce surface velocity (thrusting downwards angled towards surface velocity vector)
#1. low gate (15m and surface velocity is less than 0.1m/s): descend vertically for landing
1. downward vertical velocity builds only through gravity (in contrast to the Apollo lander which thrusted upward to build downward velocity early in the burn).
1. engine cut-off when landing gear almost touches the ground. Implemented using the control unit's radar altitude on the ground (''ecoh'' parameter).
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Launch & Landing scripts 
###  Launch to Orbit / Atmosphere 
> `[http://ksp.baldev.de/kos/mtkv3/ltoa.txt run ltoa.]`
1. Thrust limited by [http://en.wikipedia.org/wiki/Max_Q max q] during ascent. Max q defaults to 7000.
1. Gravity turn: pitch depending on cos(altitude). Default: start at 1.000, ends at 50.000. I found these parameters to use least fuel. Can you configure it better?
1. Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using `when` clauses.
1. Compensating for atmospheric drag when coasting to apoapsis.
1. Time warp while coasting to apoapsis. 
1. Calculation of target velocity for circular orbit using ''aponode''.
=======
## Node Runner 
:: `run [http://ksp.baldev.de/kos/mtkv3/exenode.txt exenode].`
1. Maneuver node execution script
1. Mission toolkit node scripts assume impulsive burns, i.e. deltav happens instantly. Of course, this is not possible, but the node runner script runs the engines at full throttle to achieve shortest possible burn times.
1. The script will 
#1. warp to 1min before burn
#1. orient the ship for the burn
#1. warp to burn
#1. burn full throttle, then
#1. for very accurately changing deltav (better 0.1%) throttle down nearing burn end.
1. Workhorse of any mission script. Usually used alternating with maneuver node generator scripts.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Launch to Orbit / Vacuum
> `run [http://ksp.baldev.de/kos/mtkv3/ltov.txt ltov].`
1. Thrust limited during initial ascent until craft points to the horizon. Thrust limit shall prevent reaching low orbit altitude during first 2 seconds (this is a problem on Minmus).
1. Gravity turn delayed by 2 seconds to gain some altitude (non-quantitative). Turn will reduce pitch to the horizon compensated for gravitation (which is approx 1 degree on Mun).
1. Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using `when` clauses.
1. Time warp while coasting to apoapsis. 
1. Calculation of target velocity for circular orbit using ''aponode''.
=======
## Orbital Maneuvering 
### Apoapsis maneuver
:: `run [http://ksp.baldev.de/kos/mtkv3/aponode.txt aponode(altitude)].`
1. create maneuver node at apoapsis for changing periapsis altitude
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Land / Vacuum 
> `run [http://ksp.baldev.de/kos/mtkv3/landv.txt landv(ecoh)]. // ecoh: engine cut-off height`
1. Landing script works in four phases loosely based on the real [http://www.google.de/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCIQFjAA&url=http%3A%2F%2Fwww.hq.nasa.gov%2Falsj%2Fnasa-tnd-6846pt.1.pdf&ei=6nGoU4_gJcem4gTRg4GADg&usg=AFQjCNEm35GluOSoExObPW237HdfmSfQNw&sig2=8p_lUbw_5WHh0hx4mS6aEQ&bvm=bv.69411363,d.bGE Apollo mission descent planning]:
#1. deceleration from orbit (retrograde burn) until 1/4 of periapsis velocity or radar altimeter starts working
#1. retrograde burn while reducing velocity proportional to radar altitude
#1. high gate (150m): descend and reduce surface velocity (thrusting downwards angled towards surface velocity vector)
#1. low gate (15m and surface velocity is less than 0.1m/s): descend vertically for landing
1. downward vertical velocity builds only through gravity (in contrast to the Apollo lander which thrusted upward to build downward velocity early in the burn).
1. engine cut-off when landing gear almost touches the ground. Implemented using the control unit's radar altitude on the ground (''ecoh'' parameter).
=======
### Periapsis maneuver 
:: `run [http://ksp.baldev.de/kos/mtkv3/perinode.txt perinode(altitude)].`
1. create maneuver node at periapsis for changing apoapsis altitude
1. See also: http://en.wikipedia.org/wiki/Oberth_effect
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Node Runner 
> `run [http://ksp.baldev.de/kos/mtkv3/exenode.txt exenode].`
1. Maneuver node execution script
1. Mission toolkit node scripts assume impulsive burns, i.e. deltav happens instantly. Of course, this is not possible, but the node runner script runs the engines at full throttle to achieve shortest possible burn times.
1. The script will 
#1. warp to 1min before burn
#1. orient the ship for the burn
#1. warp to burn
#1. burn full throttle, then
#1. for very accurately changing deltav (better 0.1%) throttle down nearing burn end.
1. Workhorse of any mission script. Usually used alternating with maneuver node generator scripts.
=======
### Landing orbit maneuver 
:: `run [http://ksp.baldev.de/kos/mtkv3/landnode.txt landnode(altitude)].`
1. Lowers periapsis to altitude
1. Assumes a circular orbit
1. Periapsis will be 30 degrees "after" the zenith (orbitwise) on the dayside of the body. In that position potential pilots and observers will have a good lighting conditions to view the vessel (no beams needed) and its shadow to judge altitude.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Orbital Maneuvering 
### Apoapsis maneuver
> `run [http://ksp.baldev.de/kos/mtkv3/aponode.txt aponode(altitude)].`
1. create maneuver node at apoapsis for changing periapsis altitude
=======
### Inclination adjustment 
:: `run [http://ksp.baldev.de/kos/mtkv3/incnode.txt incnode(tgtbody)].`
1. Adjusts the orbits inclination to match tgtbodies' orbit inclination around the central body.
1. Assumes a circular orbit
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Periapsis maneuver 
> `run [http://ksp.baldev.de/kos/mtkv3/perinode.txt perinode(altitude)].`
1. create maneuver node at periapsis for changing apoapsis altitude
1. See also: http://en.wikipedia.org/wiki/Oberth_effect
=======
## Intraplanetary Transfer 
### Intraplanetary Hohmann outbound transfer 
:: `run [http://ksp.baldev.de/kos/mtkv3/hohnode.txt hohnode(tgtbody)].`
1. creates a maneuver node for Kerbin to Mun or Minmus Hohmann transfer
1. requires a circular orbit
1. apoapsis defaults to half of the target bodies' soi
1. for Minmus transfers detects whether Mun is in the way. The script then delays the maneuver for one orbit (until Mun is no longer in the way).
1. maneuver angle is calculated based on:
#1. Hohmann transfer time
#1. target bodies' orbital period
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Landing orbit maneuver 
> `run [http://ksp.baldev.de/kos/mtkv3/landnode.txt landnode(altitude)].`
1. Lowers periapsis to altitude
1. Assumes a circular orbit
1. Periapsis will be 30 degrees "after" the zenith (orbitwise) on the dayside of the body. In that position potential pilots and observers will have a good lighting conditions to view the vessel (no beams needed) and its shadow to judge altitude.
=======
### Intraplanetamry Hohmann inbound transfer 
:: `run [http://ksp.baldev.de/kos/mtkv3/krbnode.txt krbnode(peri_radius)].`
1. creates a maneuver node for Mun or Minmus to Kerbin return Hohmann transfer
1. the peri_radius parameter is the periapsis radius for the target body, NOT the periapsis altitude. `peri_radius = planet_radius + periapis (altitude)`. This is to allow usage with other planets. The planets radius is injected as a parameter and does not need to be "guessed" by the program.
1. requires a circular orbit
1. more tricky since as a first step the moon's soi must be left, i.e. an escape trajectory
1. maneuver is setup to leave the moon's soi
#1. opposite of the moon's direction of travel
#1. velocity after leaving soi matches an orbit with a) moon's apoapsis and b) periapsis as specified in the parameter.
1. CAVEAT: it seems like the moon's frame of reference is rotating. Thus an ejection angle of 90 degrees does lead to a distorted velocity vector once leaving the soi! I have solved this by calibrating the ejection angle.
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Inclination adjustment 
> `run [http://ksp.baldev.de/kos/mtkv3/incnode.txt incnode(tgtbody)].`
1. Adjusts the orbits inclination to match tgtbodies' orbit inclination around the central body.
1. Assumes a circular orbit
=======
## Warping
### by duration 
:: `run [http://ksp.baldev.de/kos/mtkv3/warpfor.txt warpfor(secs)].`
1. warps for duration
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Intraplanetary Transfer 
### Intraplanetary Hohmann outbound transfer 
> `run [http://ksp.baldev.de/kos/mtkv3/hohnode.txt hohnode(tgtbody)].`
1. creates a maneuver node for Kerbin to Mun or Minmus Hohmann transfer
1. requires a circular orbit
1. apoapsis defaults to half of the target bodies' soi
1. for Minmus transfers detects whether Mun is in the way. The script then delays the maneuver for one orbit (until Mun is no longer in the way).
1. maneuver angle is calculated based on:
#1. Hohmann transfer time
#1. target bodies' orbital period
=======
### until sunrise 
:: `run [http://ksp.baldev.de/kos/mtkv3/warpday.txt warpday].`
1. warps until sunrise
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Intraplanetamry Hohmann inbound transfer 
> `run [http://ksp.baldev.de/kos/mtkv3/krbnode.txt krbnode(peri_radius)].`
1. creates a maneuver node for Mun or Minmus to Kerbin return Hohmann transfer
1. the peri_radius parameter is the periapsis radius for the target body, NOT the periapsis altitude. `peri_radius = planet_radius + periapis (altitude)`. This is to allow usage with other planets. The planets radius is injected as a parameter and does not need to be "guessed" by the program.
1. requires a circular orbit
1. more tricky since as a first step the moon's soi must be left, i.e. an escape trajectory
1. maneuver is setup to leave the moon's soi
  1. opposite of the moon's direction of travel
  1. velocity after leaving soi matches an orbit with a) moon's apoapsis and b) periapsis as specified in the parameter.
1. CAVEAT: it seems like the moon's frame of reference is rotating. Thus an ejection angle of 90 degrees does lead to a distorted velocity vector once leaving the soi! I have solved this by calibrating the ejection angle.
=======
### by distance 
:: `run [http://ksp.baldev.de/kos/mtkv3/warpdist.txt warpdist(refbody, dist)].`
1. warps until passing distance dist relative to ''refbody''
1. automatically recognizes whether to warp in or out
1. determines velocity to/from ''refbody'' by measuring distance change regularly. The measurement time interval depends on the current warp factor.
1. used by soi warp programs
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Warping
### by duration 
`run [http://ksp.baldev.de/kos/mtkv3/warpfor.txt warpfor(secs)].`
1. warps for duration
=======
### until entering soi 
:: `run [http://ksp.baldev.de/kos/mtkv3/warpinsoi.txt warpinsoi(tgtbody)].`
1. warps until entering soi of ''tgtbody''
1. current body is used as ''refbody''
1. ''tgtbody'' is required to positively recognize new soi
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### until sunrise 
`run [http://ksp.baldev.de/kos/mtkv3/warpday.txt warpday].`
1. warps until sunrise
=======
### until leaving soi 
:: `run [http://ksp.baldev.de/kos/mtkv3/warpoutsoi.txt warpoutsoi(refbody, tgtbody)].`
1. TODO: to be changed to `run warpoutsoi.` to simplify interface. Parameters are not needed.
1. warps until leaving soi of a body
1. ''refbody'' is required to calculate distance (even after leaving soi)
1. ''tgtbody'' is used to positively recognize new soi
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### by distance 
> `run [http://ksp.baldev.de/kos/mtkv3/warpdist.txt warpdist(refbody, dist)].`
1. warps until passing distance dist relative to ''refbody''
1. automatically recognizes whether to warp in or out
1. determines velocity to/from ''refbody'' by measuring distance change regularly. The measurement time interval depends on the current warp factor.
1. used by soi warp programs
=======
## Miscellaneous 
### Body properties database 
:: `run [http://ksp.baldev.de/kos/mtkv3/bodyprops.txt bodyprops].`
1. Sets a body's properties global variables. A.k.a. "body database" by other kOS developers. Loads body specific properties for the current body.
1. currently works for Kerbin, Mun and Minmus. 
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### until entering soi 
> `run [http://ksp.baldev.de/kos/mtkv3/warpinsoi.txt warpinsoi(tgtbody)].`
1. warps until entering soi of ''tgtbody''
1. current body is used as ''refbody''
1. ''tgtbody'' is required to positively recognize new soi
=======
### Check vessel compatibility 
:: `run [http://ksp.baldev.de/kos/mtkv3/checkvessel.txt checkvessel(vesselname)].`
1. checks for a match of the vesselname
1. intended for the mission script to check whether used with a compatible vessel
1. remember: the mission script encodes staging behavior in ''when..then'' commands
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### until leaving soi 
> `run [http://ksp.baldev.de/kos/mtkv3/warpoutsoi.txt warpoutsoi(refbody, tgtbody)].`
1. TODO: to be changed to `run warpoutsoi.` to simplify interface. Parameters are not needed.
1. warps until leaving soi of a body
1. ''refbody'' is required to calculate distance (even after leaving soi)
1. ''tgtbody'' is used to positively recognize new soi
=======
### Turn to sun 
:: `run [http://ksp.baldev.de/kos/mtkv3/tts.txt tts].`
1. turns the vessel facing 90 degress from the sun
1. makes sure simple solar cells receive light
1. baloan: ''I had vessels running out of electricity because maneuver burn vectors accidentally were oriented towards the sun or away.''
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
## Miscellaneous 
### Body properties database 
> `run [http://ksp.baldev.de/kos/mtkv3/bodyprops.txt bodyprops].`
1. Sets a body's properties global variables. A.k.a. "body database" by other kOS developers. Loads body specific properties for the current body.
1. currently works for Kerbin, Mun and Minmus. 
=======
### Sphere of influence
:: `run [http://ksp.baldev.de/kos/mtkv3/soi.txt soi(refbody)].`
1. return the ''refbody'''s soi in the ''soi'' variable
1. is required by the intraplanetamry maneuver scripts
1. it does NOT use a database but calculates using the ''body:mu'' values. See also [http://en.wikipedia.org/wiki/Sphere_of_influence_(astrodynamics) SOI]
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Check vessel compatibility 
> `run [http://ksp.baldev.de/kos/mtkv3/checkvessel.txt checkvessel(vesselname)].`
1. checks for a match of the vesselname
1. intended for the mission script to check whether used with a compatible vessel
1. remember: the mission script encodes staging behavior in ''when..then'' commands
=======
### Prepare
:: `run [http://ksp.baldev.de/kos/mtkv3/prep.txt prep].`
1. copied to the ship's local volume 1 when the mission scripts start
1. contains initialization to restart scripts after a KSP restart; currently just ''switches to volume 0'' and runs ''bodyprops''
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Turn to sun 
> `run [http://ksp.baldev.de/kos/mtkv3/tts.txt tts].`
1. turns the vessel facing 90 degress from the sun
1. makes sure simple solar cells receive light
1. baloan: ''I had vessels running out of electricity because maneuver burn vectors accidentally were oriented towards the sun or away.''
=======
### Steer
:: `run [http://ksp.baldev.de/kos/mtkv3/steer.txt steer].`
1. wait for ship to orient, then return
1. deprecated. to be removed in next mission toolkit
1. see ''tts''
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Sphere of influence
> `run [http://ksp.baldev.de/kos/mtkv3/soi.txt soi(refbody)].`
1. return the ''refbody'''s soi in the ''soi'' variable
1. is required by the intraplanetamry maneuver scripts
1. it does NOT use a database but calculates using the ''body:mu'' values. See also [http://en.wikipedia.org/wiki/Sphere_of_influence_(astrodynamics) SOI]
=======
## Planned extensions
1. warp to lunar position which avoids prolonged transfer in the dark (without light for the solar cells)
1. interplanetamry transfers
1. docking (requires kOS thruster support)
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git

<<<<<<< HEAD
### Prepare
> `run [http://ksp.baldev.de/kos/mtkv3/prep.txt prep].`
1. copied to the ship's local volume 1 when the mission scripts start
1. contains initialization to restart scripts after a KSP restart; currently just ''switches to volume 0'' and runs ''bodyprops''

### Steer
> `run [http://ksp.baldev.de/kos/mtkv3/steer.txt steer].`
1. wait for ship to orient, then return
1. deprecated. to be removed in next mission toolkit
1. see ''tts''

## Planned extensions
1. warp to lunar position which avoids prolonged transfer in the dark (without light for the solar cells)
1. interplanetamry transfers
1. docking (requires kOS thruster support)

=======
>>>>>>> branch 'master' of https://github.com/baloan/mt-kos.git
## Download files
* [http://ksp.baldev.de/kos/mtkv3/aponode.txt aponode.txt]
* [http://ksp.baldev.de/kos/mtkv3/aponode.txt aponode.txt]
* [http://ksp.baldev.de/kos/mtkv3/bodyprops.txt bodyprops.txt]
* [http://ksp.baldev.de/kos/mtkv3/checkvessel.txt checkvessel.txt]
* [http://ksp.baldev.de/kos/mtkv3/exenode.txt exenode.txt]
* [http://ksp.baldev.de/kos/mtkv3/hohnode.txt hohnode.txt]
* [http://ksp.baldev.de/kos/mtkv3/incnode.txt incnode.txt]
* [http://ksp.baldev.de/kos/mtkv3/kamc0.txt kamc0.txt]
* [http://ksp.baldev.de/kos/mtkv3/kamc1.txt kamc1.txt]
* [http://ksp.baldev.de/kos/mtkv3/kamc2.txt kamc2.txt]
* [http://ksp.baldev.de/kos/mtkv3/kamc3.txt kamc3.txt]
* [http://ksp.baldev.de/kos/mtkv3/kamc4.txt kamc4.txt]
* [http://ksp.baldev.de/kos/mtkv3/krbnode.txt krbnode.txt]
* [http://ksp.baldev.de/kos/mtkv3/landa.txt landa.txt]
* [http://ksp.baldev.de/kos/mtkv3/landnode.txt landnode.txt]
* [http://ksp.baldev.de/kos/mtkv3/landv.txt landv.txt]
* [http://ksp.baldev.de/kos/mtkv3/ltoa.txt ltoa.txt]
* [http://ksp.baldev.de/kos/mtkv3/ltov.txt ltov.txt]
* [http://ksp.baldev.de/kos/mtkv3/perinode.txt perinode.txt]
* [http://ksp.baldev.de/kos/mtkv3/prep.txt prep.txt]
* [http://ksp.baldev.de/kos/mtkv3/soi.txt soi.txt]
* [http://ksp.baldev.de/kos/mtkv3/soinode.txt soinode.txt]
* [http://ksp.baldev.de/kos/mtkv3/steer.txt steer.txt]
* [http://ksp.baldev.de/kos/mtkv3/tts.txt tts.txt]
* [http://ksp.baldev.de/kos/mtkv3/warpday.txt warpday.txt]
* [http://ksp.baldev.de/kos/mtkv3/warpdist.txt warpdist.txt]
* [http://ksp.baldev.de/kos/mtkv3/warpfor.txt warpfor.txt]
* [http://ksp.baldev.de/kos/mtkv3/warpinsoi.txt warpinsoi.txt]
* [http://ksp.baldev.de/kos/mtkv3/warpoutsoi.txt warpoutsoi.txt]


* The wiki doesn't like spaces in external links so you have to look for the craft file for yourself here: [http://ksp.baldev.de/kos/mtkv3 craft file directory]

[[User:Baloan|Baloan]]
