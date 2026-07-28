#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# XDG environment variables
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Declared required environment variables
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
LIB_NAME="shellutils"
# XDG base: (This is not in the XDG specification)
export XDG_BASE="${HOME}/.local"
# XDG Base Directories:
# Relative to ${HOME}:
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
# Relative to ${XDG_BASE}:
export XDG_DATA_HOME="${XDG_BASE}/share"
export XDG_STATE_HOME="${XDG_BASE}/state"
export XDG_RUNTIME_DIR="$TMPDIR/xdg_runtime"
# This is not in the XDG specification
export XDG_LIB_HOME="${XDG_BASE}/lib/${LIB_NAME}"
# This is specific to shellutils:
export XDG_SHARE_DIR="${XDG_DATA_HOME}/${LIB_NAME}"
export CONFIG_PATH="${XDG_CONFIG_HOME}/${LIB_NAME}"
export CONFIG_FILE="${CONFIG_PATH}/${LIB_NAME}.conf"

# End of Setup and configuration