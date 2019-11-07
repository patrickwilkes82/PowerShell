# ***Connect to Office 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

# ***Variables***
$csv = 'C:\Users\admin.onepath\Desktop\PowerShell\Office 365 & Exchange\csv\TMG Calendars.csv'
$user = 'ttayob@miles-group.com'
$rights = 'Editor'

# ***EXECUTE***
Import-Csv $csv | foreach {Add-MailboxFolderPermission -Identity $_.alias -User $user -AccessRights $rights}