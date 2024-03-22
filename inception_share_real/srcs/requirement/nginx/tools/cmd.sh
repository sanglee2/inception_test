#! /bin/bash

#
echo "Waiting db, php"
sleep 100

echo "✅ NGINX IS ON"
nginx -v
openssl version

# NGINX 서버 시작
echo "Starting NGINX..."
exec "$@"