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

target = "https://www.pythonanywhere.com/admin/auth/user/?q={}".format(query)

process = subprocess.Popen(['firefox', target])
sys.exit(process.wait())
