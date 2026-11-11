#!/bin/sh
# TOS wrapper: LinuxServer s6 starts as root and su-execs to abc. Run rslsync
# directly as uid 1000 and seed a config whose web UI listens on 0.0.0.0.
set -u
set -e
mkdir -p /config/data /downloads
if [ ! -s /config/sync.conf ]; then
  cat > /config/sync.conf <<'JSON'
{"storage_path":"/config/data","directory_root":"/downloads","webui":{"listen":"0.0.0.0:8888"}}
JSON
fi
exec rslsync --nodaemon --config /config/sync.conf
