" General settings

source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/keys/which-key.vim
source $HOME/.config/nvim/keys/mappings.vim

if exists('g:vscode')
    " VS Code extension
    source $HOME/.config/nvim/vscode/settings.vim
    "source $HOME/.config/nvim/plug-config/easymotion.vim
endif