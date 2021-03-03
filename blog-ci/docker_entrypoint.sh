#!/bin/sh
set -e

if test $# -ge 1; then
	exec "$@"
	exit 0
fi

if test -e "$HOME/.ssh/id_rsa"; then
  chmod 600 $HOME/.ssh/id_rsa
fi


exec /opt/bin/hook
