#!/usr/bin/env zsh

# ######################################################################################################################
# Description:
# Installer tarball creation script for shellutils
# ######################################################################################################################
# Version: 1.0
# ######################################################################################################################
# Changelog:
# Version: 1.0
# - Initial version for building a clean tarball with just the library files
# ######################################################################################################################

# Setup and configuration:

# Generic globals for this script:
# Script name:
TARBALL_SCRIPT=$(basename "${0}")

# End of Setup and configuration

INSTALL_TMP=$(mktemp -d)
echo "$INSTALL_TMP"
cp install.sh "${INSTALL_TMP}"
mkdir -p "${INSTALL_TMP}/lib" "${INSTALL_TMP}/share"
cp ./lib/xdg_env.sh "${INSTALL_TMP}/lib/"
cp ./lib/xdg_util.sh "${INSTALL_TMP}/lib/"
cp ./lib/shell_helpers.sh "${INSTALL_TMP}/lib/"
cp ./share/colours.tgz "${INSTALL_TMP}/share/"
cp ./share/uninstall.sh "${INSTALL_TMP}/share/"
tar -C "${INSTALL_TMP}" -czpf shellutils_v1.2.1.tgz ./install.sh ./lib/ ./share/

exit 0