# SSH Access

Convert the key from ppk to pem format:
```bash
brew install putty
puttygen ~/Downloads/Awingu-4-key.ppk -O private-openssh -o awingu.pem
mv awingu.pem ~/.ssh/
```

Login:
```bash
ssh -i ~/.ssh/awingu.pem.pem root@172.22.2.243
```