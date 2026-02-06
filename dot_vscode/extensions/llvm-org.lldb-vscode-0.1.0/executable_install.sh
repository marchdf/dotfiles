#!/usr/local/bin/bash
# Install vscode extension for LLDB
if [[ ! -x "$(command -v npm)" ]]; then
    echo "Please install npm"
    exit 1
fi
wget https://raw.githubusercontent.com/llvm-mirror/lldb/master/tools/lldb-vscode/package.json
npm install
mkdir bin
cd bin || exit
llvmpath="$(brew --cellar llvm)/$(brew list --versions llvm | tr ' ' '\n' | tail -1)"
ln -s "${llvmpath}/bin/lldb-vscode" lldb-vscode
cd .. || exit
ln -s "${llvmpath}/lib" lib
