# Base aliases — available on all machines

alias opr='gh pr view --web'
alias idea='open -na "IntelliJ IDEA.app" --args "$@"'
alias hz='history | fzf'

# Claude Code
alias cc="claude --enable-auto-mode"
alias ccc="claude --continue"

cw() {
  if [ -n "$1" ]; then
    feature_name="$1"
  else
    vared -p 'Feature name: ' -c feature_name
  fi

  if [ -z "$feature_name" ]; then
    echo "No feature name provided"
    return 1
  fi

  claude --enable-auto-mode --worktree "$feature_name"
  unset feature_name
}
