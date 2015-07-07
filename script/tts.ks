// Turn To Sun. make sure solar panels are exposed
print "T+" + round(missiontime) + " Turning ship to expose solar panels.".
set dir to R(-90,0,0).
lock steering to dir.
set tolerance to 0.01.
wait until abs(sin(dir:pitch) - sin(facing:pitch)) < tolerance and abs(sin(dir:yaw) - sin(facing:yaw)) < tolerance.
