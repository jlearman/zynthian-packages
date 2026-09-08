#!/bin/bash

DST_DIR="$ZYNTHIAN_DATA_DIR/soundfonts/sfz"
DIRNAME="VSCO2"
DOWNLOAD_URL="https://github.com/sgossner/VSCO-2-CE/archive/refs/tags/1.1.0.zip"
ZIP_DIR="VSCO-2-CE-1.1.0" # directory name at top of zip file

do_install() {
    mkdir -p "$DST_DIR"
    wget -O - "$DOWNLOAD_URL" | bsdtar -xf - -C "$DST_DIR"
    mv "$DST_DIR/$ZIP_DIR" "$DST_DIR/$DIRNAME"
    echo "installed"
}

do_uninstall() {
    if [[ $(is_installed) == "installed" ]]; then
        rm -rf "$DST_DIR/$DIRNAME"
        echo "uninstalled"
    else
        echo "not installed"
    fi
}

is_installed() {
    if [[ -d "$DST_DIR/$DIRNAME" ]]; then
        echo "installed"
    else
        echo "not installed"
    fi
}

if [[ "$1" == "install" ]]; then
    do_install
elif [[ "$1" == "uninstall" ]]; then
    do_uninstall
elif [[ "$1" == "installed" ]]; then
    echo $(is_installed)
fi

