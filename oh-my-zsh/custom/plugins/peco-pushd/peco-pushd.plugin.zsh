peco-pushd() {
  local FILENAME="$1"
  local MAXDEPTH="${2:-5}"
  local BASE_DIR="${3:-`pwd`}"

  if [ -z "$FILENAME" ] ; then
    echo "Usage: peco-pushd <FILENAME> [<MAXDEPTH> [<BASE_DIR>]]" >&2
    return 1
  fi

  local DIR=$(find ${BASE_DIR} -maxdepth ${MAXDEPTH} -name ${FILENAME} | peco | head -n 1)

  if [ -n "$DIR" ] ; then
    DIR=${DIR%/*}
    echo "pushd \"$DIR\""
    pushd "$DIR"
  fi
}
zle -N peco-pushd

peco-pushd-git() {
  peco-pushd ".git" 5 "$GOPATH"
}
zle -N peco-pushd-git
bindkey '^g' peco-pushd-git

peco-pushd-docker() {
  peco-pushd "Dockerfile" 5 "$GOPATH"
}
zle -N peco-pushd-docker

peco-pushd-vagrant() {
  peco-pushd "Vagrantfile" 5 "$GOPATH"
}
zle -N peco-pushd-vagrant

