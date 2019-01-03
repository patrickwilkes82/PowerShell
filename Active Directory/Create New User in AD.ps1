#Import AD Module
Import-Module ActiveDirectory

#Set New User Information
$Username = 'sweiss'
$Password = '9#VSLoX^!sq^'
$FirstName = 'Shari'
$LastName = 'Weiss'
$Email = 'sweiss@g100.com'
$Title = 'Business Development Coordinator'
$Phone = '212-899-6830'
$Department = 'Ext 16830'
$Office = 'NY'
$Company = 'G100 Network'
$OU = 'OU=G100 Employees,DC=sigma,DC=com'

if (Get-ADUser -F {SamAccountName -eq $UserName})
{
    Write-Warning "User Account $Username already exists in Active Directory."
}
else
{
    New-ADUser `
    -SamAccountName $Username `
    -Name "$FirstName $LastName" `
    -GivenName $FirstName `
    -Surname $LastName `
    -DisplayName "$FirstName $LastName" `
    -UserPrincipalName $Email `
    -EmailAddress $Email `
    -OfficePhone $Phone `
    -Title $Title `
    -Description $Title `
    -Office $Office `
    -Department $Department `
    -Company $Company `
    -PasswordNeverExpires $true `
    -Enabled $true `
    -Path $OU `
    -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
}