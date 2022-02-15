evaluate() {
    [ -z $1 ] || [ "$1" == "Y" ] || [ "$1" == "y" ] || [ "$1" == "yes" ]
}

COMMANDS=()


printf "Do you want to install python lsp? [Y/n] "
read ANSWER
if evaluate $ANSWER; then
    COMMANDS+=("sudo npm i -g pyright")
fi

printf "\nDo you want to install typescript lsp? [Y/n] "
read ANSWER
if evaluate $ANSWER; then
    COMMANDS+=("sudo npm i -g typescript typescript-language-server vscode-langservers-extracted")
fi

printf "\nDo you want to install C/C++ lsp? [Y/n] "
read ANSWER
if evaluate $ANSWER; then
    COMMANDS+=("sudo pacman -S --noconfirm clang")
fi

printf "\nDo you want to install .NET lsp? [Y/n] "
read ANSWER
if evaluate $ANSWER; then
    COMMANDS+=("[ ! -d ~/.omnisharp ] && mkdir .omnisharp/")
    COMMANDS+=("curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64.tar.gz > ~/omnisharp.tar.gz && tar xzf ~/omnisharp.tar.gz -C ~/.omnisharp/ && rm ~/omnisharp.tar.gz")
fi

for cmd in "${COMMANDS[@]}"
do
    eval $cmd
done
