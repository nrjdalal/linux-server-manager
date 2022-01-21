success() {
  printf "${green}%s${OFF}\n" "$@"
}

_SUCCESS() {
  printf "${GREEN}   ${OFF}${BOLD}${green} %s${OFF}\n\n" "$@"
  exit 0
}

failure() {
  printf "${red}%s${OFF}\n" "$@"
}

_FAILURE() {
  printf "${RED}   ${OFF}${BOLD}${red} %s${OFF}\n\n" "$@"
  exit 1
}
