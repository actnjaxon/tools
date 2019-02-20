#Creates a VPN connector compatible with Meraki Firewall's L2TP/IPSec client VPN
#This script only works with Windows 8.1 and 10, it has hooks into APIs that aren't available to powershell installs on other OS's
#
#Update the Viarables with the correct values and run. I may update this to a function format eventually.

$ConnName = "VPN Name"
$SrvAddr = "IP Address or FQDN"
$PSK = "Secure Pre-Shared Key"
$DNS = "DNS Search Suffix"

Add-VpnConnection -Name $ConnName -ServerAddress $SrvAddr -TunnelType "L2tp" -EncryptionLevel "Optional" -AuthenticationMethod PAP -AllUserConnection -L2tpPsk $PSK -DnsSuffix $DNS -force
