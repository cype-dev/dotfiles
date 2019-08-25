#!/usr/bin/env sh

set -e

script_dir=$(dirname $(readlink -f "$0"))

files="${script_dir}/*"
# run for every non-hidden file inside .dotfiles folder
for file in $files; do
    # get only the filename
    filename="${file##*/}"
    # if file is a directory create it
    if [ -d "$file" ] && [ ! -L "$file" ]; then
	    mkdir -p "$HOME/.$filename"
	    # and create symlinks of the files inside the folder
        dir_files="$file"/*
        for dir_file in $dir_files; do
            dir_filename="${dir_file##*/}"
            ln -sni "$script_dir/$filename/$dir_filename" "$HOME/.$filename/$dir_filename"
        done
    # else create symlink
    else
        ln -sni "$script_dir/$filename" "$HOME/.$filename"
    fi
done
