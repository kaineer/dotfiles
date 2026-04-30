# 1. Сначала принудительно установить конфликтующий пакет
sudo dpkg -i --force-overwrite /var/cache/apt/archives/containers-common_*_all.deb

# 2. Завершить установку
sudo apt --fix-broken install -y
