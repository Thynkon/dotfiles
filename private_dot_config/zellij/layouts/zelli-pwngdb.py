#!/usr/bin/python

import subprocess

subprocess.run(["python", "/usr/share/pwndbg/gdbinit.py"])

import atexit
import os
from pwndbg.commands.context import contextoutput, output, clear_screen
bt = os.popen('tmux split-window -P -F "#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
st = os.popen(F'tmux split-window -h -t {bt[0]} -P -F '+'"#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
re = os.popen(F'tmux split-window -h -t {st[0]} -P -F '+'"#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
di = os.popen('tmux split-window -h -P -F "#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
panes = dict(backtrace=bt, stack=st, regs=re, disasm=di)
for sec, p in panes.items():
  contextoutput(sec, p[1], True)
contextoutput("legend", di[1], True)
atexit.register(lambda: [os.popen(F"tmux kill-pane -t {p[0]}").read() for p in panes.values()])
end
