
# 🔧 Pentest Installer Script

This is a Python automation script that installs a wide range of cybersecurity and penetration testing tools via APT, Git, and Go.

> **Target Platforms:**  
> ✅ Kali Linux (bare metal or WSL)  
> ✅ Linux Mint / Ubuntu / Debian (with `apt`)  
> ✅ WSL (Windows Subsystem for Linux) with internet access

## 📦 What It Installs

### 🛠️ APT Tools
Includes common CLI-based tools used in web hacking, recon, and infrastructure enumeration:

```
nmap, nikto, sqlmap, whatweb, gobuster, ffuf, dirb, dirbuster, wpscan,
dnsenum, dnsrecon, whois, theharvester, sublist3r, amass, metasploit-framework,
hydra, john, hashcat, curl, wget, netcat-openbsd, tcpdump, zmap, masscan,
enum4linux, smbclient, smbmap, ldap-utils, feroxbuster, sslscan, wfuzz,
xsser, recon-ng, seclists, wordlists, wafw00f, subfinder, iptables, ghauri,
uro, gf
```

### 🧰 Go-based Tools
The script automatically installs these using `go install`:

- [Katana](https://github.com/projectdiscovery/katana) – web crawler
- [gau](https://github.com/lc/gau) – get all URLs from public archives
- [Nuclei](https://github.com/projectdiscovery/nuclei) – vulnerability scanner

### 🐍 Python and Dependencies
- `python3`
- `pip3`

---

## 🧙 Additional Tools (via Git)

These tools are cloned and installed in `~/Documents/Tools/`:

- [4-ZERO-3](https://github.com/Dheerajmadhukar/4-ZERO-3)
- [damcrawler](https://github.com/damclover/damcrawler)
- [ghauri](https://github.com/r0oth3x49/ghauri)

---

## Bonus !!!
- Sublime Text

## 🧠 How It Works

The script does the following:

1. Installs tools via `apt`.
2. Installs and configures Go.
3. Installs Go-based tools to `$HOME/go/bin`.
4. Adds Go path to `.bashrc`.
5. Sets Kali repo (optional for WSL setups).
6. Decompresses the RockYou wordlist if available.
7. Performs a full system upgrade.

---

## ✅ Usage

Run the script using Python 3:

```bash
sudo chmod +x pentoolfig.sh
./pentoolfig.sh
```

Make sure to give it `sudo` permission, as most tools require administrative privileges to install.

---

## 📂 Output Structure

All Git-based tools will be installed into:

```
~/Documents/Tools/
```

---

## ⚠️ Notes

- This script assumes you have internet access.
- On WSL, make sure DNS resolution works (`ping github.com` to test).
- The Go-based tools will only work after restarting your shell or sourcing `.bashrc`.

---

## 💡 Author

Made by [damclover](https://github.com/damclover) for quick setup of a hacking toolkit in clean environments.
