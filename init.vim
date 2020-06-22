" Load all vim files in the init directory
for vim_file in split(glob('$HOME/.config/nvim/init/*.vim'), '\n')
	exe 'source' vim_file
endfor
