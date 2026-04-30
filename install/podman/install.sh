# 1. Добавить ключ и репозиторий
sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/Debian_12/Release.key" | gpg --dearmor | sudo tee /etc/apt/keyrings/kubic.gpg >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/kubic.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_12/ /" | sudo tee /etc/apt/sources.list.d/kubic.list

# 2. Обновить и установить Podman
sudo apt update
sudo apt install podman

# 3. Проверить версию (должна быть 5.x)
podman version
