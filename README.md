# mt-kos
Mission Toolkit for kOS

==Summary==
Provides a library of scripts for 
# launching with atmosphere and in vacuum (''ltoa'', ''ltov''). Staging to be managed using ''when'' commands from the main script.
# landing orbit with periapsis 30 degree off the zenith (''landnode''). Enables landing on the sunny side.
# land in vacuum (''landv''), same script for Mun and Minmus
# highly accurate maneuver node execution program (''exenode''). Better than 0.1% deltav accuracy.
# orbital maneuvering (''aponode'', ''perinode'')
# Kerbin maneuvers for Mun and Minmus (''soinode'')
# inclination maneuvers for Minmus transfer (''incnode'')
# Mun and Minmus escape maneuvers to return to Kerbin on a low deltav trajectory (''krbnode'')

The scripts rely on physics and math to calculate the maneuver properties. Usually 2D there will be some vector math in the inclination and landing node scripts.

==Requirements==
Works with KSP 0.23.5 and [https://github.com/KSP-KOS/KOS/releases/tag/v12.2P1 kOS 12.2p1]

==What's new?==
# [http://wiki.kerbalspaceprogram.com/wiki/Kerbin Kerbin] - [http://wiki.kerbalspaceprogram.com/wiki/Mun Mun]/[http://wiki.kerbalspaceprogram.com/wiki/Minmus Minmus] transfer and return node creation
# orbit inclination adjustment
# ascent w/o atmosphere
# descent & landing w/o atmosphere
# ''warpinsoi'', ''warpoutsoi'' and ''warpdist'' scripts to wait for an soi change
# ''exenode'' script improvements for better accuracy

==Mun & Minmus mission scripts==
Kerbal Automated Mission Challenge scripts. The Minmus missions illustrate how to customize the mission scripts for specific vessels.
=== Mun mission ===
# Vessel: [http://ksp.baldev.de/kos/mtkv3 Mun Lander 1b]
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc0.txt run kamc0.]   // outbound</code>
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc1.txt run kamc1.]   // return</code>

=== Minmus mission "Wikinger" ===
# This vessels' stage 2 separation requires two ''stage'' statements.
# You'll know why I call it "Viking" when you see the lander.
# Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1b]
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc2.txt run kamc2.]   // outbound</code>
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return</code>
=== Minmus mission 2 ===
# This vessels' stage 2 separation requires one ''stage'' statements.
# Vessel: [http://ksp.baldev.de/kos/mtkv3 Minmus Lander 1c]
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc3.txt run kamc3.]   // outbound</code>
#: <code>[http://ksp.baldev.de/kos/mtkv3/kamc4.txt run kamc4.]   // return</code>
=== Known issues ===
# When planet and moon are aligned with the sun it may happen that the lander travels in the planet's or moon's shadow for prolonged times during transfer. During those periods of travel in the dark the battery may run empty and shut down the kOS module due to lack of electricity. This will stop the script and require manual restarting of the mission script to execute the remaining commands.

==Launch & Landing scripts==
=== Launch to Orbit / Atmosphere ===
:: <code>[http://ksp.baldev.de/kos/mtkv3/ltoa.txt run ltoa.]</code>
# Thrust limited by [http://en.wikipedia.org/wiki/Max_Q max q] during ascent. Max q defaults to 7000.
# Gravity turn: pitch depending on cos(altitude). Default: start at 1.000, ends at 50.000. I found these parameters to use least fuel. Can you configure it better?
# Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using <code>when</code> clauses.
# Compensating for atmospheric drag when coasting to apoapsis.
# Time warp while coasting to apoapsis. 
# Calculation of target velocity for circular orbit using ''aponode''.

===Launch to Orbit / Vacuum===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/ltov.txt ltov].</code>
# Thrust limited during initial ascent until craft points to the horizon. Thrust limit shall prevent reaching low orbit altitude during first 2 seconds (this is a problem on Minmus).
# Gravity turn delayed by 2 seconds to gain some altitude (non-quantitative). Turn will reduce pitch to the horizon compensated for gravitation (which is approx 1 degree on Mun).
# Staging separated from trajectory control (thrust/pitch). Staging to be implemented in main script using <code>when</code> clauses.
# Time warp while coasting to apoapsis. 
# Calculation of target velocity for circular orbit using ''aponode''.

===Land / Vacuum===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/landv.txt landv(ecoh)]. // ecoh: engine cut-off height</code>
# Landing script works in four phases loosely based on the real [http://www.google.de/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCIQFjAA&url=http%3A%2F%2Fwww.hq.nasa.gov%2Falsj%2Fnasa-tnd-6846pt.1.pdf&ei=6nGoU4_gJcem4gTRg4GADg&usg=AFQjCNEm35GluOSoExObPW237HdfmSfQNw&sig2=8p_lUbw_5WHh0hx4mS6aEQ&bvm=bv.69411363,d.bGE Apollo mission descent planning]:
## deceleration from orbit (retrograde burn) until 1/4 of periapsis velocity or radar altimeter starts working
## retrograde burn while reducing velocity proportional to radar altitude
## high gate (150m): descend and reduce surface velocity (thrusting downwards angled towards surface velocity vector)
## low gate (15m and surface velocity is less than 0.1m/s): descend vertically for landing
# downward vertical velocity builds only through gravity (in contrast to the Apollo lander which thrusted upward to build downward velocity early in the burn).
# engine cut-off when landing gear almost touches the ground. Implemented using the control unit's radar altitude on the ground (''ecoh'' parameter).

==Node Runner==
:: <code>run [http://ksp.baldev.de/kos/mtkv3/exenode.txt exenode].</code>
# Maneuver node execution script
# Mission toolkit node scripts assume impulsive burns, i.e. deltav happens instantly. Of course, this is not possible, but the node runner script runs the engines at full throttle to achieve shortest possible burn times.
# The script will 
## warp to 1min before burn
## orient the ship for the burn
## warp to burn
## burn full throttle, then
## for very accurately changing deltav (better 0.1%) throttle down nearing burn end.
# Workhorse of any mission script. Usually used alternating with maneuver node generator scripts.

==Orbital Maneuvering==
===Apoapsis maneuver===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/aponode.txt aponode(altitude)].</code>
# create maneuver node at apoapsis for changing periapsis altitude

===Periapsis maneuver===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/perinode.txt perinode(altitude)].</code>
# create maneuver node at periapsis for changing apoapsis altitude
# See also: http://en.wikipedia.org/wiki/Oberth_effect

===Landing orbit maneuver===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/landnode.txt landnode(altitude)].</code>
# Lowers periapsis to altitude
# Assumes a circular orbit
# Periapsis will be 30 degrees "after" the zenith (orbitwise) on the dayside of the body. In that position potential pilots and observers will have a good lighting conditions to view the vessel (no beams needed) and its shadow to judge altitude.

===Inclination adjustment ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/incnode.txt incnode(tgtbody)].</code>
# Adjusts the orbits inclination to match tgtbodies' orbit inclination around the central body.
# Assumes a circular orbit

==Intraplanetamry Transfers==
===Intraplanetamry Hohmann outbound transfer ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/hohnode.txt hohnode(tgtbody)].</code>
# creates a maneuver node for Kerbin to Mun or Minmus Hohmann transfer
# requires a circular orbit
# apoapsis defaults to half of the target bodies' soi
# for Minmus transfers detects whether Mun is in the way. The script then delays the maneuver for one orbit (until Mun is no longer in the way).
# maneuver angle is calculated based on:
## Hohmann transfer time
## target bodies' orbital period

===Intraplanetamry Hohmann inbound transfer ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/krbnode.txt krbnode(peri_radius)].</code>
# creates a maneuver node for Mun or Minmus to Kerbin return Hohmann transfer
# the peri_radius parameter is the periapsis radius for the target body, NOT the periapsis altitude. <code>peri_radius = planet_radius + periapis (altitude)</code>. This is to allow usage with other planets. The planets radius is injected as a parameter and does not need to be "guessed" by the program.
# requires a circular orbit
# more tricky since as a first step the moon's soi must be left, i.e. an escape trajectory
# maneuver is setup to leave the moon's soi
## opposite of the moon's direction of travel
## velocity after leaving soi matches an orbit with a) moon's apoapsis and b) periapsis as specified in the parameter.
# CAVEAT: it seems like the moon's frame of reference is rotating. Thus an ejection angle of 90 degrees does lead to a distorted velocity vector once leaving the soi! I have solved this by calibrating the ejection angle.

==Warping==
===by duration ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/warpfor.txt warpfor(secs)].</code>
# warps for duration

===until sunrise ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/warpday.txt warpday].</code>
# warps until sunrise

===by distance===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/warpdist.txt warpdist(refbody, dist)].</code>
# warps until passing distance dist relative to ''refbody''
# automatically recognizes whether to warp in or out
# determines velocity to/from ''refbody'' by measuring distance change regularly. The measurement time interval depends on the current warp factor.
# used by soi warp programs

===until entering soi===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/warpinsoi.txt warpinsoi(tgtbody)].</code>
# warps until entering soi of ''tgtbody''
# current body is used as ''refbody''
# ''tgtbody'' is required to positively recognize new soi

===until leaving soi===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/warpoutsoi.txt warpoutsoi(refbody, tgtbody)].</code>
# TODO: to be changed to <code>run warpoutsoi.</code> to simplify interface. Parameters are not needed.
# warps until leaving soi of a body
# ''refbody'' is required to calculate distance (even after leaving soi)
# ''tgtbody'' is used to positively recognize new soi

==Miscellaneous==
===Body properties database===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/bodyprops.txt bodyprops].</code>
# Sets a body's properties global variables. A.k.a. "body database" by other kOS developers. Loads body specific properties for the current body.
# currently works for Kerbin, Mun and Minmus. 

===Check vessel compatibility===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/checkvessel.txt checkvessel(vesselname)].</code>
# checks for a match of the vesselname
# intended for the mission script to check whether used with a compatible vessel
# remember: the mission script encodes staging behavior in ''when..then'' commands

===Turn to sun===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/tts.txt tts].</code>
# turns the vessel facing 90 degress from the sun
# makes sure simple solar cells receive light
# baloan: ''I had vessels running out of electricity because maneuver burn vectors accidentally were oriented towards the sun or away.''

===Sphere of influence===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/soi.txt soi(refbody)].</code>
# return the ''refbody'''s soi in the ''soi'' variable
# is required by the intraplanetamry maneuver scripts
# it does NOT use a database but calculates using the ''body:mu'' values. See also [http://en.wikipedia.org/wiki/Sphere_of_influence_(astrodynamics) SOI]

===Prepare ===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/prep.txt prep].</code>
# copied to the ship's local volume 1 when the mission scripts start
# contains initialization to restart scripts after a KSP restart; currently just ''switches to volume 0'' and runs ''bodyprops''

===Steer===
:: <code>run [http://ksp.baldev.de/kos/mtkv3/steer.txt steer].</code>
# wait for ship to orient, then return
# deprecated. to be removed in next mission toolkit
# see ''tts''

==Planned extensions==
# warp to lunar position which avoids prolonged transfer in the dark (without light for the solar cells)
# interplanetamry transfers
# docking (requires kOS thruster support)

==Download files==
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