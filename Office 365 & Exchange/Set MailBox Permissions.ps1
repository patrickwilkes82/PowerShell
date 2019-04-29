#Connect to Office 365
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Variables
$mailbox = Read-Host 'Please Enter Email Address'
$user = Read-Host 'Enter Email Address of User Gaining Access to Mailbox'

#Run Code
try {
Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess
Write-Host '$user Granted FullAccess Permissions to Shared Mailbox $mailbox' -ForegroundColor Green
Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs
Write-Host '$user Granted SendAs Permission to Shared Mailbox $mailbox' -ForegroundColor Green
}
catch {
    Write-Host 'Error Occurred please check for any spelling errors' -ForegroundColor Red
}
Get-PSSession | Remove-PSSession
Write-Host 'PS Session Removed'
Pause