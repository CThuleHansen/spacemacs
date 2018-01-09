# Spacemacs private layer
This repository contains thule's private layer to use with spacemacs
## Content 
This layer currently installs and configures:
* Auctex
## Install instructions
To use this layer in your spacemacs configuration do the following:
1. Clone it to e.g. ~/source/spacemacs
2. Symlink it to ~/.emacs.d/private:
    ```bash
    ln -s ~/source/spacemacs/thule ~/.emacs.d/private/
    ```
3. Add `thule` to `dotspacemacs-configuration-layers` in `.spacemacs`
