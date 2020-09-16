#!/bin/zsh
# vim: set ft=zsh fenc=utf-8 noai ts=4 et sts=4 sw=0 tw=80 nowrap :
local ZGEN_SOURCE="$0:A:h"

if [[ -z "${ZGEN_DIR}" ]]; then
    if [[ -e "${HOME}/.zgen" ]]; then
        ZGEN_DIR="${HOME}/.zgen"
    else
        ZGEN_DIR="$ZGEN_SOURCE"
    fi
fi

if [[ -z "${ZGEN_INIT}" ]]; then
    ZGEN_INIT="${ZGEN_DIR}/init.zsh"
fi

zgen-saved() {
    [[ -f "${ZGEN_INIT}" ]] && return 0 || return 1
}

zgen-init() {
    if [[ -f "${ZGEN_INIT}" ]]; then
        source "${ZGEN_INIT}"
    fi
}

# Run initialization only once
if [[ -z $ZGEN_LAZY_LOCK ]]; then
    zgen() {
        if [[ $1 = 'saved' ]]; then
            zgen-saved
        else
            ZGEN_LAZY_LOCK=yes
            source "${ZGEN_SOURCE}/zgen.zsh"
            unset ZGEN_LAZY_LOCK
            zgen $@
        fi
    }
    fpath=($ZGEN_SOURCE $fpath)
    zgen-init
fi
