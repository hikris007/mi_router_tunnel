tun:
/etc/openvpn/up.sh tun0 1500 1552 10.8.0.2 255.255.255.0 init
/etc/openvpn/down.sh tun0 1500 1552 10.8.0.2 255.255.255.0 init

tap:
/etc/openvpn/up.sh tap0 1500 1584 10.8.0.2 255.255.255.0 init
/etc/openvpn/down.sh tap0 1500 1584 10.8.0.2 255.255.255.0 init

$0 /etc/openvpn/up.sh
$1 tap0
$2 1500
$3 1584
$4 10.8.0.2
$5 255.255.255.0
$6 init