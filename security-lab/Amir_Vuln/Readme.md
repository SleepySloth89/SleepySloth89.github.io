# Amir Vulnerability Assessment

## Overview

Amir Vulnerability Assessment is a Bash-based Linux security assessment toolkit that brings several security tools together behind a simple command-line menu.

The goal of the project is to practice Bash scripting while creating a small, reusable security assessment utility.

## Features

* Interactive command-line menu
* Nmap port scanning
* Rate-limited active scanning
* Nmap vulnerability scanning using NSE scripts
* Linux security auditing with Lynis
* Rootkit discovery with Chkrootkit
* User-provided scan targets

## Tools Used

| Tool       | Purpose                                   |
| ---------- | ----------------------------------------- |
| Bash       | Script logic and menu system              |
| Nmap       | Port scanning and vulnerability detection |
| Lynis      | Linux security auditing                   |
| Chkrootkit | Rootkit discovery                         |

## Menu Structure

```text
1) Port Scans
   ├── 1) Active
   └── 2) Vulnerability Scan

2) Linux Security Audit

3) Rootkit Discovery
```

## Port Scanning

The active port scan uses Nmap with a limited scan rate and delay between probes.

The scan currently checks a selected set of commonly used ports.

Targets are entered by the user when the scan is started.

## Vulnerability Scanning

The vulnerability scan uses Nmap's version detection and vulnerability NSE scripts:

```bash
nmap -sV --script vuln "$target"
```

This is intended for authorized security testing and lab environments.

## Linux Security Audit

The Linux security audit uses Lynis:

```bash
lynis audit system
```

Lynis performs a security audit of the local Linux system and provides recommendations for improving its security configuration.

## Rootkit Discovery

Rootkit discovery uses Chkrootkit:

```bash
chkrootkit
```

The tool checks the local Linux system for indicators associated with known rootkits.

## Requirements

* Linux
* Bash
* Nmap
* Lynis
* Chkrootkit
* `sudo` privileges for security tools that require them

## Usage

Make the script executable:

```bash
chmod +x vuln_assessment.sh
```

Run the tool:

```bash
./vuln_assessment.sh
```

Select an option from the menu and provide a target when prompted.

## Example

```text
1) Port scans
2) Linux Security audit
3) Rootkit discovery
choose option:
```

## Security Notes

This tool is intended for systems and networks that you own or have explicit authorization to assess.

Do not use the scanning functionality against systems without permission.

## Future Improvements

* Add additional scan types
* Add better input validation
* Add error handling
* Add scan result logging
* Add report generation
* Improve menu navigation
* Add configurable scan timing and rate limits
* Add additional Linux security auditing tools
