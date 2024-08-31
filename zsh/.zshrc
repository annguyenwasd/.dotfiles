#
# Start profiling (uncomment when necessary)
#
# See: https://stackoverflow.com/a/4351664/2103996

# Per-command profiling:

# zmodload zsh/datetime
# setopt promptsubst
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2> startlog.$$
# setopt xtrace prompt_subst

# Per-function profiling:

# zmodload zsh/zprof

# {{{ Settings
# autocompletion
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
zmodload -F zsh/stat b:zstat
setopt AUTO_CD
setopt NOTIFY
setopt prompt_subst

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# Turn off all beeps
unsetopt BEEP
# }}}

# {{{ Sources
[[ -f $HOME/.config/zsh/env.zsh ]] && source $HOME/.config/zsh/env.zsh
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/personal.zsh
source $HOME/.config/zsh/rmm.zsh
source $HOME/.config/zsh/git.zsh
source $HOME/.config/zsh/vcs-info.zsh
source $HOME/.config/zsh/yr.zsh
source $HOME/.config/zellij/mappings.zsh
# TOO move it to personal
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -d /usr/share/fzf ] && source /usr/share/fzf/completion.zsh && source /usr/share/fzf/key-bindings.zsh
# }}}

# {{{ Exports

export EDITOR=nvim
export WORKSPACE_FOLDER=~/workspace
export NVIM_HOME=~/.config/nvim/
export TERM=xterm-256color
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
#}}}

# {{{ Alias
alias manrg="rg --generate man | man -l -"

alias ll="ls -a"
# h: human readable, t: time - newest first, S: size largest first
alias la="ls -lahtS"

alias ez="nvim ~/.zshrc"
alias ev="nvim ~/.config/nvim/init.lua"

alias sz="source ~/.zshrc && echo \"Sourced.\""

alias w="cd $WORKSPACE_FOLDER"
alias d="cd ~/Desktop"
alias dot="cd $DOTFILES && [ ! $TMUX = '' ] && dn; [ ! $ZELLIJ = '' ] && dn; nvim"

alias mk="mkdir -vp"
alias cl="clear"
alias x="exit 0"

alias ys="yarn run start"
alias yd="yarn run dev"
alias yt="yarn test"
alias yb="yarn run build"
alias yl="yarn list"
alias yw="yarn why"
alias allcowsay="cowsay -l | tr ' ' \\n | tail -n+5 | xargs -n1 -I@ sh -c 'cowsay -f@ @'"
# }}}

# {{{ Functions
# Function: kp
#
# Description:
#   The `kp` function is used to forcefully terminate any processes that are currently using a specified network port.
#   It identifies the process IDs (PIDs) associated with the given port and sends the `SIGKILL` signal (`-9`) to those processes,
#   which immediately and forcefully kills them.
#
# Usage:
#   kp <port_number>
#
# Parameters:
#   <port_number> - The network port number for which processes should be terminated.
#
# Example:
#   kp 8080
#   This will kill any processes that are using port 8080.
#
# Notes:
#   - The function uses `lsof` to find the processes using the specified port.
#   - The `kill -9` command sends the `SIGKILL` signal, which cannot be ignored or handled by the process, resulting in an immediate termination.
#   - Use this function with caution, as `kill -9` does not allow processes to clean up resources or gracefully exit.
#
# Dependencies:
#   - `lsof`: The function requires the `lsof` command to list open files and network connections.
#
function kp() {
  kill -9 $(lsof -t -i:$1)
}

# Function: fw
#
# Description:
#   The `fw` function is used to quickly navigate to a subdirectory within a specified directory (defaulting to $WORKSPACE_FOLDER),
#   with optional functionality to change the tmux or Zellij window name, handle bare Git repositories, and open Neovim.
#
# Usage:
#   fw [location] [is_changed_tmux_window_name] [is_open_nvim]
#
# Parameters:
#   location                     - (Optional) The base directory to search for subdirectories. Defaults to $WORKSPACE_FOLDER.
#   is_changed_tmux_window_name  - (Optional) Boolean flag to indicate if the tmux or Zellij window name should be changed after navigating. Defaults to false.
#   is_open_nvim                 - (Optional) Boolean flag to indicate if Neovim should be opened in the selected directory. Defaults to false.
#
# Behavior:
#   - Prompts the user to select a subdirectory within the specified location using `fzf`.
#   - Changes the current directory to the selected subdirectory.
#   - Optionally changes the tmux or Zellij window name based on the `is_changed_tmux_window_name` flag.
#   - Checks if the selected directory is a bare Git repository and checks out a branch if it is.
#   - Optionally opens Neovim in the selected directory based on the `is_open_nvim` flag.
#   - If no folder is selected, the function prints "No folder selected".
#
# Example:
#   fw ~/projects true true
#   This will navigate to a subdirectory within `~/projects`, change the tmux or Zellij window name, and open Neovim.
#
# Notes:
#   - The function relies on external utilities like `fzf`, `ls`, and `nvim`.
#   - The `dn` function (assumed to be defined elsewhere) is used to change the window name in tmux or Zellij.
#   - The `gcoo` function (assumed to be defined elsewhere) checks out a branch in a bare Git repository.
#
# Dependencies:
#   - `fzf`: Used for fuzzy searching and selecting a subdirectory.
#   - `nvim`: Optional, used to open Neovim.
#   - Custom functions: `dn`, `gcoo`, `is_bare_repo` should be defined elsewhere in your environment.
#
function fw() {
  loc=${1:=$WORKSPACE_FOLDER}
  is_changed_tmux_window_name=${2:=false}
  is_open_nvim=${3:=false}
  before="$PWD"

  dir=$(ls -d --color=never $loc/*/ | sed 's#/$##' | sed "s#$loc/##" | fzf --ansi --preview "ls -lA $loc/{}")

  if [ ! -z $dir ]; then
    cd $loc"/"$dir

    if [ -n $TMUX ] && $is_changed_tmux_window_name; then
      dn
    fi

    if [ -n $ZELLIJ ] && $is_changed_tmux_window_name; then
      dn
    fi

    if is_bare_repo; then
      gcoo
      if [ $? -eq 1 ]
      then
        cd $before
      fi
    fi

    if $is_open_nvim; then
      nvim
    fi

  else
    echo "No folder selected"
  fi
}

function fww() {
  fw ${1:=$WORKSPACE_FOLDER} true false
}

function ff() {
  fw ${1:=$WORKSPACE_FOLDER} false true
}

function fff() {
  fw ${1:=$WORKSPACE_FOLDER} true true
}

# set tmux window title as current directoty
function dn() {
  # Extract the base name of the current working directory
  #
  # ${PWD} is a special shell variable that holds the path of the current
  # working directory. For example, if you are in:
  #   /home/user/projects/myapp
  # then ${PWD} contains the string '/home/user/projects/myapp'.
  #
  # The syntax ${PWD##*/} is a parameter expansion technique:
  # - '##' indicates that we want to remove the longest match of the pattern.
  # - '*/' is the pattern which matches any characters followed by a '/'.
  #
  # By using ${PWD##*/}, we are effectively removing everything before
  # and including the last '/' in the path. The result is the base name
  # of the current directory.
  #
  # For example, if ${PWD} is '/home/user/projects/myapp', then:
  #   ${PWD##*/} results in 'myapp', which is the name of the current directory.
  #
  # Assign this base name to the variable 'window_name'.
  window_name=$(echo ${PWD##*/})
  if is_bare_repo; then
    bare_path=$(get_bare_path) # only get bare path
    window_name=${bare_path:t}
  fi

  if [[ -n $TMUX ]]; then
    tmux rename-window $window_name
  fi

  if [[ -n $ZELLIJ ]]; then
    zellij action rename-tab $window_name
  fi

}

# tmux layout
function tl() {
  tmux killp -a
  tmux clock-mode
  tmux splitw
  tmux selectl main-vertical
}

function dd() {
  # osascript -e 'display notification "hello world!" with title "Greeting" subtitle "More text" sound name "Submarine"'
  osascript -e "display notification \"${1:=Done!}\" with title \"${2:=${PWD/~\//}}\" sound name \"Submarine\""
}

function stow_all() {
  # Default exclusion patterns
  local exclude_patterns=(".git" "README" "non-stow")

  # Check for options
  case "$1" in
    -h|--help)
      echo "Usage: stow_all [OPTIONS]"
      echo "Stow all directories in the specified DOTFILES directory, excluding certain patterns."
      echo
      echo "Options:"
      echo "  -v, --verbose   Enable verbose output."
      echo "  -e, --exclude   Specify additional patterns to exclude (comma-separated)."
      echo "  -h, --help      Show this help message."
      return
      ;;

    -v|--verbose)
      local verbose=1
      ;;

    -e|--exclude)
      # Additional exclusions passed as a comma-separated list
      IFS=',' read -r -a extra_excludes <<< "$2"
      exclude_patterns+=("${extra_excludes[@]}")
      ;;
  esac

  # Combine exclusions into a single sed pattern
  local sed_pattern=$(printf "/%s/ d;" "${exclude_patterns[@]}")

  # List directories and stow them
  local dirs_to_stow=$(ls -A1 "$DOTFILES" | sed "$sed_pattern")

  if [[ -n "$verbose" ]]; then
    echo "Stowing the following directories:"
    echo "$dirs_to_stow"
  fi

  echo "$dirs_to_stow" | xargs -I{} stow {}

  if [[ $? -eq 0 ]]; then
    echo "Stowed all folders successfully."
  else
    echo "Error: Failed to stow some folders." >&2
    return 1
  fi
}

# }}}

_command_time_preexec() {
  # check excluded
  if [ -n "$ZSH_COMMAND_TIME_EXCLUDE" ]; then
    cmd="$1"
    for exc ($ZSH_COMMAND_TIME_EXCLUDE) do;
      if [ "$(echo $cmd | grep -c "$exc")" -gt 0 ]; then
        # echo "command excluded: $exc"
        return
      fi
    done
  fi

  timer=${timer:-$SECONDS}
  ZSH_COMMAND_TIME_MSG=${ZSH_COMMAND_TIME_MSG-"Time: %s"}
  ZSH_COMMAND_TIME_COLOR=${ZSH_COMMAND_TIME_COLOR-"white"}
  export ZSH_COMMAND_TIME=""
}

_command_time_precmd() {
  if [[ $timer ]]; then
    timer_show=$(($SECONDS - $timer))
    if [ -n "$TTY" ] && [ $timer_show -ge ${ZSH_COMMAND_TIME_MIN_SECONDS:-3} ]; then
      export ZSH_COMMAND_TIME="$timer_show"
      if [ ! -z ${ZSH_COMMAND_TIME_MSG} ]; then
        zsh_command_time
      fi
    fi
    unset timer
  fi
}

zsh_command_time() {
  if [[ -n "$ZSH_COMMAND_TIME" ]]; then
    timer_show=$(printf '%dh:%02dm:%02ds\n' $(($ZSH_COMMAND_TIME/3600)) $(($ZSH_COMMAND_TIME%3600/60)) $(($ZSH_COMMAND_TIME%60)))
    print -P "%F{$ZSH_COMMAND_TIME_COLOR}$(printf "${ZSH_COMMAND_TIME_MSG}\n" "$timer_show")%f"
  fi
}

# !IMPORTANT
# Overriden settings should be very last statement for override standard configuration
# [[ -f $HOME/.config/zsh/override.zsh ]] && source $HOME/.config/zsh/override.zsh

precmd_functions+=(_command_time_precmd)
preexec_functions+=(_command_time_preexec)
#
# End profiling (uncomment when necessary)
#

# Per-command profiling:

# unsetopt xtrace
# exec 2>&3 3>&-

# Per-function profiling:

# zprof
