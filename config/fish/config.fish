# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
# source $OMF_PATH/init.fish

set PATH ~/.local/bin $PATH

## nb environment plugin needs unreleased version of virtualfish git+https://github.com/adambrenecki/virtualfish.git
eval (python3 -m virtualfish auto_activation environment)

set -x PYTHONDONTWRITEBYTECODE 1

