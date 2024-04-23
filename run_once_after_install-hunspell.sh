#!/usr/bin/env bash

if [[ -x "$(command -v hunspell)" ]]; then

    HUNSPELL_DICT_LOCATION="${HOME}/.local/share/hunspell/dicts"
    HUNSPELL_EN_US_BASE_URL="https://sourceforge.net/projects/wordlist/files/speller/2020.12.07/"
    HUNSPELL_EN_US_NAME="hunspell-en_US-2020.12.07.zip"

    mkdir -p "${HUNSPELL_DICT_LOCATION}"
    cd "${HUNSPELL_DICT_LOCATION}"
    wget "${HUNSPELL_EN_US_BASE_URL}${HUNSPELL_EN_US_NAME}"
    unzip "${HUNSPELL_EN_US_NAME}" *.aff *.dic -d "${HUNSPELL_DICT_LOCATION}"
    rm "${HUNSPELL_EN_US_NAME}"
fi
