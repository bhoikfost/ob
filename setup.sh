#!/bin/bash
#Script Remake By BHOIKFOST YAHYA
#======================================================

# Install Var Script / Host IP
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
echo "domain sia asupkn"
read -p "Hostname :" host
echo "IP=$host" >> /root/ipvps.conf
MYIP=$(dig @resolver1.opendns.com -t A -4 myip.opendns.com +short)
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID


#Configurasi Stunnel VPN
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

#Configurasi OpenVPN & Wireguard & SSR & L2TP & Dan V2RAY
wget https://github.com/Nyr/openvpn-install/blob/master/openvpn-install.sh && chmod +x openvpn-install.sh
wget http://autoscript.vpnstores.net/ipsec.sh && chmod +x ipsec.sh && ./ipsec.sh
wget http://autoscript.vpnstores.net/v2ray.sh && chmod +x v2ray.sh && ./v2ray.sh
wget http://autoscript.vpnstores.net/wg.sh && chmod +x wg.sh && ./wg.sh
wget http://autoscript.vpnstores.net/ssr.sh && chmod +x ssr.sh && ./ssr.sh
#Menginstall Fail2BAN / Multi Log Banned
apt -y install fail2ban

clear
echo; echo 'HARAP SEDUH KOPI DAN NYALAIN ROKO'; echo
echo; echo -n 'DOWNLOAD CONNECTED ~ BHOIKFOST YAHYA'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...Telah Siap Download'
echo; echo -n 'Buat Cron Script Secara Default (Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Install Berhasil.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'ISS Jadi Sayang Ini'
#Menginstall Parser XML
cd
apt install -y libxml-parser-perl
#Banner VPN
wget -O /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

#DOWNLOAD FILE BADAGGGGGGGG
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
apt install speedtest-cli -y
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
#DONEIS KEDENG HELAAA OKAY...........
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/mulai.sh
#Menginstall V2RAY
v2ray
#DONE V2RAY IS OKAY !
clear
neofetch
echo ""  | tee -a log-install.txt
echo "______ _   _ _____ _____ _   ________ _____ _____ _______   _____   _   ___   _____   | tee -a log-install.txt
echo "| ___ \ | | |  _  |_   _| | / /|  ___|  _  /  ___|_   _\ \ / / _ \ | | | \ \ / / _ \  | tee -a log-install.txt
echo "| |_/ / |_| | | | | | | | |/ / | |_  | | | \ `--.  | |  \ V / /_\ \| |_| |\ V / /_\ \ | tee -a log-install.txt
echo "| ___ \  _  | | | | | | |    \ |  _| | | | |`--. \ | |   \ /|  _  ||  _  | \ /|  _  | | tee -a log-install.txt
echo "| |_/ / | | \ \_/ /_| |_| |\  \| |   \ \_/ /\__/ / | |   | || | | || | | | | || | | | | tee -a log-install.txt
echo "\____/\_| |_/\___/ \___/\_| \_/\_|    \___/\____/  \_/   \_/\_| |_/\_| |_/ \_/\_| |_/ | tee -a log-install.txt
echo "*=====================================================================================" | tee -a log-install.txt
echo "*=====================================================================================" | tee -a log-install.txt
echo "          GRUP VPN COLAB FOR NET           " | tee log-install.txt
echo "*================================== BHOIKFOST YAHYA ==================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ">> Service"  | tee -a log-install.txt
echo "*================================== BHOIKFOST YAHYA ==================================" | tee -a log-install.txt
echo "OpenSSH          : 22 "  | tee -a log-install.txt
echo "Dropbear         : 88"  | tee -a log-install.txt
echo "OpenVPN          : TCP 1194 (http://$MYIP:81/client-tcp-1194.ovpn)"  | tee -a log-install.txt
echo "OpenVPN          : UDP 1195 (http://$MYIP:81/client-udp-1195.ovpn)"  | tee -a log-install.txt
echo "OpenVPN          : SSL 1196 (http://$MYIP:81/client-tcp-1196.ovpn)"  | tee -a log-install.txt
echo "SSL/TLS          : 443"  | tee -a log-install.txt
echo "Badvpn           : badvpn-udpgw port 7100 7200 7300"  | tee -a log-install.txt
echo "Squid            : 8080 3128 (Limited IP)"  | tee -a log-install.txt
echo "Wireguard        : 6969"  | tee -a log-install.txt
echo "L2TP/IPSEC       : 1723"  | tee -a log-install.txt
echo "*====================================== BHOIKFOST YAHYA ==============================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ">> Fitur lain"  | tee -a log-install.txt
echo "*====================================== BHOIKFOST YAHYA ==============================================" | tee -a log-install.txt
echo "Webmin           : http://$MYIP:10000/"  | tee -a log-install.txt
echo "Timezone         : Asia/Jakarta"  | tee -a log-install.txt
echo "Fail2Ban         : [on]"  | tee -a log-install.txt
echo "IPv6             : [on]"  | tee -a log-install.txt
echo "========================================= colab for net ===============================================" | tee -a log-install.txt
echo ">> Script Modified By BHOIKFOST YAHYA"  | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□ DAMEL SSH & OVPN ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ | tee -a log-install.txt
echo "* usernew       : Membuat Akun SSH & OpenVPN" | tee -a log-install.txt
echo "* trial         : Membuat Akun Trial SSH & OpenVPN" | tee -a log-install.txt
echo "* hapus         : Menghapus Akun SSH & OpenVPN" | tee -a log-install.txt
echo "* renew         : Memperpanjang Masa Aktif Akun SSH & OpenVPN" | tee -a log-install.txt
echo "* cek           : Cek User Login" | tee -a log-install.txt
echo "* member        : Daftar Member SSH & OpenVPN" | tee -a log-install.txt
echo "* delete        : Menghapus Akun Expired User Expired" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ DAMEL WIREGUARD ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□" | tee -a log-install.txt
echo "* wgadd         : Generate Akun Wireguard" | tee -a log-install.txt
echo "* wgtrial       : Generate Akun Trial wireguard" | tee -a log-install.txt
echo "* wghapus       : Menghapus Akun Wireguard" | tee -a log-install.txt
echo "* wg show       : Cek User Interface Wireguard" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ DAMEL VPN BAWAAN PPTP ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□□■□■□" | tee -a log-install.txt
echo "* pptp          : Menambah User PPTP VPN" | tee -a log-install.txt
echo "* addpptp       : Menambah User PPTP VPN" | tee -a log-install.txt
echo "* trialpptp     : Menambah User Trial PPTP VPN" | tee -a log-install.txt
echo "* delpptp       : Menhapus User PPTP VPN" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ DAMEL VPN BAWAAN L2TP ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■■□■□" | tee -a log-install.txt
echo "* addvpn        : Membuat Akun L2TP/IPSEC" | tee -a log-install.txt
echo "* trialvpn      : Generate Akun Trial L2TP/IPSEC" | tee -a log-install.txt
echo "* delvpn        : Menghapus Akun L2TP/IPSEC" | tee -a log-install.txt
echo "* cekvpn        : Cek User Interface L2TP/IPSEC" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ VPN SSR ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■■□■□■□■□□■■□■□■□■□" | tee -a log-install.txt
echo "* ssradd        : Tampilkan Menu Pembuatan SSR" | tee -a log-install.txt
echo "* ssrdel        : Hapus akun SSR" | tee -a log-install.txt
echo "* ssr           : Melihat pengguna SSR" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ VPN V2RAY/VMESS ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□" | tee -a log-install.txt
echo "* addv2ray      : crate User V2RAY " | tee -a log-install.txt
echo "* delv2ray      : deleting User V2RAY" | tee -a log-install.txt
echo "* v2ray add     : crate v2ray websocket tls port 80 untuk edu/opok" | tee -a log-install.txt
echo "*UNTUK V2RAY PORT 80 SILAHKAN GANTI SQUID OROXY MENJADI 8888/8880 DAN TULIS LANGSUNG (V2RAY ADD)" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ ADMIN SYSTEM VPS ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□□" | tee -a log-install.txt
echo "* ram           : Melihat Penggunaan Ram VPS" | tee -a log-install.txt
echo "* speedtest-cli : Speedtest VPS" | tee -a log-install.txt
echo "* info          : Menampilkan Spek Dan Info System" | tee -a log-install.txt
echo "* about         : Informasi Script Auto Install" | tee -a log-install.txt
echo "* vnstat        : Menampilkan Penggunaan Jaringan VPS" | tee -a log-install.txt
echo "■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ BHOIKFOST YAHYA ■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□■■□■□■□■□ | tee -a log-install.txt
echo "* exit          : Keluar Dari VPS Server" | tee -a log-install.txt
echo "* reboot        : Mereboot Seluruh VPS" | tee -a log-install.txt
echo "* restart        : Merestart Port Dan Sertice" | tee -a log-install.txt
echo "*========================================== BHOIKFOST YAHYA ============================================= | tee -a log-install.txt
echo "                                        HATUR NUHUN KA SADAYANA                    
echo "=========================================== BHOIKFOST YAHYA ============================================== | tee -a log-install.txt
echo "*"
echo "SILAHKAN REBOOT TERLEBIH DAHULU......!"
