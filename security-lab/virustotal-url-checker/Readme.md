# VirusTotal URL Checker

## Overview

This tool uses the VirusTotal URL Analysis API to retrieve an existing analysis report for a given URL. The report contains threat detection results from antivirus engines, blocklists, and other security tools.

The script is written in Bash and uses `curl` to communicate with the VirusTotal API and `jq` to parse the returned JSON data.

## Features

* Accepts a URL as user input
* Queries the VirusTotal API for an existing URL analysis
* Displays malicious, suspicious, harmless, and undetected detection counts
* Identifies which security vendors classified the URL as malicious or suspicious
* Uses `jq` to filter and format VirusTotal's JSON response

## Requirements

* Linux
* Bash
* `curl`
* `jq`
* A VirusTotal account
* A VirusTotal API key

## Setup

Create a VirusTotal account and obtain an API key.

Store the API key in an environment variable:

```bash
export VT_API_KEY="YOUR_API_KEY"
```

The script uses this environment variable to authenticate with the VirusTotal API.

## Usage

Make the script executable:

```bash
chmod +x VT_URL_checker_v2.sh
```

Run the script:

```bash
./VT_URL_checker_v2.sh
```

Enter a URL when prompted.

## Example Output

```text
VirusTotal URL Checker
----------------------
URL: https://example.com

Malicious:  1
Suspicious: 0
Harmless:   58
Undetected: 33

⚠ Findings
----------------------

Malicious:
  Vendor: Dr.Web
  Result: malicious
```

## Security Notes

The VirusTotal API key should never be hard-coded into the script or committed to GitHub.

This project uses the `VT_API_KEY` environment variable so the API key remains separate from the source code.

## Future Improvements

* Add error handling for URLs without an existing VirusTotal report
* Add automatic risk classification
* Add logging of results
* Improve output formatting
* Integrate the checker into a Certificate Transparency monitoring pipeline
