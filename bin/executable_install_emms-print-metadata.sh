#!/usr/bin/env bash

ARCH=$(uname -m)
ARCH_BIN="${HOME}/.local/${ARCH}/bin"
mkdir -p "${ARCH_BIN}"

EMMS_DIR="${HOME}/.emacs.d/build/emms"
EMMS_EXEC="${ARCH_BIN}/emms-print-metadata"

if [[ -x "${EMMS_EXEC}" ]]; then
    exit 0
fi

# Check for required header
TAGLIB_INCLUDE=""
for dir in /usr/include /usr/include/taglib /usr/local/include /usr/local/include/taglib /opt/homebrew/include/taglib; do
    if [[ -f "${dir}/tag_c.h" ]]; then
        TAGLIB_INCLUDE="-I${dir}"
        break
    fi
done

if [[ -z "${TAGLIB_INCLUDE}" ]]; then
    echo "taglib headers not found, skipping emms-print-metadata build"
    exit 0
fi

if [[ -d "${EMMS_DIR}" ]]; then
    git -C "${EMMS_DIR}" pull --quiet
else
    git clone --quiet https://git.savannah.gnu.org/git/emms.git "${EMMS_DIR}"
fi

cd "${EMMS_DIR}/src"
if cc ${TAGLIB_INCLUDE} emms-print-metadata.c -ltag_c -ltag -lz -o "${EMMS_EXEC}" 2>/dev/null; then
    echo "Installed emms-print-metadata to ${EMMS_EXEC}"
fi
