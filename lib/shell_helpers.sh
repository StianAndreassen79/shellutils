#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A generic shell helper library so you don't have to re-write the same useful stuff every time.

# This includes:
# - checking if XDG paths and directories are correct and present
# - colourisation library
# - signal traps for more control of process execution, status and termination
# - method to die gracefully with a colourised message

# Changelog:
# Version: 1.2.1
# - Updates from ShellCheck:
# - backticks disablement
# - replace `! -z` with `-n`
# - added `-r` to instances of `read`
# Version: 1.2
# - Made XDG compatible, using ~/.local, ~/.config and other XDG conventions instead of generics
# Version: 1.1
# - Added function to launch the default browser: launch_browser
# - Added generic function for prompting for y / n, sending a question and a default answer

# TODO:
# - Add support for xclip and xsel under Linux with Linux detection in the copy_to_clipboard function
# - Add support for enabling/disabling copy to clipboard functionality from translate_epoch_time.sh
# ######################################################################################################################

# Setup and configuration:

# Trap signals:
trap 'die' SIGINT QUIT

# Generic globals for this script:
# Script name:
SHELL_HELPERS_SCRIPT=$(basename "${0}")
# Set configuration:
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="${CONFIG_HOME}/shellutils/shellutils.conf"

# Load configuration:
if [ -e "${CONFIG_FILE}" ]; then
  source "${CONFIG_FILE}"
else
  echo -e "${SHELL_HELPERS_TEST_SCRIPT}: Config file: '${CONFIG_FILE}' was not found where expected. Please run install.sh"
  exit 1
fi

# The XDG_ENV_SCRIPT should likely not need to be sourced during normal operations, it is mainly used by the installer. Leaving commented for noe
# Check XDC environment variables script and source it:
#if [ ! -e "${XDG_ENV_SCRIPT}" ]; then
#  echo -e "${SHELL_HELPERS_SCRIPT}: XDG environment script '${XDG_ENV_SCRIPT}' does not exist, please run install.sh"
#  exit 1
#else
#  source "${XDG_ENV_SCRIPT}"
#fi

# Check XDC Base directory:
if [ ! -d "${XDG_BASE}" ]; then
  echo -e "${SHELL_HELPERS_SCRIPT}: XDG Base: '${HOME}/.local' does not exist, please run install.sh"
  exit 1
fi

# Check XDG lib directory:
if [ ! -e "${XDG_LIB_HOME}" ]; then
  echo "${SHELL_HELPERS_SCRIPT}: XDG lib directory '${XDG_LIB_HOME}' not found, please run install.sh"
  exit 1
fi

# Check source file for colours script:
if [ ! -e "${COLOURS_SCRIPT}" ]; then
  echo -e "${SHELL_HELPERS_SCRIPT}: The colourisation file is not found at '${COLOURS_SCRIPT}', please run install.sh"
  exit 1
fi

# End of Setup and configuration

# Functions:
# Die function to exit gracefully from any script that sources this helper script:
die () {
  echo -e "${NOCOL}"
  echo -e >&2 "$@"
  exit 1
}

# Function to colourise shell script output from any script that sources this helper script:
colourise () {
  source "${COLOURS_SCRIPT}"
}

# Function to copy something to the clipboard:
copy_to_clipboard() {
  local VALUE_TO_COPY="${1}"
  # WSL or GitBash on Windows:
  if [ -n "${WSL_DISTRO_NAME}" ] || printenv WINDIR >/dev/null 2>&1; then
    printf "%s" "${VALUE_TO_COPY}" | clip.exe
  fi

  # macOS
  if uname -s | grep -q Darwin; then
    printf "%s" "${VALUE_TO_COPY}" | pbcopy
  fi
}

# Useed by the askyesno() function to ensure we have a valid response
validyesno() {
  local response="$1"
  if [[ "$response" =~ ^([Yy]([Ee][Ss])?|[Nn]([Oo])?)$ ]]; then
    return 0
  else
    return 1
  fi
}

# Useed by the askyesno() function to return a Booelan based on the string answer
returnyesno() {
  local answer="$1"
  if [[ "$answer" =~ ^([Yy]([Ee][Ss])?)$ ]]; then
    return 0
  elif [[ "$answer" =~ ^([Nn]([Oo])?)$ ]]; then
    return 1
  fi
}

# Function to prompt for yes / no:
# NOTE: this function returns:
# 0 for any permutation of 'yY' or 'yes'
# and
# 1 for any permutation of 'n' or 'no'
# If the user click enter at the prompt, the default answer is used,
# Usage:
# 1. Ask the question with the default answer. The default answer is required.
# askyesno "${YELLOW}Would you like to do this task?${NOCCOL}" "n"
# OR
# askyesno "${YELLOW}Would you like to do this task?${NOCCOL}" "y"
# 2. Evaulate the answer:
# if [ $? -eq 0 ]; then
#   # Do something useful for 'yes'
# fi
askyesno() {
  local question="${1}"
  local default_answer="${2}"
  # Check that we have both parameters:
  if [ -n "${question}" ] && [ -n "${default_answer}" ]; then
    # Construct the answer prompt:
    local answer_prompt="${PURPLE}[${GREEN}${default_answer}${PURPLE}]${NOCOL}"
    echo -e -n "${question} ${answer_prompt} "
    read -r response
    response=${response:-${default_answer}}
    if ! validyesno "$response"; then
      # Loop until you've got a valid yes/no response:
      while true; do
        echo -e "${WHITE}Please answer: ${LIME_GREEN}y ${YELLOW}/ ${LIME_GREEN}n !${NOCOL}"
        echo -e -n "${question} ${answer_prompt} "
        read -r response
        response=${response:-${default_answer}}
        if validyesno "$response"; then
          break
          returnyesno "${response}"
        fi
      done
    fi
    # We have a valid response:
    returnyesno "${response}"
  else
    die "${RED}${SHELL_HELPERS_SCRIPT}: You need to supply a ${YELLOW}question and a default answer parameter${RED} to use the \`askyesno\` function!${NOCOL}"
  fi
}

# Function to launch the default browser, will open a new tab if a browsser window is already open, or open a new browser window if the default browser is not running:
launch_browser() {
  local URL="${1}"
  if [ -n "${URL}" ]; then
    if [[ "$OSTYPE" == darwin* ]]; then
      open "${URL}"
    elif [[ "$OSTYPE" == "linux"* ]]; then
      xdg-open "${URL}" >/dev/null 2>&1 &
    fi
  else
    die "${RED}${SHELL_HELPERS_SCRIPT}: You need to supply a ${YELLOW}URL parameter ${RED}to use the \`launch_browser\` function!${NOCOL}"
  fi
}

# Colourise script output:
colourise
