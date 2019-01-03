# ***Connect to Office 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic –AllowRedirection
Import-PSSession $Session

Connect-MsolService

# ***VARIABLES***
$mailbox = 'pfincher@highlanterngroup.com'

try {
    (Get-MsolUser -UserPrincipalName $mailbox -ErrorAction Stop ).licenses.AccountSkuID |
    ForEach-Object {
        Set-MsolUserLicense -UserPrincipalName $mailbox -RemoveLicenses $_
        Write-Host "Successfully removed licenses from $mailbox mailbox." -ForegroundColor Green
    }
}
catch {
    Write-Host "Unable to remove license from $mailbox mailbox." -ForegroundColor Yellow
} 
