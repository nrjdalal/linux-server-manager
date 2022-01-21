_ONLYSUDO() {
  if [[ $(id -u) -ne 0 ]]; then
    _FAILURE "Given command requires sudo access!"
  fi
}

_ONLYUSER() {
  if [[ $(id -u) -eq 0 ]]; then
    _FAILURE "Don't run this as root!"
  fi
}
