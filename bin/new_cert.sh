#!/bin/bash
# Initial scipt - TOM
# Script to generate SSL certificate signing request (CSR) and private key

# Check if OpenSSL is installed
if ! command -v openssl &> /dev/null; then
    echo "Error: OpenSSL is not installed. Please install OpenSSL first."
    exit 1
fi

# Check if domain name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domain_name>"
    echo "Example: $0 dash.lib.harvard.edu"
    exit 1
fi

DOMAIN="$1"
CERT_DIR="certs"
echo " --> Making certs DIR"

# Create certs directory if it doesn't exist
if [ ! -d "$CERT_DIR" ]; then
    mkdir -p "$CERT_DIR" || {
        echo "Error: Failed to create directory $CERT_DIR"
        exit 1
    }
fi

# Check if files already exist to prevent overwriting
if [ -f "$CERT_DIR/$DOMAIN.key" ] || [ -f "$CERT_DIR/$DOMAIN.csr" ]; then
    echo "Error: Files $CERT_DIR/$DOMAIN.key or $CERT_DIR/$DOMAIN.csr already exist."
    echo "Delete them first or use a different domain name."
    exit 1
fi

# Generate CSR and private key
echo "Generating CSR and private key for $DOMAIN..."
openssl req -nodes -new -newkey rsa:4096 \
    -keyout "$CERT_DIR/$DOMAIN.key" \
    -out "$CERT_DIR/$DOMAIN.csr" \
    -subj "/C=US/ST=Massachusetts/L=Cambridge/O=President and Fellows of Harvard College/OU=HUIT LTS/CN=$DOMAIN" || {
    echo "Error: Failed to generate CSR or private key"
    exit 1
}

echo " --> Successfully generated:"
echo " - Private key: $CERT_DIR/$DOMAIN.key"
echo " - CSR: $CERT_DIR/$DOMAIN.csr"