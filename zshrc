# Danny Cosson ZSH config

# Turn on completion, using homebrew zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# fzf fuzzy search setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh settings for history
# HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|cd|cd ..|cd..)"
HISTSIZE=25000
HISTFILE=~/.zsh_history
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Helper functions
filehashcmp() {
    hash1="$(shasum -a 256 "$1" | awk '{print $1}')"
    hash2="$(shasum -a 256 "$2" | awk '{print $1}')"
    if [ "$hash1" == "$hash2" ]; then echo "Files are the same"; else echo "Not the same"; fi
}

### Source additional files, to allow for custom config on different machines
[[ -f ~/.zshrc_extensions ]] && source ~/.zshrc_extensions
[[ -f ~/.zshrc_secrets ]] && source ~/.zshrc_secrets


# Prompt setup
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
current_virtualenv() {
  echo "$(basename $(dirname $VIRTUAL_ENV 2>/dev/null) 2>/dev/null)/$(basename $VIRTUAL_ENV 2>/dev/null)"
}
current_kubectl_context() {
  echo "$(kubectl config current-context 2>/dev/null)"
}
current_kubectl_context_namespace() {
  echo "$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null || echo 'N/A')"
}
function __prompt_command() {
  local LAST_EXIT_CODE="$?"

  ### Define PS1
  # extra vertical space
  PS1=$'\n'
  # username @ hostname, then indicate previous exit code
  PS1+="%F{green}%n %F{white}@ %F{yellow}%m%f"
  # kubectl context, if we're in one
  _current_kubectl_context="$(current_kubectl_context)"
  if [ -n "$_current_kubectl_context" ]
  then
    PS1+=" %F{magenta}kube:$_current_kubectl_context:$(current_kubectl_context_namespace)%f"
  fi
  # python virtualenv, if we're in one
  _current_virtualenv="$(current_virtualenv)"
  if [ -n "$_current_virtualenv" ]
  then
    PS1+=" %F{blue}($_current_virtualenv)%f"
  fi
  # sun or rain based on last exit code
  if [ $LAST_EXIT_CODE = 0 ]
  then
    PS1+=" %F{green}☀%f"
  else
    PS1+=" %F{blue}☁%f"
  fi
  PS1+=$'\n'
  # pwd, git branch and prompt
  PS1+="%F{magenta}%~%f "
  PS1+="$(parse_git_branch)"
  PS1+=" %# "
}
precmd() { eval __prompt_command }
# PROMPT=$'\n'
# # Top line: user @ host kube-context (virtualenv) last-command-status
# PROMPT+="%F{green}%n %F{white}@ %F{yellow}%m %f"
# PROMPT+=$'\n'
# PROMPT+="%F{magenta}%~%f %# "
# export PROMPT
