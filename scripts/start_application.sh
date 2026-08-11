#!/bin/bash
set -e

systemctl enable acebook.service
systemctl restart acebook.service
