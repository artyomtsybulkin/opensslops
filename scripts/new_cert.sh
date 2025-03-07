#!/bin/bash

source variables.sh

# Check if the file exists
if [ ! -f "$CNAMES" ]; then
    echo "Error: File $CNAMES not found."
    exit 1
fi

# Read hostnames from the file and iterate over them
while IFS= read -r SERVER; do
    echo "Creating SSL for $SERVER"
    # Generating end-point server certificate
    SUBJ="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$OU/CN=$SERVER/emailAddress=$MAIL"
    echo "# Performing CSR"
    openssl req -new -newkey rsa:2048 -subj "$SUBJ" \
        -keyout "$SERVER.key" -out "$SERVER.csr" \
        -addext "$SKU" -addext "$EKU" \
        -passout pass:$PASSWORD
    echo "# Performing CSR check"
    openssl req -in "$SERVER.csr" -noout -text
    echo "# Performing SSL generation"
    openssl x509 -req -days 1825 -sha256 \
        -in "$SERVER.csr" -CA "$DROOT$CA.crt" -CAkey "$DROOT$CA.key" \
        -CAcreateserial -subj "$SUBJ" -out "$SERVER.crt" \
        -passin pass:$PASSWORD
    echo "# Performing PFX compression"
    openssl pkcs12 -export \
        -inkey "$SERVER.key" -in "$SERVER.crt" \
        -certfile "$DROOT$CA.crt" -out "$SERVER.pfx" \
        -password pass:$PASSWORD -passin pass:$PASSWORD
    mkdir -p "$DCERT"
    mv "$SERVER.key" "$SERVER.crt" "$SERVER.pfx" "$SERVER.csr" "$DCERT"
done < "$CNAMES"