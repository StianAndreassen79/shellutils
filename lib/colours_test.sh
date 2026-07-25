#!/usr/bin/env zsh

source colours_test.h

echo -e "${BRIGHT_RED}This text is bright red ${NOCOL}"
echo -e "${TERM_GREEN}This text is terminal green.${NOCOL} This text does not have colour."
echo -e "${TERM_GREEN_RGB}This text is terminal green, but with RGB.${NOCOL} This text does not have colour."
echo -e "${PINK}This text is pink.${NOCOL} This text does not have colour."
echo -e "${SILVER}This text is silver.${NOCOL} This text does not have colour."
