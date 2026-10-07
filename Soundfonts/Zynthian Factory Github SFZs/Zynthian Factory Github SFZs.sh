#!/bin/bash

DST_DIR="$ZYNTHIAN_DATA_DIR/soundfonts"
REPO="zynthian-factory-sfzs"
URL_BASE="https://github.com/jlearman/zynthian-factory-sfzs"
FLAG_FILE="sfz/zynthian-factory-github-sfzs.txt"

do_install() {
    if [[ -d "$DST_DIR/sfz/Guitars/RealBanjo" ]]; then
        echo "First uninstall the original factory SFZ package"
        exit 1
    fi
    mkdir -p "$DST_DIR"
    cd "$DST_DIR"
    git clone --depth 1 "$URL_BASE"
    cp -r "$REPO/sfz" "$DST_DIR"
    rm -rf "$REPO"
    echo "installed"
}

do_uninstall() {
    if [[ $(is_installed) == "installed" ]]; then
        wget -LJO "$URL_BASE/blob/main/sfz/factory_sfz_list.txt"
        readarray -t dir_list < "$DST_DIR/sfz/factory_dir_list.txt"
        for dir in "${dir_list[@]}"; do
            rm -rf "$DST_DIR/$dir"
        done
        rm "$DST_DIR/sfz/factory_dir_list.txt"
        rm "$DST_DIR/$FLAG_FILE"
        echo "uninstalled"
    else
        echo "not installed"
    fi
}

is_installed() {
    if [[ -f "$DST_DIR/$FLAG_FILE" ]]; then
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
