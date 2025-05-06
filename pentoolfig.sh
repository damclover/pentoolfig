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
sudo apt install -y build-essential golang python3 python3-pip python3-dev python3-venv curl wget git unzip gcc make

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
sudo chmod +x ~/Documents/Tools/4-ZERO-3/403-bypass.sh

# damcrawler
git clone https://github.com/damclover/damcrawler ~/Documents/Tools/damcrawler
cd ~/Documents/Tools/damcrawler
sudo chmod +x install.sh
sudo ./install.sh
cd ~

# ghauri
git clone https://github.com/r0oth3x49/ghauri ~/Documents/Tools/ghauri
cd ~/Documents/Tools/ghauri
pip install -r requirements.txt --break-system-packages
pip install setuptools --break-system-packages
sudo pip install setuptools --break-system-packages
sudo python3 setup.py install
cd ~

# Unzip rockyou wordlist if available
echo "Unzipping rockyou.txt.gz..."
sudo gzip -d /usr/share/wordlists/rockyou.txt.gz

# Ensure the proper Kali repository exists
REPO_LINE="deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware"
if ! grep -Fxq "$REPO_LINE" /etc/apt/sources.list; then
    echo "Adding missing Kali repository to sources.list..."
    echo "$REPO_LINE" | sudo tee -a /etc/apt/sources.list
    sudo apt update
else
    echo "Kali repository already present. Continuing..."
fi

# BONUS: Install Sublime Text via Flatpak
echo "BONUS!!!! Installing Sublime Text (use as 'subl')"

# Install flatpak if not present
if ! command -v flatpak &> /dev/null; then
    echo "Installing flatpak..."
    sudo apt update
    sudo apt install -y flatpak
else
    echo "Flatpak already installed."
fi

# Add Flathub remote and install Sublime Text
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub com.sublimetext.three

# Add alias to bashrc if not already there
if ! grep -q 'alias subl=' ~/.bashrc; then
    echo 'alias subl="flatpak run com.sublimetext.three"' >> ~/.bashrc
    echo "Alias 'subl' added to ~/.bashrc"
fi

# Reload the bashrc file to ensure the alias is applied immediately
source ~/.bashrc

# Inform the user
echo "Sublime Text installed and 'subl' alias is now active!"


# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y && sudo apt-get update && sudo apt-get upgrade -y

# Completion message
echo "Installation completed successfully!"
