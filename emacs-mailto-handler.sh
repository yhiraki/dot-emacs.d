#!/bin/sh
# emacs-mailto-handler

mailto=$1
mailto="mailto:${mailto#mailto:}"
mailto=$(printf '%s\n' "$mailto" | sed -e 's/[\"]/\\&/g')
elisp_expr="(mailto-compose-mail \"$mailto\")"

emacsclient --eval "$elisp_expr"

