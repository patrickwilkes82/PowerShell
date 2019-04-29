#Connect to Office 365
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Variables
$mailbox = Read-Host 'Please Enter New Email Address'
$name = Read-Host 'Please Enter Display Name of Mailbox'
$user = Read-Host 'Enter Email Address of User Gaining Access to Mailbox'

#Run Code
try {
New-Mailbox -Shared -Name $name -DisplayName $name -PrimarySmtpAddress $mailbox
Write-Host 'Shared Mailbox $mailbox Created Successfully'
Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess
Write-Host '$user Granted FullAccess Permissions to Shared Mailbox $mailbox'
Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs
Write-Host '$user Granted SendAs Permission to Shared Mailbox $mailbox'
}
catch {
    Write-Host 'Error Occurred please check for any spelling errors'
}
Get-PSSession | Remove-PSSession
Write-Host 'PS Session Removed'
Pause