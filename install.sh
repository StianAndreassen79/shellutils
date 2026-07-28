#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# Installer script for shellutils
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Script name variable for logging
# - Install statements for:
#   - xdg_env.sh
#   - xdg_util.sh
#   - colours.sh symlink and source file
#   - XDG paths
#   - shell_helpers.sh
#   - uninstall.sh
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
INSTALL_SCRIPT=$(basename "${0}")
LIB_NAME=$(basename "${PWD}")

# Installable artefacts:
# XDG environment variables:
XDG_ENV_SCRIPT=./lib/xdg_env.sh
# XDG utility script:
XDG_ENV_UTIL_SCRIPT=./lib/xdg_util.sh
# Shell helpers script:
SHELL_HELPER_SCRIPT=./lib/shell_helpers.sh
SHELL_HELPER_SCRIPT_FILE=$(basename "${SHELL_HELPER_SCRIPT}")
XDG_ENV_SCRIPT_FILE=$(basename "${XDG_ENV_SCRIPT}")
XDG_ENV_UTIL_SCRIPT_FILE=$(basename "${XDG_ENV_UTIL_SCRIPT}")
# Colours script and source file:
COLOURS_SOURCE=./share/colours.tgz  # This needs to be updated as per the colours-dev branch
COLOURS_TARBALLED_SCRIPT_NAME=$(tar -tf "${COLOURS_SOURCE}" | head -1 | cut -f1)
COLOURS_TARBALLED_SCRIPT_NAME_VERSION="${COLOURS_TARBALLED_SCRIPT_NAME##*_v}"
COLOURS_TARBALLED_SCRIPT_NAME_VERSION="${COLOURS_TARBALLED_SCRIPT_NAME_VERSION%.sh}"
COLOURS_SCRIPT_FILE=$(basename "${COLOURS_SOURCE}")
UNINSTALLER_SCRIPT=./share/uninstall.sh
UNINSTALLER_SCRIPT_FILE=$(basename "${UNINSTALLER_SCRIPT}")

# Source environment variables:
echo "${INSTALL_SCRIPT}: Sourcing XDG environment variables.."
source "${XDG_ENV_SCRIPT}"

# Colours version source file target name:
COLOURS_SCRIPT="${XDG_SHARE_DIR}/colours_v${COLOURS_TARBALLED_SCRIPT_NAME_VERSION}.sh"

# XDG Base Directory:
if [ ! -e "${XDG_BASE}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_BASE}'"
  mkdir -pv "${HOME}/.local"
else
  echo "${INSTALL_SCRIPT}: XDG Base Directory: '${XDG_BASE}' already exists"
fi

# XLG Data Home (share) directory and subdirectory:
if [ ! -e "${XDG_SHARE_DIR}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_SHARE_DIR}'"
  mkdir -p "${XDG_SHARE_DIR}"
else
  echo "${INSTALL_SCRIPT}: XLG Data Home (share) directory and subdirectory: '${XDG_SHARE_DIR}' already exists"
fi

# Check the directory structure and create if they don't exist:
if [ ! -e "${XDG_CONFIG_HOME}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_CONFIG_HOME}'"
  mkdir -p "${HOME}/.config"
else
  echo "${INSTALL_SCRIPT}: XDG Config Home: '${XDG_CONFIG_HOME}' already exists"
fi
if [ ! -e "${XDG_CACHE_HOME}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_CACHE_HOME}'"
  mkdir -p "${HOME}/.cache"
else
  echo "${INSTALL_SCRIPT}: XDG Cache Home: '${XDG_CACHE_HOME}' already exists"
fi
if [ ! -e "${XDG_STATE_HOME}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_STATE_HOME}'"
  mkdir -p "${XDG_BASE}/state"
else
  echo "${INSTALL_SCRIPT}: XDG State Home: '${XDG_STATE_HOME}' already exists"
fi
if [ ! -e "${XDG_LIB_HOME}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${XDG_LIB_HOME}'. NOTE: This directory is not in the XDG specification!"
  mkdir -p "${XDG_BASE}/lib/${LIB_NAME}"
else
  echo "${INSTALL_SCRIPT}: XDG Lib Home: '${XDG_STATE_HOME}' already exists"
fi
if [ ! -e "${CONFIG_PATH}" ]; then
  echo "${INSTALL_SCRIPT}: Creating directory: '${CONFIG_PATH}'"
  mkdir -p "${CONFIG_PATH}"
else
  echo "${INSTALL_SCRIPT}: Configuration directory: '${CONFIG_PATH}' already exists"
fi

# Install environment variables script:
echo "${INSTALL_SCRIPT}: Installing: environment variables script: '${XDG_ENV_SCRIPT_FILE}' to ${XDG_LIB_HOME}"
cp -f "${XDG_ENV_SCRIPT}" "${XDG_LIB_HOME}"

# Install XDG utility script:
echo "${INSTALL_SCRIPT}: Installing: XDG utility script: '${XDG_ENV_UTIL_SCRIPT_FILE}' to ${XDG_LIB_HOME}"
cp -f "${XDG_ENV_UTIL_SCRIPT}" "${XDG_LIB_HOME}"

# Install colours tarball:
echo "${INSTALL_SCRIPT}: Installing: colours tarball: '${COLOURS_SCRIPT_FILE}' to ${XDG_LIB_HOME}"
cp -p "${COLOURS_SOURCE}" "${XDG_SHARE_DIR}"

# Install colours script and set up symlink to scripts don't need to refer to a versioned file:
echo "${INSTALL_SCRIPT}: Extracting: colours tarball: '${COLOURS_SCRIPT_FILE}' to ${XDG_SHARE_DIR}"
tar -xf "${COLOURS_SOURCE}" -C "${XDG_SHARE_DIR}"
# Remove any existing symlink:
if [ -h "${XDG_LIB_HOME}/colours.sh" ]; then
  echo "${INSTALL_SCRIPT}: Removing existing symlink '${XDG_LIB_HOME}/colours.sh' from ${XDG_SHARE_DIR}"
  rm -f "${XDG_LIB_HOME}/colours.sh"
fi
echo "${INSTALL_SCRIPT}: Creating symlink '${XDG_LIB_HOME}/colours.sh' to versioned '${COLOURS_SCRIPT}' in ${XDG_LIB_HOME}"
ln -s "${COLOURS_SCRIPT}" "${XDG_LIB_HOME}/colours.sh"

# Install shell_helpers script:
echo "${INSTALL_SCRIPT}: Installing: shell helpers script: '${SHELL_HELPER_SCRIPT_FILE}' to ${XDG_LIB_HOME}"
cp -f "${SHELL_HELPER_SCRIPT}" "${XDG_LIB_HOME}"

# Install uninstall script:
echo "${INSTALL_SCRIPT}: Installing: uninstall script: '${UNINSTALLER_SCRIPT_FILE}' to ${XDG_SHARE_DIR}"
cp -f "${UNINSTALLER_SCRIPT}" "${XDG_SHARE_DIR}"

# Construct config file:
cat > "${CONFIG_FILE}"<< EOF
LIB_NAME="${LIB_NAME}"
COLOURS_SCRIPT="\${XDG_LIB_HOME}/colours.sh"
COLOURS_VERSION="${COLOURS_TARBALLED_SCRIPT_NAME_VERSION}"
XDG_BASE="\${HOME}/.local"
XDG_LIB_HOME="\${XDG_BASE}/lib/\${LIB_NAME}"
XDG_ENV_SCRIPT="\${XDG_LIB_HOME}/xdg_env.sh"
SHELL_HELPER_SCRIPT="\${XDG_LIB_HOME}/shell_helpers.sh"
EOF

exit 0
