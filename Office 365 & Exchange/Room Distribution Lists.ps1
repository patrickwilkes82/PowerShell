#Connect to Office 365
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Variables
$roomList = 'NYRoomList'
$newRoom = 'nylactationroom@g100companies.com'

#Get current list of rooms in room list
Get-DistributionGroupMember -Identity $roomList

#Add room to room list
Add-DistributionGroupMember -Identity $roomList -Member $newRoom