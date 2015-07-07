// traverse parts for resources
list parts in ps.
// for p in ps {  
// in python it were:  for i,p in enumerate(ps) {
set i to ps:iterator.
until not i:next {
    set p to i:value.
    if p:resources:length > 0 {
        // print p:stage + " - " + p:name.
        // for r in p:resources {
        set j to p:resources:iterator.
        until not j:next {
            set r to j:value.
            if r:enabled {
                set s to "ok".
            } else {
                set s to "disabled".
            }
            print "[" + i:index + "][" + j:index + "] " + p:stage + " " + r:name + ", (" + round(r:amount) + "/" + round(r:capacity) + "), " + s.
        }
    }
}
// print ps[17]:resources[0]:amount.
