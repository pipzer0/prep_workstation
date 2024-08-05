# Malware Analysis Tools Installation Script

This script installs a comprehensive set of tools for malware analysis on a Linux system. Below is a detailed description of each tool included in the script and the purpose of each section.

## Script Overview

The script is divided into several functions, each responsible for installing different sets of tools and performing specific tasks:

1. `update_system`: Updates the system package list and upgrades all installed packages.
2. `install_no_machine`: Installs NoMachine for remote desktop access.
3. `install_general_tools`: Installs general malware analysis tools such as Git, Python, Wireshark, ClamAV, YARA, and others.
4. `install_elf_tools`: Installs tools for analyzing ELF (Executable and Linkable Format) files.
5. `install_static_analysis_tools`: Installs tools for static analysis of malware.
6. `install_dynamic_analysis_tools`: Installs tools for dynamic analysis of malware.
7. `install_pip`: Installs additional Python packages required for malware analysis.
8. `install_gdb_plugins`: Installs GDB plugins for enhanced debugging capabilities.
9. `cleanup`: Placeholder for any cleanup actions that might be necessary after installation.
10. `main`: The main function that orchestrates the execution of all other functions.

## Detailed Description of Tools

### General Malware Analysis Tools

- **git**: A version control system for tracking changes in computer files and coordinating work on those files among multiple people.
- **python3 and python3-pip**: Python3 is a programming language, and pip is a package manager for Python that allows you to install and manage additional packages.
- **wireshark**: A network protocol analyzer that lets you capture and interactively browse the traffic running on a computer network.
- **clamav**: An open-source antivirus engine for detecting trojans, viruses, malware, and other malicious threats.
- **yara**: A tool aimed at helping malware researchers identify and classify malware samples.
- **chkrootkit**: A tool to locally check for signs of a rootkit.
- **rkhunter**: Rootkit Hunter is a Unix-based tool that scans for rootkits, backdoors, and possible local exploits.
- **strace**: A diagnostic, debugging, and instructional userspace utility for Linux.
- **gdb**: The GNU Project debugger, which allows you to see what is going on inside a program while it executes.
- **tcpdump**: A powerful command-line packet analyzer and packet capture tool.

### ELF Analysis Tools

- **binutils**: A collection of binary tools including `ld`, `as`, `objdump`, and more, used to manipulate binary and object files.
- **elfutils**: A set of utilities and libraries to handle ELF (Executable and Linkable Format) files.
- **ltrace**: A debugging utility in Linux to display the calls a user-space application makes to shared libraries.
- **patchelf**: A small utility to modify the dynamic linker and RPATH of ELF executables.
- **binwalk**: A fast, easy-to-use tool for analyzing, reverse engineering, and extracting firmware images.
- **hexedit**: A command-line hex editor.
- **nmap**: A network scanning tool used to discover hosts and services on a computer network.
- **htop**: An interactive process viewer for Unix systems.

### Static Analysis Tools

- **radare2**: An open-source software for performing binary analysis and reverse engineering.
- **pefile**: A Python module to read and work with Portable Executable (PE) files.
- **capstone**: A lightweight multi-platform, multi-architecture disassembly framework.
- **uncompyle6**: A Python cross-version byte-code decompiler.

### Dynamic Analysis Tools

- **angr**: A platform-agnostic binary analysis framework.
- **dynamorio**: A runtime code manipulation system that supports code transformations on any part of a program, while it executes.
- **frida**: A dynamic instrumentation toolkit for developers, reverse-engineers, and security researchers.

### Pip Packages

- **ROPgadget**: A tool to find ROP gadgets in binaries.
- **volatility3**: An advanced memory forensics framework.

### GDB Plugins

- **PEDA (Python Exploit Development Assistance for GDB)**: A GDB plugin to enhance the exploit development process.
- **pwndbg**: A GDB plugin that enhances the experience of debugging binary applications.
- **gef (GDB Enhanced Features)**: A GDB plugin aimed at providing additional features to enhance GDB for exploit development and reverse engineering.

## How to Run the Script

1. git clone https://github.com/pipzer0/prep_workstation
2. Make the script executable: `chmod +x prep_workstation/init.sh`.
3. Run the script: `prep_workstation/init.sh`.
 