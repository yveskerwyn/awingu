# SSH Access

https://stackoverflow.com/questions/3475069/use-ppk-file-in-mac-terminal-to-connect-to-remote-connection-over-ssh

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