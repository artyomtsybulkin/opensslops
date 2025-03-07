#!/bin/bash

# Unique variables
PASSWORD="password"
OU="CA"
MAIL="security@mydomain.com"
CA="mydomain.com"
ORG="IT"
COUNTRY="CA"
STATE="Ontario"
CITY="Toronto"

# Paths
CNAMES="cnames.txt"
DROOT="../dist/root/"
DCERT="../dist/cert/"

# Common variables
CAKU="keyUsage = keyCertSign"
SKU="keyUsage = digitalSignature, keyEncipherment"
EKU="extendedKeyUsage = serverAuth, clientAuth"
