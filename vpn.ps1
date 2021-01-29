$ServerAddress = "38.32.20.242"
$ConnectionName = "G1H VPN"
$PSK = "G100Companies2015!"

Add-VpnConnection -Name "$ConnectionName" -ServerAddress "$ServerAddress" -TunnelType L2tp -L2tpPsk "$PSK" -AuthenticationMethod Pap -AllUserConnection -RememberCredential -Force
