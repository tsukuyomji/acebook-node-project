#!/bin/bash
set -e

for attempt in {1..30}; do
  if curl --fail --silent http://127.0.0.1:3000/ > /dev/null; then
    echo "Acebook is running successfully"
    exit 0
  fi

  sleep 2
done

echo "Acebook failed its deployment health check"
systemctl status acebook.service --no-pager || true
journalctl -u acebook.service --no-pager -n 50 || true
exit 1
