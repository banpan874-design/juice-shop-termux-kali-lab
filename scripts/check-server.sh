#!/usr/bin/env sh
set -eu

HOST="${1:-127.0.0.1}"
PORT="${2:-3000}"
URL="http://${HOST}:${PORT}/"

printf 'Checking Juice Shop at %s\n' "$URL"
if command -v curl >/dev/null 2>&1; then
  if curl --silent --show-error --fail --max-time 5 "$URL" >/dev/null; then
    printf 'HTTP check succeeded. The server responded.\n'
  else
    printf 'HTTP check failed. Confirm the server is running, the address is correct, and the network is allowed.\n' >&2
    exit 1
  fi
else
  printf 'curl is not installed; install it or open the URL in a browser.\n' >&2
  exit 2
fi
