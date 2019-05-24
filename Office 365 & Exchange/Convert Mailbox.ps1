# ***Connect to Office 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic –AllowRedirection
Import-PSSession $Session

# ***VARIABLES***
$mailbox = Read-Host 'Enter Mailbox to be Converted' #Mailbox being converted
$type = Read-Host 'Enter Type of Mailbox to Convert too' #Type of mailbox desired [Regular, Shared, Room, Equipment]

try 
{
        Set-Mailbox $mailbox -Type $type -ErrorAction Stop
        Write-Host "Successfully converted $mailbox to $type Mailbox" -ForegroundColor Green
}
catch 
{
    Write-Host "Unable to convert $mailbox to $type Mailbox. Please check for any spelling errors." -ForegroundColor Yellow
}

# ***Verify Mailbox Type
Start-Sleep -s 10
Get-Mailbox -Identity $mailbox | Format-List RecipientTypeDetails

Get-PSSession | Remove-PSSession