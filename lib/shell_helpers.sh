#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A generic shell helper library so you don't have to re-write the same useful stuff every time.

# This includes:
# - checking if XDG paths and directories are correct and present
# - colourisation library
# - signal traps for more control of process execution, status and termination
# - method to die gracefully with a colourised message

# Version: 1.0
# TODO:
# - Make XDG compatible
# - Add support for xclip and xsel under Linux with Linux detection in the copy_to_clipboard function
# ######################################################################################################################

# Setup and configuration:

# Script name:
SHELL_HELPERS_SCRIPT=`basename "${0}"`

# Trap signals:
trap 'die' SIGINT QUIT

# Generic globals for this script:
# Library directory:
LIB_DIR="${HOME}/lib"
# If the path needs to be relative to the script, it typically becomes:
# LIB_DIR="./lib"
# Generic config and cache directories:
CONFIG_DIR="${HOME}/.config"
CACHE_DIR="${HOME}/.cache"
# Custom colourisation constants file:
COLOUR_CONSTANTS="$CONFIG_DIR/colours.h"

# Ensure ~/.lib/ exists:
if [ ! -d $LIB_DIR ]; then
   echo -e "${SHELL_HELPERS_SCRIPT}: Local lib directory ${LIB_DIR} does not exist, creating.."
   mkdir $LIB_DIR
fi

# AND / OR:

# Ensure ./lib/ exists: (change the variable name here if both apply)
#if [ ! -d $LIB_DIR ]; then
#   echo -e "${SHELL_HELPERS_SCRIPT}: Script lib directory ${LIB_DIR} does not exist, creating.."
#   mkdir $LIB_DIR
#fi

# Ensure ~/.config/ exists:
if [ ! -d $CONFIG_DIR ]; then
   echo -e "${SHELL_HELPERS_SCRIPT}: Local config directory ${CONFIG_DIR} does not exist, creating.."
   mkdir $CONFIG_DIR
fi

# Ensure ~/.cache/ exists:
if [ ! -d $CACHE_DIR ]; then
  echo -e "${SHELL_HELPERS_SCRIPT}: Local cache directory ${CACHE_DIR} does not exist, creating.."
  mkdir $CACHE_DIR
fi

# Die function to exit gracefully from any script that sources this helper script:
die () {
  echo -e "${NOCOL}"
  echo -e >&2 "$@"
  exit 1
}

# Function to colourise shell script output from any script that sources this helper script:
colourise () {
  source ${COLOUR_CONSTANTS}
}

# Function to copy something to the clipboard:
copy_to_clipboard() {
  local VALUE_TO_COPY="${1}"
  # WSL or GitBash on Windows:
  if [ ! -z ${WSL_DISTRO_NAME} ] || printenv WINDIR >/dev/null 2>&1; then
    printf "%s" ${VALUE_TO_COPY} | clip.exe
  fi

  if uname -s | grep -q Darwin; then
    printf "%s" "${VALUE_TO_COPY}" | pbcopy
  fi
}

# Check lib directory:
if [ ! -d $LIB_DIR ]; then
  echo "${SHELL_HELPERS_SCRIPT}: Library directory $LIB_DIR not found, cannot continue!"
  exit 1
fi

# Check source file for colours header file:
COLOURS_HEADER_SOURCE="${LIB_DIR}/colours.tgz"
if [ ! -e $COLOURS_HEADER_SOURCE ]; then
  echo -e "${SHELL_HELPERS_SCRIPT}: The colour constants header source file is not found at ${COLOURS_HEADER_SOURCE}, cannot continue!"
  exit 1
fi

if [ ! -e "$COLOUR_CONSTANTS" ]; then
  echo -e "${SHELL_HELPERS_SCRIPT}: The colour constants header file is not found at ${COLOUR_CONSTANTS}.\n"
  echo -e -n "${SHELL_HELPERS_SCRIPT}: Would you like to install it to ${CONFIG_DIR} now? [y] "
  read -r response
  response=${response:-y}

  if [[ "$response" == [Yy]* ]]; then
    tar -xf "${COLOURS_HEADER_SOURCE}" -C "${CONFIG_DIR}"
    echo -e "${SHELL_HELPERS_SCRIPT}: Installed the shell colours header file to ${CONFIG_DIR}"
    colourise
    echo -e "${YELLOW}${SHELL_HELPERS_SCRIPT}: ${GREEN}Script output is now ${RED}c${GREEN}o${BLUE}l${CYAN}o${LCYAN}u${ORANGE}r${WHITE}i${YELLOW}s${PURPLE}e${RED}d!${NOCOL}"
    echo -e "${YELLOW}${SHELL_HELPERS_SCRIPT}: ${LIME_GREEN}Executing the remainder of the parent script..${NOCOL}\n"
  else
    echo -e "${SHELL_HELPERS_SCRIPT}: ERROR: The shell colours header file was not installed, script output would have printed ANSI colourisation codes!\n"
    echo -e "${SHELL_HELPERS_SCRIPT}: Please run your script again to install the colourisation file."
    exit 1
  fi
else
  colourise
fi