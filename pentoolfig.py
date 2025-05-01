from subprocess import run

tools = ['nmap', 'nikto', 'sqlmap', 'whatweb', 'gobuster', 'ffuf', 'dirb', 'dirbuster', 
         'wpscan', 'dnsenum', 'dnsrecon', 'whois', 'theharvester', 'sublist3r', 
         'amass', 'metasploit-framework', 'hydra', 'john', 'hashcat', 'curl', 'wget',
         'netcat-openbsd', 'tcpdump', 'zmap', 'masscan', 'enum4linux', 'smbclient', 
         'smbmap', 'ldap-utils', 'feroxbuster', 'sslscan', 'wfuzz', 'xsser', 'recon-ng',
         'seclists', 'wordlists', 'wafw00f', 'subfinder']

libs = ['golang', 'python3', 'python3-pip']

def execc(c):
    run(c, shell=True)

def install(thing_to_install):
    run(f"sudo apt install {thing_to_install} -y", shell=True)

def install_go_tools():
    commands = ["sudo go install github.com/projectdiscovery/katana/cmd/katana@latest",
                "go install github.com/hahwul/dalfox/v2@latest" , 
                "go install github.com/lc/gau/v2/cmd/gau@latest", 
                "go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && nuclei -update-templates"]
    for c in commands:
        execc(c)

# Install all shits
for tool in tools:
    if tool == 'golang':
        execc("echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc")
        install(tool)
    else:
        install(tool)

# Install libs
for lib in libs:
    if lib == 'golang':
        install(lib)
        execc("echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc")
    else:
        install(lib)

# Go tools
install_go_tools()

# Setting system
execc("echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware' | sudo tee /etc/apt/sources.list")
execc("mkdir -p ~/Documents/Tools")

# Installing another tools...
execc("sudo git clone https://github.com/Dheerajmadhukar/4-ZERO-3 ~/Documents/Tools/4-ZERO-3")
execc("sudo chmod +x ~/Documents/Tools/4-ZERO-3/403-bypass.sh")

execc("sudo git clone https://github.com/damclover/damcrawler ~/Documents/Tools/damcrawler")
execc("sudo chmod +x ~/Documents/Tools/damcrawler/install.sh && ~/Documents/Tools/damcrawler/install.sh")

execc("sudo gzip -d /usr/share/wordlists/rockyou.txt.gz")

execc("sudo apt update && sudo apt upgrade -y && sudo apt-get update && sudo apt-get upgrade -y")
