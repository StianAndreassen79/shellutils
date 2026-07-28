#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A test script from the generic_script_template.sh v1.2 template.
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# Testing:
# - shell_helpers.sh: askyesno
# - shell_helpers.sh: script name in die messages

# Setup and configuration:

# Generic globals for this script:
# Script name:
SHELL_HELPERS_TEST_SCRIPT=$(basename "${0}")
# Configuration:
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_FILE="${CONFIG_HOME}/shellutils/shellutils.conf"

# Set configuration:
if [ -e "${CONFIG_FILE}" ]; then
  source "${CONFIG_FILE}"
else
  echo -e "${SHELL_HELPERS_TEST_SCRIPT}: Config file: '${CONFIG_FILE}' was not found where expected. Please run install.sh"
  exit 1
fi

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
#  die "${RED}You need to invoke this script through \`source\`!${NOCOL}\n${PURPLE}Usage: ${ORANGE}\`source <path>/"${SHELL_HELPERS_TEST_SCRIPT}"\`${NOCOL}\n"
#fi

# Check input file is supplied:
#if [ -z "${GENERIC_INPUT_FILE}" ]; then
#  die "${RED}You need to provide an ${YELLOW}input file ${RED} as an argument!\n${BLUE}\nUsage: \`${ORANGE}$SHELL_HELPERS_TEST_SCRIPT ${LCYAN} <input file>${BLUE}\`${NOCOL}\n"
#fi

# End of Setup and configuration

# Functions:
# Add a function:
#magicFunction () {
  # Do some magic..
#  echo -e "${LIME_GREEN}${RED}C${GREEN}o${BLUE}l${CYAN}o${LCYAN}u${ORANGE}r${WHITE}i${YELLOW}s${PURPLE}e${RED}d!${LIME_GREEN} stdout ${LCYAN}with different colours, ${LIME_GREEN}making sure we always terminate our echo statements with NOCOL${NOCOL}"
#}

# End of Functions

# Main program:
# Ask a question with a default answer:
askyesno "${YELLOW}Would you like to open the ${LCYAN}Vault UI${YELLOW} in your default browser?${NOCCOL}" "y"
# Ask a question without a default answer, which will fail:
#askyesno "${YELLOW}Would you like to open the ${LCYAN}Vault UI${YELLOW} in your default browser?${NOCCOL}"
# Evaluate the answer:
if [ $? -eq 0 ]; then
  echo "You answered yes"
else
  echo "You answered no"
fi

#magicFunction

exit 0