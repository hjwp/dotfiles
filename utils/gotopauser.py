#!/usr/bin/python
import subprocess
import sys

try:
    main_clipboard = subprocess.check_output(['xclip', '-selection', 'clipboard', '-o']).strip()
except subprocess.CalledProcessError:
    main_clipboard = ''
try:
    selection_clipboard = subprocess.check_output(['xclip', '-selection', 'primary', '-o']).strip()
except subprocess.CalledProcessError:
    selection_clipboard = ''

if '@' in main_clipboard and '@' not in selection_clipboard:
    query = main_clipboard
else:
    query = selection_clipboard

target1 = "https://www.pythonanywhere.com/admin/auth/user/?username={}".format(query)
target2 = "https://www.pythonanywhere.com/admin/auth/user/?email={}".format(query)

process1 = subprocess.Popen(['firefox', target1])
process2 = subprocess.Popen(['firefox', target2])
sys.exit(process1.wait() + process2.wait())
