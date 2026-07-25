#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A generic script template. Add more to the description here.

# Version: 1.0
# Changelog:
# - Script name variable for logging
# - Non-XDG-compliant paths for library folder
# - Import of shell helper script
# - Generic gate for checking for an input file
# - Generic function shell
# - Main program block calling the function to do something
# Version: 1.1
# - Added commented block to check if the script is sourced, which is sometime required,
#   for example if you need to set or update environment variables for the shell that invokes the script.
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
GENERIC_SCRIPT_TEMPLATE_SCRIPT=`basename "${0}"`
# Library directory:
# LIB_DIR="./lib"
# OR
LIB_DIR="${HOME}/lib"
# Generic shell helper script:
SHELL_HELPER_SCRIPT="${LIB_DIR}/shell_helpers.sh"
# Input file: Supply an input file at parameter $1
GENERIC_INPUT_FILE="${1}"

# Import generic shell helpers script:
if [ -e "$SHELL_HELPER_SCRIPT" ]; then
  source "$SHELL_HELPER_SCRIPT"
else
  echo "${GET_SOURCES_SCRIPT}: Shell helper script not found where expected: $SHELL_HELPER_SCRIPT, cannot continue!"
  exit 1 # Cannot use die here as the method is in the shell helper script
fi

# Check if this script is called via `source` if required:
## We're running Bash:
#if [ -n "$BASH_VERSION" ]; then
#  [[ "${BASH_SOURCE[0]}" != "$0" ]] && sourced=1
## We're running Zsh:
#elif [ -n "$ZSH_VERSION" ]; then
#  [[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && sourced=1 || sourced=0
#fi

## Validate if script is sourced or not, if not, die gracefully:
#if [[ $sourced -eq 0 ]]; then
#  die "${RED}You need to invoke this script through \`source\`!${NOCOL}\n${PURPLE}Usage: ${ORANGE}\`source <path>/"${GENERIC_SCRIPT_TEMPLATE_SCRIPT}"\`${NOCOL}\n"
#fi

# Check input file is supplied:
#if [ -z "${GENERIC_INPUT_FILE}" ]; then
#  die "${RED}You need to provide an ${YELLOW}input file ${RED} as an argument!\n${BLUE}\nUsage: \`${ORANGE}$GENERIC_SCRIPT_TEMPLATE_SCRIPT ${LCYAN} <input file>${BLUE}\`${NOCOL}\n"
#fi

# End of Setup and configuration

# Functions:
# Add a function:
magicFunction () {
  # Do some magic..
  echo -e "${LIME_GREEN}${RED}C${GREEN}o${BLUE}l${CYAN}o${LCYAN}u${ORANGE}r${WHITE}i${YELLOW}s${PURPLE}e${RED}d!${LIME_GREEN} stdout ${LCYAN}with different colours, ${LIME_GREEN}making sure we always terminate our echo statements with NOCOL${NOCOL}"
}

# End of Functions

# Main program:

# Do something..
magicFunction

exit 0
