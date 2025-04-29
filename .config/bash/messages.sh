#!/bin/bash

info_message() {
  local message="$1"
  tput setab 4
  tput setaf 7
  printf " INFO "
  tput sgr0
  printf " %s\n" "$message"
}

success_message() {
  local message="$1"
  tput setab 2
  tput setaf 7
  printf " SUCCESS "
  tput sgr0
  printf " %s\n" "$message"
}

error_message() {
  local message="$1"
  tput setab 1
  tput setaf 7
  printf " ERROR "
  tput sgr0
  printf " %s\n" "$message"
}

warning_message() {
  local message="$1"
  tput setab 3
  tput setaf 7
  printf " WARNING "
  tput sgr0
  printf " %s\n" "$message"
}

debug_message() {
  local message="$1"
  tput setab 5
  tput setaf 7
  printf " DEBUG "
  tput sgr0
  printf " %s\n" "$message"
}
