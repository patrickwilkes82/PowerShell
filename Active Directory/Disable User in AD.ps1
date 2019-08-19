#Import AD Module
Import-Module ActiveDirectory

# ***VARIABLES***
$Username = Read-Host 'Please enter name of user to be Disabled'
$Password = 'ZAQ!2wsxCDE#56'

###OLD###
<# try {
Set-ADUser -Identity $Username -Enabled $false
Set-ADUser $Username -Replace @{msExchHideFromAddressLists=$true}
Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
Write-Host "Request Completed" -ForegroundColor Green
}
catch {
    Write-Warning "Unable to complete request"
} #>
###END OF OLD###

###NEW###
Write-Host 'Disabling User Account' -ForegroundColor Yellow
Start-Sleep -Seconds 2
try {
    Set-ADUser -Identity $Username -Enabled $false
    Write-Host 'User Account Disabled Successfully' -ForegroundColor Green
}
catch {
    Write-Warning 'Could not Disable User Account'
}

Write-Host 'Removing User from Exchange Address Book' -ForegroundColor Yellow
Start-Sleep -Seconds 2
try {
    Set-ADUser $Username -Replace @{msExchHideFromAddressLists=$true}
    Write-Host 'User Has Been Removed Successfully' -ForegroundColor Green
}
catch {
    Write-Warning 'Could not Remove from Address Book'
}

Write-Host 'Resetting User Password' -ForegroundColor Yellow
Start-Sleep -Seconds 2
try {
    Set-ADAccountPassword -Identity $Username -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
    Write-Host 'Password Reset Successfully' -ForegroundColor Green
}
catch {
    Write-Warning 'Could not Reset Password'
}

Write-Host 'Removing from all AD Groups' -ForegroundColor Yellow
Start-Sleep -Seconds 2
try {
    Get-ADUser -Identity $Username -Properties MemberOf | ForEach-Object {
  $_.MemberOf | Remove-ADGroupMember -Members $_.DistinguishedName -Confirm:$false}
  Write-Host 'Removed from all AD Groups' -ForegroundColor Green
}
catch {
    Write-Warning 'Could not Remove from all AD Groups'
}

###END OF NEW###