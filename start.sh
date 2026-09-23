#!/usr/bin/env bash
# Ubuntu / GNOME Wayland：用 Python 3.12 建 venv（RapidOCR 1.4 不支持 3.13+），采集走系统 Python 的 PyGObject。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
export PYTHONPATH="$ROOT"

if [[ -x "$ROOT/.venv/bin/python" ]]; then
  PY="$ROOT/.venv/bin/python"
else
  if ! command -v uv >/dev/null 2>&1; then
    echo "需要 uv 或已建好的 .venv。安装 uv: curl -fsSL https://astral.sh/uv/install.sh | sh" >&2
    exit 1
  fi
  uv venv --python 3.12 "$ROOT/.venv"
  uv pip install --python "$ROOT/.venv/bin/python" -r "$ROOT/requirements.txt"
  PY="$ROOT/.venv/bin/python"
fi

exec "$PY" "$ROOT/main.py" "$@"
