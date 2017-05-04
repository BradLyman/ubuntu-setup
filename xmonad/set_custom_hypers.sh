#!/bin/bash

# Setup tmp directories
XKBDIR=/tmp/xkb
mkdir -p ${XKBDIR}/keymap ${XKBDIR}/symbols ${XKBDIR}/keycodes

#######################################################
# write custom xkb file -- generated by
# setxkbmap -layout dvorak -option caps:escape -print
#
# then just add the +custom(hypers) to xkb_symbols
#######################################################
cat > $XKBDIR/keymap/custom.xkb << EOF
xkb_keymap {
 xkb_keycodes  { include "evdev+aliases(qwerty)" };
 xkb_types     { include "complete" };
 xkb_compat    { include "complete" };
 xkb_symbols   { include "pc+us(dvorak)+inet(evdev)+capslock(escape)+terminate(ctrl_alt_bksp)+custom(hypers)" };
 xkb_geometry  { include "kinesis(model100)" };
};
EOF

#################################################
# My custom hypers file
# Set the tab key to emit hyper_l
# and set the backslash key to emit hyper_r
# remap some unused keys to tab and backslash
# then set Mod4 to be controlled by the hypers
#################################################
cat > $XKBDIR/symbols/custom << EOF
default partial
xkb_symbols "hypers" {
    key  <TAB> { [ Hyper_L, Hyper_L ] };
    key <BKSL> { [ Hyper_R, Hyper_R ] };
    key <I252> { [ Tab, ISO_Left_Tab] };
    key <I253> { [ backslash, bar ] };
    modifier_map Mod4 { Super_L, Super_R, Hyper_L, Hyper_R };
};
EOF

# Load the custom layout
xkbcomp -w3 -I$XKBDIR $XKBDIR/keymap/custom.xkb :0

# kill any runnig xcape instances
(exec killall -q xcape)

# set Hyper_L and Hyper_R to emit tab and backslash if nothing else was pressed
xcape -e "Hyper_L=Tab;Hyper_R=backslash"
