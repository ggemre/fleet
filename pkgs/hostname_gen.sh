#!/usr/bin/env bash
#
# General considerations gleaned from
# _Requirements for Internet Hosts -- Application and Support_
# https://datatracker.ietf.org/doc/html/rfc1123
# 1. Keep hostnames under 16 chars long
#    (most services allow for much longer but we want the fullest compat)
# 2. You should use alphanumeric chars and hyphens [a-zA-Z0-9-], other
#    chars, e.g. underscores, may not be supported by all DNS protocols
# 3. Favor lowercase characters
#
# Deterministically generate a hostname using the machine's operating system and architecture,
# the host's intended role/purpose, and the current date. 

set -euo pipefail

declare -A roles
roles=(
  ["Workstation"]="wrk"
  ["Server"]="srv"
  ["Installer"]="iso"
  ["Gaming"]="gm"
)

HOSTS_DIR=../hosts

while true; do
  SYSTEM=$(gum choose "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" --header "Select the system:")
  ROLE=$(gum choose "${!roles[@]}" --header "Select the role (this is the primary purpose of the host):")

  
  case $SYSTEM in
    *linux) 
      SYSTEM_CODE="nix" 
      ;;
    *darwin) 
      SYSTEM_CODE="dwn" 
      ;;
    *) 
      SYSTEM_CODE="unknown" # In theory, this should never hit
      ;;
  esac
  ROLE_CODE=${roles[$ROLE]}

  echo "✅ Selected system: $SYSTEM"
  echo "✅ Selected role: $ROLE"

  if gum confirm; then
    MMDD=$(date +%m%d)
    HOSTNAME="$SYSTEM_CODE-$ROLE_CODE-$MMDD"

    base_name="$HOSTNAME"
    new_name="$base_name"

    # Really shitty logic to append a letter there's a name collision
    if [[ ! -d "$HOSTS_DIR/$new_name" ]]; then
      echo "✅ Hostname is unique"
    else
      echo "❕ Hostname is not unique, appending a suffix"
      suffix="a"
      new_name="${base_name}${suffix}"
      while [[ -d "$HOSTS_DIR/$new_name" ]]; do
        suffix=$(echo "$suffix" | tr "a-y" "b-z")  # Move to next letter
        new_name="$base_name$suffix"
      done
    fi
    
    echo "🎉 Your hostname is $new_name"
    break
  else
    echo "🔁 Trying again"
  fi
done

