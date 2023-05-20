# debian-bullseye-server-setup

```sh
ssh root@<ADDRESS>
```

```sh
sudo apt update
sudo apt install -y git
git clone https://github.com/nickramsay19/debian-bullseye-server-setup.git 
cd debian-bullseye-server-setup
sh setup.sh
```

Done!

## Dev branch
```sh
sudo apt update
sudo apt install -y git
git clone --branch dev https://github.com/nickramsay19/debian-bullseye-server-setup.git 
cd debian-bullseye-server-setup
sh setup.sh
```

## Backlog
* fix LICENSE.md 
* add ```sh
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    ```
    to `/etc/ssh/sshd_config`
