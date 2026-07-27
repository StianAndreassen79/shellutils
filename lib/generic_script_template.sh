#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A generic script template. Add more to the description here.
# ######################################################################################################################
# Version: 1.2
# ######################################################################################################################
# How to use this template:
# 1. Copy this script to a new file.
# 2. Replace the default Description with something that makes sense for your script.
# 3. Substitute GENERIC_SCRIPT_TEMPLATE_SCRIPT with <YOUR_SCRIPT>.
# 4. Un-comment the EXAMPLE_LIB_DIR if required.
#    This is in addition to the XDG path, if the required EXAMPLE_LIB_DIR is outside of XDG
# 5. Substitute the `magicFunction` with something that makes sense, or remove it if not required.
# 6. Un-comment any setup and configuration blocks you might need to use.
# 4. Set the version. Note that the populated version is the template version.
# 5. Populate the changelog for the initial version. Use the below as a template, and substitute the changelog entries
#    with something that makes sense for the initial version.
# 7. Delete this how-to block.
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Script name variable for logging
# - Non-XDG-compliant paths for library folder
# - Import of shell helper script
# - Generic gate for checking for an input file
# - Generic function shell
# - Main program block calling the function to do something
# Version: 1.1
# - Added commented block to check if the script is sourced, which is sometime required,
#   for example if you need to set or update environment variables for the shell that invokes the script.
# - Re-ordered version and changelog comment headers.
# - Fixed path and variables for sourcing helper script, and helper script not found error
# - Added how-to-use list
# Version: 1.2
# - Made XDC compliant
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
GENERIC_SCRIPT_TEMPLATE_SCRIPT=$(basename "${0}")
# Library directories:
# EXAMPLE_LIB_DIR="./lib" # LIB_DIR different to the XDG path
# OR generically:
# LIB_DIR="${HOME}/lib"
# XDG base:
XDG_BASE="${HOME}/.local"
# XDG lib directory:
XDG_LIB_DIR="${XDG_BASE}/lib"
# XDG environment variables scripty:
XDG_ENV_SCRIPT="${XDG_LIB_DIR}/xdg_env.sh"
# Generic shell helper script:
SHELL_HELPER_SCRIPT="${XDG_LIB_DIR}/shell_helpers.sh"

# Input file: Supply an input file at parameter $1
GENERIC_INPUT_FILE="${1}"

# Import generic shell helpers script:
if [ ! -e "${SHELL_HELPER_SCRIPT}" ]; then
  echo "${SHELL_HELPERS_TEST_SCRIPT}: Shell helper script not found where expected: ${SHELL_HELPER_SCRIPT}, please run install.sh!"
  exit 1
else
 source "${SHELL_HELPER_SCRIPT}"
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
