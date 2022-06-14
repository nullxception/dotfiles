import os
from subprocess import run, Popen

SELF_PATH = os.path.dirname(os.path.realpath(__file__))

def start(args):
    Popen(
        args,
        close_fds=True,
        cwd=SELF_PATH,
        creationflags=0x00000008,  # DETACHED_PROCESS
    )

# start autohotkeys
start(["C:/Program Files/AutoHotkey/AutoHotkeyU64.exe", 'keyboard.ahk'])

# start adb server early to avoid stuck on first-time usage at WSL2
start(["adb", "start-server"])
