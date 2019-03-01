# ***Connect to Office 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic –AllowRedirection
Import-PSSession $Session


# ***Variables***
$SharedMailboxSMTP = 'xxx@xxx.com'
$SharedMailboxName = 'xxxxxxx'
$SharedMailboxDisplayName = $SharedMailboxName
$User = 'xxx@xxx.com'

# ***Create Shared Mailbox***
New-Mailbox -Shared -PrimarySMTPAddress $SharedMailboxSMTP -Name $SharedMailboxName -DisplayName $SharedMailboxDisplayName

# ***Wait 5 Seconds***
Start-Sleep -s 5

# ***Assign Full Access Permissions to User(s)***
Add-MailboxPermission -Identity $SharedMailboxSMTP -User $User -AccessRights FullAccess -InheritanceType All -AutoMapping:$true

# ***Wait 5 Seconds***
Start-Sleep -s 5


# ***Assign Send As Permissions to User(s)***
Add-RecipientPermission -Identity $SharedMailboxSMTP -Trustee $User -AccessRights SendAs