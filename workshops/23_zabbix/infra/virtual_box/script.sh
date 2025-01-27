echo "Update and upgrade"
sudo apt update && sudo apt upgrade -y

echo "Install Zabbix"
wget https://repo.zabbix.com/zabbix/7.2/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.2+ubuntu22.04_all.deb
dpkg -i zabbix-release_latest_7.2+ubuntu22.04_all.deb

echo "Install Addons"
apt update
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

echo "Install DB"
apt install mysql-server