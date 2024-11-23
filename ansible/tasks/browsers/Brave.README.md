## Script to install

```
sudo apt install curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
```
## Ansible modules to use

 * [apt\_key](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_key_module.html)
 * [apt\_repository](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_repository_module.html)
 * [apt](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html)
   * Because we need to update cache before install
