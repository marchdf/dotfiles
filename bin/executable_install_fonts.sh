#!/bin/bash

declare -a fonts=(
    FiraCode
    FiraMono
    Meslo
)

version='3.4.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ -f "$fonts_dir/FiraCodeNerdFont-Regular.ttf" ]]; then
    exit 0
fi

mkdir -p "$fonts_dir"

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip -o "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv
