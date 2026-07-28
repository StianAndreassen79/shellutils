#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# Uninstaller script for shellutils
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Script name variable for logging
# - Uninstall statements for:
#   - xdg_env.sh
#   - colours.sh symlink and source file
#   - XDG paths
#   - shell_helpers.sh
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
UNINSTALL_SCRIPT=$(basename "${0}")
SELF=$(realpath "$0")
LIB_NAME=$(basename "${PWD}")

# Configuration:
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="${CONFIG_HOME}/shellutils/shellutils.conf"

# Set configuration:
if [ -e "${CONFIG_FILE}" ]; then
  source "${CONFIG_FILE}"
else
  echo -e "${UNINSTALL_SCRIPT}: Config file: '${CONFIG_FILE}' was not found where expected. You might need to remove XDG_BASE/lib/${LIB_NAME} manually"
  exit 1
fi

# Remove installed components:
cd "${CONFIG_HOME}"
echo "${UNINSTALL_SCRIPT}: Recursively removing '${LIB_NAME}' from ${CONFIG_HOME}:"
rm -Rf "${LIB_NAME}"
if [ -d "${XDG_LIB_HOME}" ]; then # We check for this explicitly as the 
  cd "${XDG_BASE}/lib/"
  echo "${UNINSTALL_SCRIPT}: Recursively removing '${LIB_NAME}' from ${XDG_BASE}/lib/"
  rm -Rf "${LIB_NAME}"
else
  echo "${UNINSTALL_SCRIPT}: Path: '${XDG_LIB_HOME}' was not found"
fi
cd "${XDG_DATA_HOME}"
rm -f "${LIB_NAME}/colours_v${COLOURS_VERSION}.sh"
rm -f "${LIB_NAME}/colours.tgz"
echo "${UNINSTALL_SCRIPT}: Removing '${UNINSTALL_SCRIPT}' from ${XDG_DATA_HOME}/${LIB_NAME}"
rm -f -- "$SELF"
echo "${UNINSTALL_SCRIPT}: Removing directory '${LIB_NAME}' from ${XDG_DATA_HOME}"
rmdir "$LIB_NAME" 2>/dev/null

exit 0