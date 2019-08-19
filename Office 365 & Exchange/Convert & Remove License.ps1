###Connect to Office 365###
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session
Import-Module MSOnline
Connect-MsolService -credential $Creds

###VARIABLES###
$mailbox = Read-Host 'Enter Email Address'
$type = Read-Host 'Enter Type of Mailbox to Convert too' #Type of mailbox desired [Regular, Shared, Room, Equipment]

###CONVERT MAILBOX###
Write-Host 'Converting' $mailbox 'to' $type 'Mailbox' -ForegroundColor Yellow
try 
{
        Set-Mailbox $mailbox -Type $type -ErrorAction Stop
        Write-Host "Successfully converted $mailbox to $type Mailbox" -ForegroundColor Green
}
catch 
{
    Write-Warning "Unable to convert $mailbox to $type Mailbox. Please check for any spelling errors."
}

# ***Verify Mailbox Type
Start-Sleep -s 10
Get-Mailbox -Identity $mailbox | Format-List RecipientTypeDetails
###END CONVERT MAILBOX###

###REMOVE LICENSES###
Write-Host 'Removing Office 365 Licenses for' $mailbox -ForegroundColor Yellow
Start-Sleep -s 2
try {
    (Get-MsolUser -UserPrincipalName $mailbox -ErrorAction Stop ).licenses.AccountSkuID |
    ForEach-Object {
        Set-MsolUserLicense -UserPrincipalName $mailbox -RemoveLicenses $_
        Set-MsolUser -UserPrincipalName $mailbox -BlockCredential $true
        Write-Host "Successfully removed licenses from $mailbox mailbox." -ForegroundColor Green
    }
}
catch {
    Write-Warning "Unable to remove license from $mailbox mailbox."
} 

# ***Verify licenses have been Removed and sign in blocked***
Get-MsolUser -UserPrincipalName $mailbox | Format-List DisplayName,Licenses
###END REMOVE LICENSE###

###CLEAR PS SESSION###
Get-PSSession | Remove-PSSession