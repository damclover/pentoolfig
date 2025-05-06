#!/bin/bash

# Function to execute commands
execc() {
    echo "Executing: $1"
    eval "$1"
}

# Create directories for storing tools
mkdir -p ~/Documents/Tools

# Set up Kali Linux repositories (Uncomment if mirrors are not already configured)
#echo 'deb http://kali.download/kali kali-rolling main contrib non-free non-free-firmware' | sudo tee /etc/apt/sources.list
#echo 'deb-src http://kali.download/kali kali-rolling main contrib non-free non-free-firmware' | sudo tee /etc/apt/sources.list

# Set DNS servers
#echo "Configuring DNS servers..."
#echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4' | sudo tee /etc/resolv.conf

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y build-essential golang python3 python3-pip python3-dev python3-venv curl wget git unzip php gcc make

# List of tools to install
tools=('nmap' 'nikto' 'sqlmap' 'whatweb' 'gobuster' 'ffuf' 'dirb' 'dirbuster' 
       'wpscan' 'dnsenum' 'dnsrecon' 'whois' 'theharvester' 'sublist3r' 
       'amass' 'metasploit-framework' 'hydra' 'john' 'hashcat' 'curl' 'wget'
       'netcat-openbsd' 'tcpdump' 'zmap' 'masscan' 'enum4linux' 'smbclient' 
       'smbmap' 'ldap-utils' 'feroxbuster' 'sslscan' 'wfuzz' 'xsser' 'recon-ng'
       'seclists' 'wordlists' 'wafw00f' 'subfinder' 'iptables')

# Install the listed tools
for tool in "${tools[@]}"; do
    echo "Installing $tool..."
    sudo apt install -y $tool
done

# List of Go tools to install
go_tools=("github.com/projectdiscovery/katana/cmd/katana" 
          "github.com/hahwul/dalfox/v2"
          "github.com/lc/gau/v2/cmd/gau"
          "github.com/projectdiscovery/nuclei/v3/cmd/nuclei"
          "github.com/tomnomnom/gf")

# Install Go tools
for tool in "${go_tools[@]}"; do
    echo "Installing Go tool $tool..."
    sudo go install $tool@latest
done

# Add Go to PATH
echo "Adding Go to PATH..."
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc

# Install pipx and other Python tools
echo "Installing pipx and other tools..."
sudo apt install -y pipx
pipx install uro

# Clone and install additional tools from GitHub
echo "Cloning GitHub repositories and installing additional tools..."

# 4-ZERO-3
git clone https://github.com/Dheerajmadhukar/4-ZERO-3 ~/Documents/Tools/4-ZERO-3
chmod +x ~/Documents/Tools/4-ZERO-3/403-bypass.sh

# damcrawler
git clone https://github.com/damclover/damcrawler ~/Documents/Tools/damcrawler
chmod +x ~/Documents/Tools/damcrawler/install.sh
~/Documents/Tools/damcrawler/install.sh

# ghauri
git clone https://github.com/r0oth3x49/ghauri ~/Documents/Tools/ghauri
sudo python3 ~/Documents/Tools/ghauri/setup.py install

# Unzip rockyou wordlist if available
echo "Unzipping rockyou.txt.gz..."
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y && sudo apt-get update && sudo apt-get upgrade -y

# Completion message
echo "Installation completed successfully!"
