# --VARIABLES--
$O365Creds = Get-Credential "admin.onepath@g100companies.com"
$user = Read-Host "Enter Username"
$mailbox = Read-Host "Enter Email Address"

# --Connect to Office 365--

Write-Host "Attempting to Connect to Office 365" -ForegroundColor Yellow -BackgroundColor DarkGray


try {
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $O365Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session
Write-Host "Connected to Office 365" -ForegroundColor Green -BackgroundColor Gray
}
catch {
    Write-Host 'Unable to Connect to Office 365' -ForegroundColor Red -BackgroundColor DarkGray
}

Pause
Exit