#!/bin/bash
# Initial Tom script

openssl req -nodes -new -newkey rsa:4096 -keyout certs/$1.key -out certs/$1.csr -subj "/C=US/ST=Massachusetts/L=Cambridge/O=President and Fellows of Harvard College/OU=HUIT LTS/CN=$1"