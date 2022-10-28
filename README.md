# README

### Make sure you have Docker & Docker Compose installed locally

### Run brew to install some development tools

```bash
$ brew bundle
```

### Edit /etc/hosts file

Add the following lines:

```bash
127.0.0.0    tutorize.io.local
```

### Generate the certificate

```bash
$ mkcert -install
$ mkcert -cert-file ssl/tutorize.io.local.pem -key-file ssl/tutorize.io.local.key "tutorize.io.local" "*.tutorize.io.local"
```
