
Write-Host 'Connecting to Office 365 Session'
$Creds = Get-Credential "admin.onepath@g100companies.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $Creds -Authentication Basic -AllowRedirection
Import-PSSession $Session

Write-Host 'Getting List of Office 365 Groups' -ForegroundColor Yellow
$Groups = Get-UnifiedGroup | select -ExpandProperty Displayname | Sort-Object DisplayName
Start-Sleep -Seconds 2
Write-Host 'Getting List of Office 365 Distribution Lists' -ForegroundColor Yellow
$dGroups = Get-DistributionGroup | select -ExpandProperty Displayname | Sort-Object DisplayName
Start-Sleep -Seconds 2
$User = Read-Host 'Enter Mailbox being Removed from Groups'
$dUser = (Get-Mailbox $User).distinguishedname

foreach($Group in $Groups) 
{
    Write-Host 'Attempting to remove user:' $User 'from' $Group -ForegroundColor Cyan
    Remove-UnifiedGroupLinks -Identity $group -LinkType Members -Links $User -Confirm:$false -ErrorAction SilentlyContinue
}

foreach ($dGroup in $dGroups)
{
    Write-Host 'Attempting to remove user:' $User 'from' $dGroup -ForegroundColor Cyan
    Remove-DistributionGroupMember -Identity $dGroup.Identity -Member $User -Confirm:$false -ErrorAction SilentlyContinue
}

Get-PSSession | Remove-PSSession