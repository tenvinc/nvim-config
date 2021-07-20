# Vim configuration

This repo contains all the files needed to setup neovim properly with all the shortcuts and features that are mentioned here.

## Major Plugins

* CCLS - Language server for C++
* COC - Code auto completion
* Nerdtree - File explorer
* Dark theme plugin
* Auto pairs - Add brackets, quotes in pairs
* Nerdcommenter - Comment lines
* Ctrlp vim - fuzzy search for files
* Vim surround - Change surroundings

## Shortcuts
| Shortcuts     | Description |
| -----------   | ----------- |
| ,             | Leader key  |
| jk or kj      | ESC         |
| \<leader>w            | :w          |
| \<leader>wq           | :wq         |
| \<leader>wq           | :wq         |
| \<leader>rs           | Remove all extra trailing whitespace         |
| gg=G''        | Auto format but leave cursor at current place |
| tk           | Move to the first tab |
| tj           | Move to the last tab |
| th           | Move to the prev tab |
| tl           | Move to the next tab |
| \<leader>b    | Move to arbitrary buffer, while showing a list | 
| \<C-J>           | Move to next buffer |
| \<C-K>           | Move to next buffer | 
| q       | Close buffer without exiting vim | 


### Nerdtree shortcuts (only available inside the nerdtree)

| Shortcuts     | Description |
| -----------   | ----------- |
| \<Space>       | Open up Nerdtree explorer |
| \<leader>v     | Find in Nerdtree          |
| o             | Open files, directories and bookmarks |
| o             | Recursively open the selected directory. |
| go            | Open selected file, but leave cursor in the NERDTree (preview mode) |         
| x             | Close the current nodes parent.          |
| X             | Recursively close all children of the current node.  |
| i             | Open selected file in a new tab |
| gi            | Same as i, but leave the cursor on the NERDTree.|
| s             | Open selected file in a new vsplit |
| gs            | Same as s, but leave the cursor on the NERDTree.|
| \<C-ww>            | Toggle focus between file and nerdtree |


### Coc shortcuts

| Shortcuts     | Description |
| -----------   | ----------- |
| Ctrl-\<space>     | Select the autocompletion |
| \<Tab> | Navigate the autocompletion |
| \<leader>rn  | Coc rename | 
| gy | go to coc type definition |
| gi | go to coc implementation |
| gr | go to coc references |

### Vim surround shortcuts
| Shortcuts     | Description |
| -----------   | ----------- |
| cs | Change surroundings | 
| ds | Remove surroundings |
| ys | Add surroundings |

### Setup remote filesystem with sshfs
`sudo sshfs -o allow_other,default_permissions user@hostname:path/to/folder/ /mount/point`
