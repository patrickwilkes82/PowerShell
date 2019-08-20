# --Connect to Office 365--

Write-Host "Attempting to Connect to Office 365" -ForegroundColor Yellow -BackgroundColor DarkGray
$Creds = Get-Credential "admin.onepath@g100companies.com"

try {
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session
Write-Host "Connected to Office 365" -ForegroundColor Green -BackgroundColor Gray
}
catch {
    Write-Host 'Unable to Connect to Office 365. Please Check for any Errors' -ForegroundColor Red -BackgroundColor DarkGray
    Pause
}

Write-Host "Ready to Continue"
Exit