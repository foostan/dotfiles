function peco-ssh() {
  ssh $(awk '
    tolower($1)=="host" {
      for (i=2; i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
  ' ~/.ssh/config | sort | peco --layout=bottom-up)
}
zle -N peco-ssh
bindkey '^s' peco-ssh
