Import-Module ActiveDirectory #Required Module to access AD 
$user ='admin.onepath' #AD Username Variable
Set-ADUser $user -Replace @{msExchHideFromAddressLists=$true} #SET $true to hide from list or $false to show in list