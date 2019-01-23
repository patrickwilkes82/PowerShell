#Import AD Module
Import-Module ActiveDirectory

#Set New User Information
$Username = 'tsavard'
$Password = 'thPUsYD#oH6L'
$FirstName = 'Timothy'
$LastName = 'Savard'
$Email = 'tsavard@miles-group.com'
$Title = 'Executive Assistant'
$Phone = '212-899-6930'
$Department = 'Ext 16930'
$Office = 'New York'
$Company = 'The Miles Group'
$OU = 'OU=The Miles Group,DC=sigma,DC=com'

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