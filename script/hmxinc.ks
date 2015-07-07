// calculate target position by rotation (requires circular orbits)
set amref to vcrs(p0ref, refbody:velocity).  // angular momentum
run vrot(p0ref, amref:normalized, 360*talign/opref).
set p1ref to vrot.
set amtgt to vcrs(p0tgt, tgtbody:velocity).  // angular momentum
run vrot(p0tgt, amtgt:normalized, 360*talign/optgt).
set p1tgt to vrot.
