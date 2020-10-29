call plug#begin()
    Plug 'rafi/awesome-vim-colorschemes'    "
    Plug 'sheerun/vim-polyglot'             " Colorschemes + syntax highlighting
    Plug 'justinmk/vim-syntax-extra'        "
    Plug 'octol/vim-cpp-enhanced-highlight' "
    Plug 'ap/vim-css-color'                 " Display color of hex values

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete menu

    Plug 'easymotion/vim-easymotion'

    Plug 'tpope/vim-commentary'

    Plug 'jiangmiao/auto-pairs' " Autoclose parentheses etc.
    Plug 'wellle/targets.vim'   " Target inside text objects
    Plug 'alvan/vim-closetag'   " Autoclose html tags

    Plug 'bronson/vim-trailing-whitespace'

    Plug 'junegunn/vim-emoji'

    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    Plug 'APZelos/blamer.nvim' " Git blame
call plug#end()
packloadall

