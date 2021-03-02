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

#detail nama perusahaan
country=ID
state=Riau
locality=Bagansiapiapi
organization=wildyvpn.my.id
organizationalunit=wildyvpn.my.id
commonname=wildyvpn.my.id
email=admin@wildyvpn.my.id
Locate=Bagansiapiapi

#ROOT ADMIN
cd

# Ngedit File Di RC LOCAL
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

#Ngedit File RC LOCAL 2
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

#Mengizinkan Root Akses Dan Mengizinkan RC LOCAL SERVICE
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service

# Menghentikan IPV6 Karna Memakai IPV4 Saja
echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#Menginstall WEBMIN 
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

#update vps , install curl , hapus file ga kepakai dan setting waktu vps
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt -y install wget curl
apt -y autoremove
apt -y autoclean
apt -y clean
apt -y remove --purge unscd
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

#Menginstall Neofetch , Make , Git , GCC, Curl , BZIP , Unzip , Screen , CMAKE dan clear profile
apt -y install gcc
apt -y install make
apt -y install cmake
apt -y install git
apt -y install screen
apt -y install unzip
apt -y install curl
apt -y install zlib1g-dev
apt -y install bzip2
apt -y install neofetch
echo "clear" >> .profile
echo "neofetch" >> .profile

#Menginstall NGINX / Server Web Dan Ngeinstall Config VPS IP
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "http://autoscript.vpnstores.net/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup Modif By bhoikfost yahya</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "http://autoscript.vpnstores.net/vps.conf"
/etc/init.d/nginx restart

#Menginstall badvpn dan Configurasi Badvpn Client dan IP IPnya
cd
wget -O /usr/bin/badvpn-udpgw "http://autoscript.vpnstores.net/badvpn-udpgw64"
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000

#VPS IS CONNECTED TO SSH TO DROPBEAR & STUNELL..AHH NAON MEREN
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110 -p 109 -p 456"/g' /etc/default/dropbear
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2020.80.tar.bz2
bzip2 -cd dropbear-2020.80.tar.bz2 | tar xvf -
cd dropbear-2020.80
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear.old
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart
rm -f /root/dropbear-2020.80.tar.bz2
rm -rf /root/dropbear-2020.80

#install unzip
apt-get install unzip

#install squid3
cat > /etc/squid/squid.conf <<-END
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl SSL_ports port 443
acl Safe_ports port 88
acl Safe_ports port 1194
acl Safe_ports port 1195
acl Safe_ports port 1196
acl Safe_ports port 210
acl Safe_ports port 1200-65535
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/32
http_access allow SSH
http_access allow manager localhost
http_access deny manager
http_access allow localhost
http_access deny all
http_port 3128
http_port 8080
coredump_dir /var/spool/squid3
error_directory /usr/share/squid/errors/English
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
refresh_pattern . 0 20% 4320
visible_hostname Embex
END
sed -i $MYIP2 /etc/squid/squid.conf;
#Change Squid Page
cat > /usr/share/squid-langpack/en/ERR_INVALID_URL <<-END
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="%h SQUID PROXY" />
<title>Welcome to %h SQUID PROXY</title>
<script type="text/javascript">
function Redirect()
{
 window.location="http://facebook.com/";
}
setTimeout('Redirect()', 60);
</script>
<center>Thanks for visiting!<br><br>Loading please wait...</center><br><br>
<hr>
<div id="footer">
<p>SQUID PROXY Generated by %h on %T Embex</p>
<!-- %c -->
</div>
</body></html>
END
#Menginstall VN Stat Dan Config VNSTAT
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install 
cd
vnstat -u -i $NET
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz 
rm -rf /root/vnstat-2.6

#install webmin Terbaru
cd
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.910_all.deb
dpkg --install webmin_1.910_all.deb;
apt-get -y -f install;
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm -f webmin_1.910_all.deb
/etc/init.d/webmin restart

#install stunnel Port dan Stunnel 14
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 127.0.0.1:109

[openvpn]
accept = 442
connect = 127.0.0.1:1196

END

#CRATE certificate VPS
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

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

#Instal DDOS Secure
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "DELL FILE ALLOW"
	exit 0
else
	mkdir /usr/local/ddos
fi
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
