#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ACTION="${1:-up}"

case "$ACTION" in
  up)
    docker compose -f "${SCRIPT_DIR}/docker-compose.yml" up -d
    echo "Container started. Attach: docker exec -it ros2_rk3568 bash"
    ;;
  down)
    docker compose -f "${SCRIPT_DIR}/docker-compose.yml" down
    ;;
  logs)
    docker compose -f "${SCRIPT_DIR}/docker-compose.yml" logs -f
    ;;
  shell)
    docker exec -it ros2_rk3568 bash
    ;;
  *)
    echo "Usage: $0 {up|down|logs|shell}"
    exit 1
    ;;
esac
