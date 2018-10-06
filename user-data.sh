#!/bin/bash

# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-the-mosquitto-mqtt-messaging-broker-on-ubuntu-18-04-quickstart
# https://loige.co/using-lets-encrypt-and-certbot-to-automate-the-creation-of-certificates-for-openvpn/

sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get -y update
sudo apt-get -y install certbot
sudo apt-get -y install mosquitto
sudo apt-get -y install mosquitto-clients

sudo ufw allow 80
sudo ufw allow 8883
sudo ufw allow 8083

sudo touch /etc/mosquitto/passwd
sudo mosquitto_passwd -b /etc/mosquitto/passwd ${user} ${password}

sudo echo 'allow_anonymous false' > /etc/mosquitto/conf.d/default.conf
sudo echo 'password_file /etc/mosquitto/passwd' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'listener 8883' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'certfile /etc/letsencrypt/live/${domain}/cert.pem' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'cafile /etc/letsencrypt/live/${domain}/chain.pem' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'keyfile /etc/letsencrypt/live/${domain}/privkey.pem' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'listener 8083' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'protocol websockets' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'certfile /etc/letsencrypt/live/${domain}/cert.pem' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'cafile /etc/letsencrypt/live/${domain}/chain.pem' >> /etc/mosquitto/conf.d/default.conf
sudo echo 'keyfile /etc/letsencrypt/live/${domain}/privkey.pem' >> /etc/mosquitto/conf.d/default.conf

sleep 20s 

sudo certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --preferred-challenges http \
  --email ${email} \
  --domains ${domain} \
  --pre-hook 'sudo systemctl stop mosquitto' \
  --post-hook 'sudo systemctl start mosquitto'
