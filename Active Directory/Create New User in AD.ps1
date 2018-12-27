#Import AD Module
Import-Module ActiveDirectory

#Set New User Information
$Username = 'vtopouria'
$Password = 'xyDqlQH3K@d3'
$FirstName = 'Victor'
$LastName = 'Topouria'
$Email = 'vtopouria@highlanterngroup.com'
$Title = 'Strategy & Communications Intern'
$Phone = '323-300-8327'
$Office = 'LA'
$Company = 'High Lantern Group'
$OU = 'OU=HLG Contractors,OU=Highlantern Group Employees,DC=sigma,DC=com'

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
    -Company $Company `
    -PasswordNeverExpires $true `
    -Enabled $true `
    -Path $OU `
    -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
}