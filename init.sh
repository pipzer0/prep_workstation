#!/bin/bash

update_system() {
    echo "Updating the system..."
    sudo apt install snapd || { echo "Failed to install snapd. Exiting..."; exit 1;
    sudo apt-get update && sudo apt-get upgrade -y || { echo "Failed to update system. Exiting..."; exit 1; }
}

install_general_tools() {
    echo "Installing general malware analysis tools..."
    sudo apt-get install -y git python3 python3-pip wireshark clamav yara chkrootkit rkhunter strace gdb || { echo "Failed to install general tools. Exiting..."; exit 1; }
}


install_elf_tools() {
    echo "Installing ELF analysis tools..."
    sudo apt-get install -y binutils elfutils ltrace patchelf binwalk || { echo "Failed to install ELF tools. Exiting..."; exit 1; }
    sudo apt-get install -y hexedit objdump nmap htop || { echo "Failed to install additional analysis tools. Exiting..."; exit 1; }

}

install_pip() {
    echo "Installing pip packages..."
    pip3 install ROPgadget || { echo "Failed to install ROPgadget. Exiting..."; exit 1; }
    pip3 install volatility3 || { echo "Failed to install volatility3. Exiting..."; exit 1; }    
}

install_snap() {
    sudo snap install radare2 --classic | { echo "Failed to install r2. Exiting..."; exit 1; }
}

install_peda_pwndbg_gef () {

    local installer_path=$PWD
    if [ -f ~/.gdbinit ] || [ -h ~/.gdbinit ]; then
        echo "[+] backing up gdbinit file"
        cp ~/.gdbinit ~/.gdbinit.back_up
    fi

    # download peda and decide whether to overwrite if exists
    if [ -d ~/peda ] || [ -h ~/.peda ]; then
        echo "[-] PEDA found"
        read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

        if [ $skip_peda = 'n' ]; then
            rm -rf ~/peda
            git clone https://github.com/longld/peda.git ~/peda
        else
            echo "PEDA skipped"
        fi
    else
        echo "[+] Downloading PEDA..."
        git clone https://github.com/longld/peda.git ~/peda
    fi

    # download pwndbg
    if [ -d ~/pwndbg ] || [ -h ~/.pwndbg ]; then
        echo "[-] Pwndbg found"
        read -p "skip download to continue? (enter 'y' or 'n') " skip_pwndbg

        if [ $skip_pwndbg = 'n' ]; then
            rm -rf ~/pwndbg
            git clone https://github.com/pwndbg/pwndbg.git ~/pwndbg

            cd ~/pwndbg
            ./setup.sh
        else
            echo "Pwndbg skipped"
        fi
    else
        echo "[+] Downloading Pwndbg..."
        git clone https://github.com/pwndbg/pwndbg.git ~/pwndbg

        cd ~/pwndbg
        ./setup.sh
    fi

    # download gef
    echo "[+] Downloading GEF..."
    git clone https://github.com/hugsy/gef.git ~/gef

    cd $installer_path

    echo "[+] Setting .gdbinit..."
    cp gdbinit ~/.gdbinit

    {
      echo "[+] Creating files..."
        sudo cp gdb-peda /usr/bin/gdb-peda &&\
        sudo cp gdb-pwndbg /usr/bin/gdb-pwndbg &&\
        sudo cp gdb-gef /usr/bin/gdb-gef
    } || {
      echo "[-] Permission denied"
        exit
    }

    {
      echo "[+] Setting permissions..."
        sudo chmod +x /usr/bin/gdb-*
    } || {
      echo "[-] Permission denied"
        exit
    }

}

cleanup() {
    echo "Cleaning up..."
}

main() {
    update_system
    install_general_tools
    install_elf_tools
    install_pip
    install_snap
    install_peda_pwndbg_gef
    cleanup

    echo "Reloading .bashrc to apply changes..."
    source ~/.bashrc

    echo "Installation of malware analysis tools complete. Run the following commands to launch the corresponding GDB environment: 
        gdb-peda
        gdb-pwndbg
        gdb-gef"
}

# Run the script
main