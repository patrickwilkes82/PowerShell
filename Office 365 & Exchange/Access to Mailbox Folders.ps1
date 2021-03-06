# ***CONNECT TO OFFICE 365***
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

# ***VARIABLES
$mailbox = 'tgriffin@miles-group.com:\Contacts' #Email address of user mailbox [Add ':\Calendar' or ':\Contacts' to grant access to specific mailbox folders]
$user = 'tsavard@miles-group.com' #Email of users mailbox being granted access 
$rights = 'Editor' #Permissions to folder [FullAccess, Editor, ReadOnly, etc...]

# ***GET Current Permissions to mailbox
Get-MailboxFolderPermission -Identity $mailbox -user $user

# ***ADD Permissions if none exists***
Add-MailboxFolderPermission -Identity $mailbox -user $user -AccessRights $rights 

# ***SET Permissions if other permission already exists***
Set-MailboxFolderPermission -Identity $mailbox -user $user -AccessRights $rights -SharingPermissionFlags Delegate


# ***DELETE Permissions to mailbox***
Remove-MailboxFolderPermission -Identity $mailbox -user $user 


# ***SET Email Forwarding***
Set-Mailbox -Identity $mailbox -ForwardingAddress $user
