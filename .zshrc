export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/dotfiles/oh-my-zsh-custom


autoload -Uz add-zsh-hook
add-zsh-hook precmd automatically_activate_python_venv

# from https://stackoverflow.com/a/63955939/366221
# replacement for ohmyzah "virtualenvwrapper" plugin which was flakey
function automatically_activate_python_venv() {
  if [[ -z $VIRTUAL_ENV ]] ; then
    activate_venv
  else
    parentdir="$(dirname ${VIRTUAL_ENV})"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
      activate_venv
    fi
  fi
}

function activate_venv() {
  local d
  d=$PWD

  until false
  do
  if [[ -f "$d/.venv/bin/activate" ]] ; then
    source "$d/.venv/bin/activate"
    break
  fi
    d=${d%/*}
    # d="$(dirname "$d")"
    [[ $d = *\/* ]] || break
  done
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  dotenv
  git
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# powerline
# . ~/.local/lib/python3.?/site-packages/powerline/bindings/zsh/powerline.zsh

# stop less from clearing screen on exit, with -X
export LESS="-RX"

# stop python from writing pycs.
export PYTHONDONTWRITEBYTECODE=1

# prevents accidental corruption of system python(s)
export PIP_REQUIRE_VIRTUALENV=true

# homebrew, macos only
if [ -e /opt/homebrew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi



# for "fuck you firefox".  requires utils/flip
function fuck() {
  if [ ! "$1" ]; then
    echo "Usage: fuck you process_name"
    exit
  fi

  if killall "$2"; then
    echo
    echo " (╯°□°）╯︵$(echo "$2" | flip)"
    echo
  fi
}


autoload -U +X bashcompinit && bashcompinit

if [ -e /usr/bin/nomad ]; then
    complete -o nospace -C /usr/bin/nomad nomad
fi

export PATH="$HOME/.poetry/bin:$PATH"
export POETRY_VIRTUALENVS_IN_PROJECT="true"

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi # added by Nix installer


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"


# emacs binaries incl doom
export PATH="$HOME/.config/emacs/bin:$PATH"

eval "$(pyenv init --path)"

# icat for kitty displays images
alias icat="kitty +kitten icat"

# load keychain (on wsl)
if [ -e /mnt/c/Windows ]; then
    keychain $HOME/.ssh/id_ed25519
    source $HOME/.keychain/$HOST-sh
fi

# source any aws env vars
# source ~/.aws/.session-env-vars

# rust
if [ -e "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi


# Vagrant on WSL
#
if [ -e /mnt/c/Windows ]; then
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    export PATH="$PATH:/mnt/c/Windows/System32"
    export PATH="$PATH:/mnt/c/Windows/System32/WindowsPowershell/v1.0/".
fi

# starship.rs prompt
eval "$(starship init zsh)"


# Invoke tab-completion script to be sourced with the Z shell.
# Known to work on zsh 5.0.x, probably works on later 4.x releases as well (as
# it uses the older compctl completion system).
_complete_invoke() {
    # `words` contains the entire command string up til now (including
    # program name).
    #
    # We hand it to Invoke so it can figure out the current context: spit back
    # core options, task names, the current task's options, or some combo.
    #
    # Before doing so, we attempt to tease out any collection flag+arg so we
    # can ensure it is applied correctly.
    collection_arg=''
    if [[ "${words}" =~ "(-c|--collection) [^ ]+" ]]; then
        collection_arg=$MATCH
    fi
    # `reply` is the array of valid completions handed back to `compctl`.
    # Use ${=...} to force whitespace splitting in expansion of
    # $collection_arg
    reply=( $(invoke ${=collection_arg} --complete -- ${words}) )
}

# Tell shell builtin to use the above for completing our given binary name(s).
# * -K: use given function name to generate completions.
# * +: specifies 'alternative' completion, where options after the '+' are only
#   used if the completion from the options before the '+' result in no matches.
# * -f: when function generates no results, use filenames.
# * positional args: program names to complete for.
compctl -K _complete_invoke + -f invoke inv

# postgres.app on macos
if [ -e /Applications/Postgres.app ]; then
    export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
fi

# -- commit to nvim!
#
alias vim=nvim
alias vi=nvim
alias oldvim=/usr/bin/vim
alias vimdiff=nvim -d
export EDITOR=nvim
export LLVM_SYS_160_PREFIX=$(brew --prefix llvm@16)

# fnm
if [ -e "/Users/harry.percival/Library/Application Support/fnm" ]; then
    export PATH="/Users/harry.percival/Library/Application Support/fnm:$PATH"
    eval "`fnm env`"
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PIPX_HOME="$HOME/.local/pipx"
