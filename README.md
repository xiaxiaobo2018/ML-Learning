# ML-Learning

Small projects for learning purposes.

## Original Notebook Environment

The `ml/cc/exercises/linear_regression_taxi.ipynb` notebook was originally written for Google Colab.
Its setup cells assume a Colab-style environment with notebook-managed package installs and older TensorFlow / Keras pins, for example:

- `google-ml-edu==0.1.3`
- `keras~=3.8.0`
- `tensorflow~=2.18.0`
- `numpy~=2.0.0`
- `pandas~=2.2.0`

Those assumptions fit the original hosted Colab runtime better than a local Apple silicon Jupyter setup.

## Local Metal Adaptation

On MacBook, I adapted the project to use a dedicated Apple silicon Metal environment so TensorFlow can train on the GPU instead of only on the CPU.

What changed:

- Created a local Python 3.12 virtual environment at `.venv-metal/`
- Installed a Metal-compatible TensorFlow stack with `tensorflow-macos==2.16.2` and `tensorflow-metal==1.2.0`
- Registered a dedicated Jupyter kernel named `Python 3.12 (ML-Learning Metal)`
- Updated the notebook setup cell to detect Apple silicon and install the Metal-compatible package set
- Added a notebook runtime check cell that reports whether TensorFlow sees the GPU
- Added a reproducible setup script and pinned dependency file for the Metal environment

```bash
./scripts/setup_metal_kernel.sh
```

Then in Jupyter select the `Python 3.12 (ML-Learning Metal)` kernel before running the notebook.

The pinned packages for that environment live in [requirements-mac-metal.txt](requirements-mac-metal.txt).

## Why This Was Needed

The original notebook setup is designed for Google Colab and its managed runtime. For local execution on Apple silicon MacBook, I added a separate Metal-first workflow so the notebook can use GPU acceleration through a dedicated Python 3.12 environment and Jupyter kernel.
