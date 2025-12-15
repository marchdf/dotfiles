#!/usr/bin/env bash

EMMS_DIR="${HOME}/.emacs.d/build/emms"
BIN_DIR="${HOME}/bin"
EMMS_EXEC="${BIN_DIR}/emms-print-metadata"

if [[ -d "${EMMS_DIR}" ]]; then
    echo "Updating EMMS in ${EMMS_DIR}..."
    git -C "${EMMS_DIR}" pull
else
    echo "Cloning EMMS into ${EMMS_DIR}..."
    git clone https://git.savannah.gnu.org/git/emms.git "${EMMS_DIR}"
fi

echo "Building emms-print-metadata..."
cd "${EMMS_DIR}/src"
cc -I/usr/include/taglib emms-print-metadata.c -ltag_c -ltag -lz -o emms-print-metadata

echo "Linking executable to ${EMMS_EXEC}..."
ln -sf "${EMMS_DIR}/src/emms-print-metadata" "${EMMS_EXEC}"
