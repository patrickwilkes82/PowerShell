#Import AD Module
Import-Module ActiveDirectory

#Set New User Information
$Username = 'kmuhota'
$Password = '3gc#6nuQNdss'
$FirstName = 'Kim'
$LastName = 'Muhota'
$Email = 'kmuhota@ssaandco.com'
$Title = 'Senior Director'
$Phone = '703-655-7561'
$Office = 'Remote'
$Company = 'SSA & Company'
$OU = 'OU=Six Sigma Employees,DC=sigma,DC=com'

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