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

query = selection_clipboard
if ' ' in query:
    query = main_clipboard

target = "https://www.pythonanywhere.com/user/{}/webapps/".format(query)

process = subprocess.Popen(['firefox', target])
sys.exit(process.wait())
