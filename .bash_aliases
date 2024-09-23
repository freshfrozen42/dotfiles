set -u

confirm() {
  if [[ $# -eq 0  ]]; then
    return
  fi

  read -p 'y[N] ' choice
  [[ $choice =~ ^[yY]$ ]] && "$@"
}

cht() {
  [[ $# -eq 0 ]] && return
  curl cheat.sh/"$1"
}

enc-file-gpg() {
  if [[ -d $1 ]]; then
    echo "Cannot encrypt a directory."
    return
  fi

  if [[ ! -f $1 ]]; then
    return
  fi

  gpg \
    --symmetric \
    --cipher-algo aes256 \
    --s2k-count 65011712 \
    --pinentry-mode loopback \
    --no-symkey-cache \
    $1
}

dec-file-gpg() {
  if [[ ! -f $1 ]]; then
    return
  fi

  _file=$(basename $1 | sed 's\.gpg$\\')
  
  gpg \
    --decrypt \
    --pinentry-mode loopback \
    --no-symkey-cache \
    --output $_file \
    $1
}

alias poweroff="confirm poweroff"
alias reboot="confirm reboot"
alias swayidle_status="ps -aux | grep swayidle | head -n1"
