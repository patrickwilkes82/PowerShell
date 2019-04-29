#Connect to Office 365
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Variables
$mailbox = Read-Host 'Please Enter Source Email Address'
$user = Read-Host 'Enter Email Address to receive Forwarded Messages'

#Run Code
try {
Set-Mailbox -Identity $mailbox -DeliverToMailboxAndForward $true -ForwardingSMTPAddress $user
}
catch {
    Write-Warning 'An Error Occurred. Please check for any mispellings.'
}

Start-Sleep -s 5

#Verify Code
Get-Mailbox $mailbox | Format-List ForwardingSMTPAddress,DeliverToMailboxandForward

#Close PS Session
Get-PSSession | Remove-PSSession

