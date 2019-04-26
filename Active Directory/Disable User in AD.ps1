#Import AD Module
Import-Module ActiveDirectory

# ***VARIABLES***
$Username = 'pramprasad'
$Password = 'ZAQ!2wsxCDE#56'

try {
Set-ADUser -Identity $Username -Enabled $false
Set-ADUser $Username -Replace @{msExchHideFromAddressLists=$true}
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
Write-Host "Request Completed" -ForegroundColor Green
}
catch {
    Write-Warning "Unable to complete request"
}