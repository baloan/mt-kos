declare parameter va, axis, a.
// rotate va around axis by a degrees
// based on http://en.wikipedia.org/wiki/Rotation_matrix#"Rotation matrix from axis and angle"

set ux to axis:normalized:x.
set uy to axis:normalized:y.
set uz to axis:normalized:z.
set sina to sin(a).
set cosa to cos(a).

// calculate matrix elements

set r11 to cosa + ux^2*(1-cosa).
set r12 to ux*uy*(1-cosa) - uz*sina.
set r13 to ux*uz*(1-cosa) + uy*sina.

set r21 to uy*ux*(1-cosa) + uz*sina.
set r22 to cosa + uy^2*(1-cosa).
set r23 to uy*uz*(1-cosa) - ux*sina.

set r31 to uz*ux*(1-cosa) - uy*sina.
set r32 to uz*uy*(1-cosa) + ux*sina.
set r33 to cosa + uz^2*(1-cosa).

// multiply matrix with vector

set vx to r11*va:x + r12*va:y + r13*va:z.
set vy to r21*va:x + r22*va:y + r23*va:z.
set vz to r31*va:x + r32*va:y + r33*va:z.

set vrot to V(vx, vy, vz).
