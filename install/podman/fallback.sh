# 1. Удалить кривой репозиторий Kubic
sudo rm /etc/apt/sources.list.d/kubic.list
sudo rm /etc/apt/keyrings/kubic.gpg

# 2. Удалить podman и containers-common полностью
sudo apt purge podman containers-common -y
sudo apt autoremove -y

# 3. Очистить кэш apt
sudo apt clean
sudo apt update

# 4. Установить podman из стандартного репозитория Debian 12
sudo apt install podman -y

# 5. Проверить версию
podman version
