#!/usr/bin/env sh
set -eu

cat <<'EOF'
This helper intentionally does not kill processes automatically.
To stop Juice Shop safely:
1. Return to the Termux/Kali terminal where you ran "npm start".
2. Press Ctrl+C.
3. If you lost that terminal, inspect processes with:
   ps -A | grep -i '[j]uice-shop\|[n]ode'
4. Stop only the process you can identify as your own lab process.
Do not kill all Node.js processes or use broad pkill commands.
EOF
