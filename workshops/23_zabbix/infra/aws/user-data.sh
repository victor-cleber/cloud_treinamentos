### Zabbix
>> configuration
https://www.zabbix.com/la/manuals/aws_deployment_guide
Installation size: Medium
Monitored metrics1: 10 000
CPU/vCPU cores: 4
Memory: 16(GiB)
Database MySQL
Amazon EC22	m6i.xlarge/m6g.xlarge

RDS EC2 connection limits
https://serverfault.com/questions/1080541/aws-rds-mysql-connection-limits

Price
https://instances.vantage.sh/aws/rds/db.m6i.large
https://instances.vantage.sh/aws/rds/db.t3.large

Calculator
https://calculator.aws/#/estimate?id=88ba3ae554fc0f6a1238878679904debbbe969a4

https://www.zabbix.com/documentation/current/en/manual/installation/requirements


>> troubleshooting
https://www.zabbix.com/forum/zabbix-troubleshooting-and-problems/355419-zabbix-server-is-not-running
RDS max connections
https://serverfault.com/questions/862387/aws-rds-connection-limits

https://10web.io/blog/how-to-fix-mysql-error-1040-too-many-connections/
SHOW VARIABLES LIKE "max_connections";


#### Grafana 

1- grafico de registros no banco de dados
https://medium.com/@habbema/grafana-82204ad37366




#### ALL SERVERS
sudo apt update
sudo apt upgrade -y
sudo apt install zip -y
cd /tmp
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo apt install python3.10-venv -y
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


aws ssm get-parameter \
    --name "srv_private_key" \
    --with-decryption  --region us-east-1

aws secretsmanager list-secrets --region us-east-1


aws ssm describe-parameters --region us-east-1

#### GLPI ####
exemplo de repositorio
https://github.com/czantoine/glpi-on-rds-high-availability-for-aws



aws --region=us-east-1 ssm get-parameters --names "srv_private_key" --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/' | sed 's/KEY-----.*/KEY-----/' > id_rsa



https://www.atlantic.net/dedicated-server-hosting/how-to-install-glpi-it-inventory-management-on-ubuntu-22-04/

sudo apt install apache2  php php-common php-mysql libapache2-mod-php php-gd php-curl php-json php-xmlrpc php-intl php-bcmath php-zip php-apcu php-mbstring php-fileinfo php-xml php-soap php-zip -y

nano /etc/php/8.1/apache2/php.ini

CREATE USER 'glpi'@'localhost' IDENTIFIED BY '09-lmte23(I';

usuario e senha padrao glpi glpi


https://www.zabbix.com/integrations/glpi
Created problems have the next severity mapping:


zabbix zabbix@123



Glpi integracao com zabbix

user zabbix
api token ExLQXsZ8HEn1w9yOgiLgdEJf5fPhMMWzhZOqEJ2d


no zabbix
usuario glpi    zabbix@123



root@ip-100-64-5-254:/var/www# history
    1  chmod u+rw /var/www/glpi/{files,config}
    2  nano /etc/apache2/sites-available/glpi.conf
    3  a2ensite glpi.conf
    4  systemctl restart apache2
    5  systemtctl status apache2
    6  systemctl status apache2
    7  journalctl -xeu apache2.service
    8  a2enmod rewrite
    9  systemctl restart apache2
   10  a2ensite glpi.conf
   11  a2enmod rewrite
   12  systemctl restart apache2
   13  history


   para usar minha chave
    git remote set-url origin git@github.victor:victor-cleber/cloud_treinamentos.git

srv_zabbix ami-05f175293f888f72c
    workshop: 23
    created_by: victor
http://54.209.145.229/
http://54.209.145.229/zabbix    


windows_oficina_23

https://www.digitalocean.com/community/tutorials/how-to-create-temporary-and-permanent-redirects-with-apache-and-nginx
https://blog.leapp.cloud/how-to-fix-aws-invalidclienttokenid-the-security-token-included-in-the-request-is-invalid
https://spacelift.io/blog/terraform-debug

EC2SSMRole

sns_topic_cloud_training


http://alb-zabbix-2086222942.us-east-1.elb.amazonaws.com/
http://alb-zabbix-2086222942.us-east-1.elb.amazonaws.com/zabbix/index.php

#instalar agent zabbix Grafana server
## https://www.youtube.com/watch?v=SS3DPQAJacg

Zabbix 7.0.9
srv_grafana 
    hostname: ip-100-64-5-191
    publicIP : 100.64.5.191
    privateIP: 34.234.91.116

sudo apt update && sudo apt upgrade -y
cd /tmp
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu22.04_all.deb
abbix-release_latest_7.0+ubuntu22.04_all.deb

sudo apt update
sudo apt install zabbix-agent -y

sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent
sudo systemctl status zabbix-agent

### STEP 4 - CONFIGURE ZABBIX AGENT
sudo vim /etc/zabbix/zabbix_agentd.conf
configure Server e ServerActive

sudo systemctl restart zabbix-agent

Feb 12 09:02:23 ip-100-64-5-191 zabbix_agentd[60777]:
zabbix_agentd [60777]: error parsing the "ServerActive" parame>


systemctl status zabbix-agent.service
journalctl -xeu zabbix-agent.service

avaliar usar un network load balancer

google: alb ou network load balancer aws
High Availability and Scalability: By using an NLB in front of an ALB, you can achieve high availability and scalability. The NLB efficiently distributes traffic at the TCP level, while the ALB provides advanced request-level routing, ideal for HTTP/HTTPS traffic.
https://medium.com/@22.gautam/choosing-between-nlb-and-alb-in-aws-use-cases-and-real-life-examples-8cf60d905549