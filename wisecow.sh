#!/bin/bash

# Ensure /usr/games is in the PATH
PATH=$PATH:/usr/games
export PATH

# Debug: Check for required commands
for cmd in fortune cowsay nc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed or not in PATH."
        exit 1
    fi
done

echo "Wisdom served on port=4499..."
while true; do
    # Generate the "wisdom" message
    MESSAGE=$(fortune | cowsay)

    # Build the HTTP response
    RESPONSE="HTTP/1.1 200 OK\r\n"
    RESPONSE+="Content-Type: text/plain\r\n"
    RESPONSE+="Content-Length: ${#MESSAGE}\r\n"
    RESPONSE+="\r\n"
    RESPONSE+="$MESSAGE"

    # Serve the response
    echo -e "$RESPONSE" | nc -l -p 4499 -q 1
done
