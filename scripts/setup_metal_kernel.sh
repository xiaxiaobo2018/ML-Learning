#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3.12}"
VENV_DIR="${VENV_DIR:-$ROOT_DIR/.venv-metal}"
KERNEL_NAME="${KERNEL_NAME:-ml-learning-metal}"
KERNEL_DISPLAY_NAME="${KERNEL_DISPLAY_NAME:-Python 3.12 (ML-Learning Metal)}"

if ! command -v "$PYTHON_BIN" >/dev/null 2>&1; then
  echo "Missing required interpreter: $PYTHON_BIN" >&2
  echo "Install Python 3.12 first, or rerun with PYTHON_BIN=/path/to/python3.12" >&2
  exit 1
fi

"$PYTHON_BIN" -m venv "$VENV_DIR"
"$VENV_DIR/bin/python" -m pip install --upgrade pip setuptools wheel
"$VENV_DIR/bin/python" -m pip install -r "$ROOT_DIR/requirements-mac-metal.txt"
"$VENV_DIR/bin/python" -m ipykernel install --user --name "$KERNEL_NAME" --display-name "$KERNEL_DISPLAY_NAME"

"$VENV_DIR/bin/python" - <<'PY'
import tensorflow as tf

gpus = tf.config.list_physical_devices("GPU")
print("TensorFlow:", tf.__version__)
print("GPUs:", gpus)
if not gpus:
    raise SystemExit("Metal GPU was not detected. Check the selected Python version and macOS GPU support.")
PY
