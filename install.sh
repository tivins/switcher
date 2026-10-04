#!/usr/bin/env bash
# Installe switcher : lien dans ~/.local/bin, config par défaut, fonction `p` dans ~/.bashrc.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)

mkdir -p ~/.local/bin
ln -sf "$here/switcher" ~/.local/bin/switcher
echo "lien : ~/.local/bin/switcher -> $here/switcher"

echo "config : $(switcher config)"

line="source $here/shell/switcher.bash"
if ! grep -qxF "$line" ~/.bashrc; then
    printf '\n# switcher\n%s\n' "$line" >> ~/.bashrc
    echo "ajouté à ~/.bashrc : $line"
fi
