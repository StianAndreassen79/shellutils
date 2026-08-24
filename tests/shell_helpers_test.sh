#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# A test script from the generic_script_template.sh v1.2 template.
# ######################################################################################################################
# Version: 1.1
# ######################################################################################################################
# Changelog:
# Version: 1.1
# - shell_helpers.sh:
#   - updates from ShellCheck:
#   - backticks disablement
#   - replace `! -z` with `-n`
#   - added `-r` to instances of `read`
# Testing:
# - shell_helpers.sh: copy_to_clipboard
# - shell_helpers.sh: launch_browser
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
  echo -e "${SHELL_HELPERS_TEST_SCRIPT}: Shell helper script not found where expected: ${SHELL_HELPER_SCRIPT}, please run install.sh!"
  exit 1
else
 source "${SHELL_HELPER_SCRIPT}" # This the production path when shellutils is installed, cannot be used during testing
 source ../lib/shell_helpers.sh  # Need to override the path to use the shell_helpers.sh script you're testing when running tests.
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

# Test copy_to_clipboard:
# Testing with special characters single-quoted:
GARBAGE='this />??/.\ is a test'
# Testing with special characters double-quoted:
#GARBAGE="this />??/.\ is a test"
copy_to_clipboard "${GARBAGE}"
echo -e "${LIME_GREEN}Local variable \$GARBAGE: '$GARBAGE' was copied to your clipboard${NOCCOL}"

# Main program:
# Testing askyesno:
# Ask a question with a required default answer:
askyesno "${YELLOW}Would you like to open the ${LCYAN}Vault UI${YELLOW} in your default browser?${NOCCOL}" "n"
# Ask a question without a default answer, which will fail:
#askyesno "${YELLOW}Would you like to open the ${LCYAN}Vault UI${YELLOW} in your default browser?${NOCCOL}"
# Testing sending the question but not the required default answer
#askyesno

# Evaluate the answer:
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
  #echo "You answered yes"
  launch_browser "https://google.com"
  #launch_browser
else
  #echo "You answered no"
  echo "Not opening browser"
fi

#magicFunction

exit 0