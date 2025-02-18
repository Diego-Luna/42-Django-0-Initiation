#!/bin/sh

url="$1"  # Get the input URL from the first argument

# Loop to follow redirections until there are no more Location headers
while true
do
    # Fetch the headers of the current URL silently
    headers=$(curl -sI "$url")
    # If no headers are returned, output an empty string and exit
    if [ -z "$headers" ]; then
        echo ""
        exit 0
    fi

    # Extract the Location header to determine redirection target
    location=$(echo "$headers" | grep -i '^location:' | cut -d ' ' -f2- | tr -d '\r')

    # If there's no Location header, it's the final URL
    if [ -z "$location" ]; then
        # Convert HTTPS to HTTP only for the domain "42.fr"
        if echo "$url" | grep -q '^https://42.fr'; then
            url="http:${url#https:}"
        fi
        # Output the final URL and exit
        echo "$url"
        exit 0
    fi

    # Update the URL with the redirection target and repeat
    url="$location"
done