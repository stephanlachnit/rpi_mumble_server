# Raspberry Pi configuration for a headless mumble server

### 1. Prerequisites
Set up a RPi with enabled ssh, change default password (and hostname), and extend the file system.
It's recommended to create a non-sudo user and restrict ssh login access to this user.
You may need to set up a dynamic DNS service and open port 64738 on your Router.

### 2. Install the murmur
It's import to reconfigure the server, as it will allow you to set a SuperUser password.

```bash
sudo apt update
sudo apt full-upgrade --autoremove
sudo apt install mumble-server
sudo dpkg-reconfigure mumble-server
```

### 3. Set up iptables
It's necessary to open Port 64738 on the Raspberry as well, and we should reject login spams for the ssh port.
Download `iptables.sh`, make it executable with `chmod +x ./iptables.sh` and run it with `sudo ./iptables.sh`.
To make the rules persisent, run `sudo apt install iptables-persistent` and answer the prompts with yes.

### 4. Reduce power consumption
To reduce the power consumption as mmuch as possible, we can adjust the RPi's config.
Download `config.txt` and replace the default config with with `sudo mv ./config.txt /boot/config.txt`.
Note that with this config, it's impossible to access the RPi with a monitor.
If you need local access, add a `#` in front of line 35 and 38.

### Notes
I tested the config with a Raspberry Pi 3. You're welcome to share improvements.
Please be aware that running a server is always a security risk and I'm not a security expert.
