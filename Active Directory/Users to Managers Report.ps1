$OUAll = 'DC=sigma,dc=com'
$OUG100C = 'OU=G100 Companies,DC=sigma,dc=com'
$ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}


Get-ADUser -Filter * -SearchBase $OUAll -Properties Manager |
Where-Object $ignoresub | 
Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}}, Enabled |
Sort-Object Enabled |
Export-csv 'C:\exports\G100C_Users&Managers.csv' -NoTypeInformation