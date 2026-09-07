#!/bin/bash

# Ask the user to enter a URL and store it in the "url" variable
read -p "Enter a URL: " url

echo
echo "VirusTotal URL Checker"
echo "----------------------"
echo "URL: $url"
echo

# Convert the URL into the URL-safe Base64 identifier
# VirusTotal uses this identifier for the URL API endpoint
#
# printf '%s' "$url"  -> outputs the URL without adding a newline
# base64 -w 0         -> Base64-encodes the URL without line breaks
# tr '+/' '-_'        -> converts normal Base64 to URL-safe Base64
# tr -d '='           -> removes Base64 padding characters
url_id=$(printf '%s' "$url" | base64 -w 0 | tr '+/' '-_' | tr -d '=')

# Send a GET request to VirusTotal using the encoded URL identifier
# The API key is stored in the VT_API_KEY environment variable
response=$(curl --silent \
  --request GET \
  --url "https://www.virustotal.com/api/v3/urls/$url_id" \
  --header "x-apikey: $VT_API_KEY")

# Extract the detection counts from VirusTotal's JSON response
malicious=$(echo "$response" | jq '.data.attributes.last_analysis_stats.malicious')
suspicious=$(echo "$response" | jq '.data.attributes.last_analysis_stats.suspicious')
harmless=$(echo "$response" | jq '.data.attributes.last_analysis_stats.harmless')
undetected=$(echo "$response" | jq '.data.attributes.last_analysis_stats.undetected')

# Display the VirusTotal detection statistics
echo "Malicious:  $malicious"
echo "Suspicious: $suspicious"
echo "Harmless:   $harmless"
echo "Undetected: $undetected"

# Check whether any security vendors classified the URL
# as malicious or suspicious
if [ "$malicious" -gt 0 ] || [ "$suspicious" -gt 0 ]; then

    echo
    echo "⚠ Findings"
    echo "----------------------"

    # If malicious detections exist, display the vendors
    # that classified the URL as malicious
    if [ "$malicious" -gt 0 ]; then
        echo
        echo "Malicious:"

        echo "$response" | jq -r '
            .data.attributes.last_analysis_results
            | to_entries[]
            | select(.value.category == "malicious")
            | "  Vendor: \(.key)\n  Result: \(.value.result)\n"
        '
    fi

    # If suspicious detections exist, display the vendors
    # that classified the URL as suspicious
    if [ "$suspicious" -gt 0 ]; then
        echo
        echo "Suspicious:"

        echo "$response" | jq -r '
            .data.attributes.last_analysis_results
            | to_entries[]
            | select(.value.category == "suspicious")
            | "  Vendor: \(.key)\n  Result: \(.value.result)\n"
        '
    fi

else
    # If there are no malicious or suspicious detections,
    # report that the URL has no such detections
    echo
    echo "✓ No malicious or suspicious detections"
fi
