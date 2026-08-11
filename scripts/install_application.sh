#!/bin/bash
set -euo pipefail

chown -R ec2-user:ec2-user /var/www/acebook

cd /var/www/acebook
sudo -u ec2-user env HOME=/home/ec2-user npm ci --omit=dev

cat > /etc/systemd/system/acebook.service <<'EOF'
[Unit]
Description=Acebook Node application
After=network.target mongod.service
Wants=mongod.service

[Service]
Type=simple
User=ec2-user
Group=ec2-user
WorkingDirectory=/var/www/acebook
Environment=NODE_ENV=production
Environment=PORT=3000
Environment=MONGODB_URL=mongodb://127.0.0.1/acebook
ExecStart=/usr/bin/node /var/www/acebook/bin/www
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
