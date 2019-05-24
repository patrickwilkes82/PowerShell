#Connect to Office 365
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Current date to add to filename
$date = Get-Date
#Date Format
$date = $date.ToString('MM-dd-yy')

#Export Settings
$filepath = 'C:\exports\'
$filename = 'Email_Forwarding_Rules_'
$export = $filepath,$filename,$date,'.csv' -join ''

#SMTP Email Settings
$PSEmailServer = 'smtp.office365.com'
$emailfrom = 'OnePath Admin <admin.onepath@g100companies.com>'
$emailto = 'Todd Mottern <tmottern@g100companies.com>'
$emailsubject = 'Current Email Forwarding Rules'
$emailbody = 'This is an automated message. Please find attached the current email forwarding rules as of', ' ', $date -join ''
$emailuser = 'admin.onepath@g100companies.com'
$emailpword = ConvertTo-SecureString -String 'Uzh2!2Bh!@R8T' -AsPlainText -Force
$emailcredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $emailuser, $emailpword


#Run Code
try {
Get-Mailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-csv $export -notypeinformation
Write-Host 'File Created Successfully' -ForegroundColor Green
}
catch {
    Write-Warning 'An Error Has Occurred'
}

try {
    Send-MailMessage -from $emailfrom -to $emailto -Subject $emailsubject -Body $emailbody -attachments $export -smtpserver $PSEmailServer -credential $emailcredential -usessl
    Write-Host 'Email Sent Successfully' -ForegroundColor Green
    }
catch {
    Write-Warning 'Email Unable to be Sent'
    }

Get-PSSession | Remove-PSSession  