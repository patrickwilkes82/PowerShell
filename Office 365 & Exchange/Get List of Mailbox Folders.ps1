# ***CONNECT TO OFFICE 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic –AllowRedirection
Import-PSSession $Session

# ***VARIABLES***
$mailbox = 'lbergamini@g100companies.com'
$filepath = 'C:\temp\'
$export = $filepath,  $mailbox, '_', 'Folder', '_', 'List', '.csv' -Join "" #Full file path and name joined

# ***EXECUTE***
Get-MailboxFolderStatistics -Identity lbergamini@g100companies.com | Export-Csv "C:\temp\DeeHoudekFolders2.csv"