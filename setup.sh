#!/bin/bash
apt-get update && apt upgrade
apt install curl

cd /usr/bin
wget -O about "http://autoscript.vpnstores.net/about.sh"
wget -O v2ray "http://autoscript.vpnstores.net/menu.sh"
wget -O usernew "http://autoscript.vpnstores.net/usernew.sh"
wget -O trial "http://autoscript.vpnstores.net/trial.sh"
wget -O hapus "http://autoscript.vpnstores.net/hapus.sh"
wget -O member "http://autoscript.vpnstores.net/member.sh"
wget -O delete "http://autoscript.vpnstores.net/delete.sh"
wget -O cek "http://autoscript.vpnstores.net/cek.sh"
wget -O restart "http://autoscript.vpnstores.net/restart.sh"
wget -O info "http://autoscript.vpnstores.net/info.sh"
wget -O ram "http://autoscript.vpnstores.net/ram.sh"
wget -O renew "http://autoscript.vpnstores.net/renew.sh"
wget -O v2ray "http://autoscript.vpnstores.net/v2ray.sh"

#Configurasi OpenVPN & Wireguard & SSR & L2TP & Dan V2RAY
wget https://github.com/Nyr/openvpn-install/blob/master/openvpn-install.sh && chmod +x openvpn-install.sh
wget http://autoscript.vpnstores.net/ipsec.sh && chmod +x ipsec.sh && ./ipsec.sh
wget http://autoscript.vpnstores.net/v2ray.sh && chmod +x v2ray.sh && ./v2ray.sh
wget http://autoscript.vpnstores.net/wg.sh && chmod +x wg.sh && ./wg.sh
wget http://autoscript.vpnstores.net/ssr.sh && chmod +x ssr.sh && ./ssr.sh
# Menginstall Fail2BAN / Multi Log Banned
apt -y install fail2ban



echo "SABAR MANG KEDENG DEUI GEHH ANGGES" >> /etc/crontab
chmod +x menu
chmod +x ss
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest-cli
chmod +x info
chmod +x about
chmod +x ram
chmod +x renew
chmod +x v2ray
