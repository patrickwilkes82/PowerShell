function Show-Menu
{
    param (
        [string]$Title = 'User to Manager Report'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' to get report for G100C"
    Write-Host "2: Press '2' to get report for G100N"
    Write-Host "3: Press '3' to get report for TMG"
    Write-Host "4: Press '4' to get report for SSA"
    Write-Host "5: Press '5' to get report for HLG"
    Write-Host "6: Press '6' to get report for Mentore"
    Write-Host "A: Press 'A' to get report for All Companies"
    Write-Host "Q: Press 'Q' to quit."
}
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {
             $company = 'G100C'
             $ou = 'OU=G100 Companies,DC=sigma,dc=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {$ignoresub -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation

         } '2' {
             $company = 'G100N'
             $ou = 'OU=G100 Employees,DC=sigma,dc=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {$ignoresub -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation

         } '3' {
             $company = 'TMG'
             $ou = 'OU=The Miles Group,DC=sigma,dc=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {$ignoresub -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Sort-Object Enabled |
             Export-csv $export -NoTypeInformation
         } '4' {
             $company = 'SSA'
             $ou = 'OU=Six Sigma Employees,DC=sigma,dc=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {$ignoresub -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation
         } '5' { 
             $company = 'HLG'
             $ou = 'OU=Highlantern Group Employees,DC=sigma,dc=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {($_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled') -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation
         } '6' {
             $company = 'Mentore'
             $ou = 'OU=Mentore,DC=sigma,DC=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             Get-ADUser -Filter * -SearchBase $ou -Properties Manager,Enabled |
             Where-Object {($_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled') -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation
         } 'A' {
             $company = 'All'
             $ous = 'OU=G100 Companies,DC=sigma,dc=com','OU=G100 Employees,DC=sigma,dc=com','OU=The Miles Group,DC=sigma,dc=com','OU=Six Sigma Employees,DC=sigma,dc=com','OU=Highlantern Group Employees,DC=sigma,dc=com','OU=Mentore,DC=sigma,DC=com'
             $filepath = 'c:\exports\'
             $export = $filepath, $company, '_', 'User-to-Manager.csv' -Join ""
             $enabled = {$_.Enabled -like 'true'}
             $ignoresub = {$_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled'}

             $ous | ForEach {Get-ADUser -Filter * -SearchBase $_ -Properties Manager,Enabled} |
             Where-Object {($_.DistinguishedName -notmatch 'ICs|Contractors|Shadow|Intern|Service|Disabled') -and $_.Enabled -like "True"} | 
             Select Name, SamAccountName,@{Name = "Manager";Expression = {%{(Get-ADUser $_.Manager -Properties DisplayName).DisplayName}}} |
             Export-csv $export -NoTypeInformation
         }
     }
     pause
 }
 until ($selection -eq 'q')