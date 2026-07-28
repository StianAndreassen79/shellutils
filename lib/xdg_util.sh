#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# XDG utility script
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Added checks for paths
# TODO:
# - Add functionality to update .zshrc
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
XDG_SCRIPT=$(basename "${0}")
# XDG base: (This is not in the XDG specification)
XDG_BASE="${HOME}/.local"
XDG_LIB_DIR="${XDG_BASE}/lib"
XDG_ENV_SCRIPT="${XDG_LIB_DIR}/xdg_env.sh"

# Generic shell helper script:
SHELL_HELPER_SCRIPT="${XDG_LIB_DIR}/shell_helpers.sh"

# Import generic shell helpers script:
if [ -e "${SHELL_HELPER_SCRIPT}" ]; then
  source "${SHELL_HELPER_SCRIPT}"
else
  echo "${XDG_SCRIPT}: Shell helper script not found where expected: ${SHELL_HELPER_SCRIPT}, cannot continue!"
  exit 1 # Cannot use die here as the method is in the shell helper script
fi

# Main program:
echo "Add function to update zshrc"

exit 0