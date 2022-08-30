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


install "python lsp" "npm i -g pyright"

install "typescript lsp" "npm i -g typescript typescript-language-server vscode-langservers-extracted"

install "angular lsp" "npm install -g @angular/language-server"

install "lua lsp" "sudo pacman -S --noconfirm lua-language-server"

install "C/C++ lsp" "sudo pacman -S --noconfirm clang"

install ".NET lsp" "mkdir -p ~/.omnisharp && curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64-net6.0.tar.gz > ~/omnisharp.tar.gz && tar xzf ~/omnisharp.tar.gz -C ~/.omnisharp/ && rm ~/omnisharp.tar.gz"

install "Rust lsp" "mkdir -p ~/.local/bin && curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer"

for cmd in "${COMMANDS[@]}"; do
    eval $cmd
done
