evaluate() {
    [ -z $1 ] || [ "$1" == "Y" ] || [ "$1" == "y" ] || [ "$1" == "yes" ]
}

COMMANDS=()

install() {
    printf "Do you want to install $1? [Y/n] "
    read ANSWER
    if evaluate $ANSWER; then
        for i in $(seq 2 $#); do
            COMMANDS+=("${!i}")
        done
    fi
}


install "python lsp" "sudo npm i -g pyright"

install "typescript lsp" "sudo npm i -g typescript typescript-language-server vscode-langservers-extracted"

install "C/C++ lsp" "sudo pacman -S --noconfirm clang"

install ".NET lsp" "[ ! -d ~/.omnisharp ] && mkdir .omnisharp/" "curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64.tar.gz > ~/omnisharp.tar.gz && tar xzf ~/omnisharp.tar.gz -C ~/.omnisharp/ && rm ~/omnisharp.tar.gz"


for cmd in "${COMMANDS[@]}"; do
    eval $cmd
done
