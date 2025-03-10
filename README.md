# opensslops
OpenSSL operations for Linux, Windows and more

There are couple scripts for OpenSSL generation with root certificate signature, compacted into pfx.
These certificates can be used for Hyper-V replication encryption, Nginx server client authentication and other client-server encryption operations.

Tested on MacOS with OpenSSL:

```bash
openssl --version
OpenSSL 3.4.0 22 Oct 2024 (Library: OpenSSL 3.4.0 22 Oct 2024)
```

## Usage

1. Clone repository and switch to directory `scripts/`:
```bash
git clone https://github.com/artyomtsybulkin/opensslops.git
cd opensslops/scripts/
```
2. Open for edit `variables.sh` and change certificate properties to appropriate values.
3. Open for edit `cnames.txt` and list target host FQDN values.
4. Run `new_root.sh` to generate new root Certificate Authority certificate.
```bash
chmod +x new_root.sh
./new_root.sh > openssl.log 2>&1
```
5. Run `new_cert.sh` to generate certificates for each host listed in `cnames.txt`.
```bash
chmod +x new_root.sh
./new_cert.sh > openssl.log 2>&1
```