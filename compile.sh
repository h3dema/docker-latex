#!/bin/bash
set -e

DOC_DIR="/workspace/doc"
MAIN_TEX="${LATEX_MAIN:-main.tex}"

echo "=== LaTeX build system starting ==="
echo "Document directory: $DOC_DIR"
echo "Main file: $MAIN_TEX"

cd "$DOC_DIR"

# ------------------------------------------------------------
# 1. Install extra packages if install.lst exists
# ------------------------------------------------------------
if [ -f "install.lst" ]; then
    echo "Found install.lst — installing additional LaTeX packages..."
    while IFS= read -r pkg; do
        if [ -n "$pkg" ]; then
            echo "Installing package: $pkg"
            tlmgr install "$pkg" || echo "Warning: failed to install $pkg"
        fi
    done < install.lst
else
    echo "No install.lst found — skipping extra package installation."
fi

# ------------------------------------------------------------
# 2. Compile LaTeX (with bibliography)
# ------------------------------------------------------------
if [ ! -f "$MAIN_TEX" ]; then
    echo "ERROR: Main file '$MAIN_TEX' not found."
    exit 1
fi

echo "Running latexmk..."
latexmk -pdf -interaction=nonstopmode "$MAIN_TEX"

echo "=== Build complete ==="

