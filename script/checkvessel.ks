declare parameter name.
if ship:name <> name { 
    print "WARNING! This script maybe incompatible.".
    print "Designed to work with '" + name + "'".
    print "         Current ship '" + ship:name + "'".
    print "Press Ctrl-C within 5s to abort".
    print "-------------------------------------------------".
    wait 5.
}
