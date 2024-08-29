#!/usr/bin/env python


import atexit
import os
from pwndbg.commands.context import contextoutput, output, clear_screen

# Read the devpts from the temporary files
bt_devpts = open('/tmp/pane_bt').read().strip()
st_devpts = open('/tmp/pane_st').read().strip()
re_devpts = open('/tmp/pane_re').read().strip()
di_devpts = open('/tmp/pane_di').read().strip()

# Create a dictionary to hold the pane information
panes = dict(backtrace=bt_devpts, stack=st_devpts, regs=re_devpts, disasm=di_devpts)

# Iterate through the panes and configure the context output
for sec, p in panes.items():
    print(f'sec: {sec}, p: {p}')
    contextoutput(sec, p, True)

contextoutput("legend", di_devpts, True)
atexit.register(lambda: [os.popen(F"zellij action close-pane {p[1]}").read() for p in panes.values()])
