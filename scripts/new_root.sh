#!/bin/bash

source variables.sh

# Subject
SUBJ="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$OU/CN=$CA/emailAddress=$MAIL"

# Create CSR
openssl req -new -newkey rsa:2048 -nodes -subj "$SUBJ" \
    -keyout "$CA.key" -out "$CA.csr" \
    -addext "$CAKU" -addext "$EKU"

# Check CSR
openssl req -in "$CA.csr" -noout -text

# Create SSL
openssl req -new -x509 -days 3650 -sha256 -nodes -copy_extensions=copyall \
    -key "$CA.key" -subj "$SUBJ" -out "$CA.crt" \
    -addext "$CAKU" -addext "$EKU"

# Compress to PFX
openssl pkcs12 -export -legacy \
    -inkey "$CA.key" -in "$CA.crt" -out "$CA.pfx" \
    -password pass:$PASSWORD

mkdir -p "$DROOT"
mv "$CA.key" "$CA.crt" "$CA.csr" "$CA.pfx" "$DROOT"