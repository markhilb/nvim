call plug#begin()
	Plug 'rafi/awesome-vim-colorschemes'   "
	Plug 'sheerun/vim-polyglot'			   " Colorschemes + syntax highlighting
	Plug 'justinmk/vim-syntax-extra'	   "
	Plug 'octol/vim-cpp-enhanced-highlight'"
    Plug 'ap/vim-css-color'                " Display color of hex values

	Plug 'scrooloose/nerdtree' " Filetree
	Plug 'ctrlpvim/ctrlp.vim'  " Filesearching

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete menu

	Plug 'rhysd/accelerated-jk'

	Plug 'tpope/vim-commentary'

	Plug 'jiangmiao/auto-pairs' " Autoclose parentheses etc.
	Plug 'wellle/targets.vim'   " Target inside text objects
	Plug 'alvan/vim-closetag'   " Autoclose html tags

	Plug 'bronson/vim-trailing-whitespace'

	Plug 'junegunn/vim-emoji'
call plug#end()
packloadall

