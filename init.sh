#!/bin/bash

update_system() {
    echo "Updating the system..."
    sudo apt install snapd || { echo "Failed to install snapd. Exiting..."; exit 1; }
    sudo apt-get update && sudo apt-get upgrade -y || { echo "Failed to update system. Exiting..."; exit 1; }
}

install_no_machine() {
    echo "Installing NoMachine..."
    if ! dpkg -l | grep -q nomachine; then
        wget https://download.nomachine.com/download/8.11/Linux/nomachine_8.11.3_4_amd64.deb || { echo "Failed to download NoMachine. Exiting..."; exit 1; }
        sudo dpkg -i nomachine_8.11.3_4_amd64.deb || { echo "Failed to install NoMachine. Exiting..."; exit 1; }
    else
        echo "NoMachine is already installed. Skipping..."
    fi
}

install_general_tools() {
    echo "Installing general malware analysis tools..."
    sudo apt-get install -y git python3 python3-pip wireshark clamav yara chkrootkit rkhunter strace gdb tcpdump || { echo "Failed to install general tools. Exiting..."; exit 1; }
}

install_elf_tools() {
    echo "Installing ELF analysis tools..."
    sudo apt-get install -y binutils elfutils ltrace patchelf binwalk hexedit nmap htop || { echo "Failed to install ELF tools. Exiting..."; exit 1; }
}

install_static_analysis_tools() {
    echo "Installing static analysis tools..."
    pip3 install --upgrade pefile capstone uncompyle6 || { echo "Failed to install pip packages for static analysis. Exiting..."; exit 1; }
}

install_dynamic_analysis_tools() {
    echo "Installing dynamic analysis tools..."
    pip3 install --upgrade angr || { echo "Failed to install angr. Exiting..."; exit 1; }
    sudo pip3 install --upgrade frida || { echo "Failed to install frida. Exiting..."; exit 1; }
}

install_r2() {
    echo "Installing radare2..."
    if [ ! -d "radare2" ]; then
        git clone https://github.com/radareorg/radare2 || { echo "Failed to clone radare2 repository. Exiting..."; exit 1; }
    else
        cd radare2
        git pull || { echo "Failed to update radare2 repository. Exiting..."; exit 1; }
        cd ..
    fi
    cd radare2
    sudo ./sys/install.sh || { echo "Failed to install radare2. Exiting..."; exit 1; }
    cd ..
}

install_pip() {
    echo "Installing pip packages..."
    pip3 install --upgrade ROPgadget volatility3 || { echo "Failed to install pip packages. Exiting..."; exit 1; }
}

install_gdb_plugins() {
    echo "Installing GDB plugins..."
    if ! command -v gdb-peda &> /dev/null; then
        if [ ! -d "gdb-peda-pwndbg-gef" ]; then
            git clone https://github.com/pipzer0/gdb-peda-pwndbg-gef || { echo "Failed to clone gdb-peda-pwndbg-gef repository. Exiting..."; exit 1; }
        else
            cd gdb-peda-pwndbg-gef
            git pull || { echo "Failed to update gdb-peda-pwndbg-gef repository. Exiting..."; exit 1; }
            cd ..
        fi
        cd gdb-peda-pwndbg-gef
        chmod +x install.sh
        ./install.sh || { echo "Failed to install GDB plugins. Exiting..."; exit 1; }
        cd ..
    else
        echo "GDB PEDA is already installed. Skipping installation..."
    fi
}

cleanup() {
    echo "Cleaning up..."
    rm -rf nomachine_8.11.3_4_amd64.deb radare2 db-peda-pwndbg-gef || { echo "Failed to clean up. Exiting..."; exit 1; }
}


main() {
    update_system
    install_no_machine
    install_general_tools
    install_elf_tools
    install_static_analysis_tools
    install_dynamic_analysis_tools
    install_pip
    install_r2
    install_gdb_plugins
    cleanup
}

# Run the script
main
