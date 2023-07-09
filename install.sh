#!/bin/bash

create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

echo "Updating apt..."
sudo apt update
echo "Done: Updatint apt"

echo "Installing FiraCode..."
sudo apt install fonts-firacode
echo "Done: Installing FiraCode"

echo "Installing Nord theme extension for vscode"
code --install-extension arcticicestudio.nord-visual-studio-code
echo "Done: Installing Nord theme extension for vscode"

curl -sS https://starship.rs/install.sh | sh -s -- -y

create_symlinks

source ~/.zshrc