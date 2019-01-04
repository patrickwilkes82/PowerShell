# ***Connect to Office 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic –AllowRedirection
Import-PSSession $Session

Connect-MsolService

# ***VARIABLES***
$mailbox = 'akohler@ssaandco.com'

# ***Execute***

try {
    (Get-MsolUser -UserPrincipalName $mailbox -ErrorAction Stop ).licenses.AccountSkuID |
    ForEach-Object {
        Set-MsolUserLicense -UserPrincipalName $mailbox -RemoveLicenses $_
        Set-MsolUser -UserPrincipalName $mailbox -BlockCredential $true
        Write-Host "Successfully removed licenses from $mailbox mailbox." -ForegroundColor Green
    }
}
catch {
    Write-Host "Unable to remove license from $mailbox mailbox." -ForegroundColor Yellow
} 

# ***Verify licenses have been Removed and sign in blocked***
Get-MsolUser -UserPrincipalName $mailbox | Format-List DisplayName,Licenses