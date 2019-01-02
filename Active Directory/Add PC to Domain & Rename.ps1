# ***VARIABLES***
$sn = Get-WmiObject win32_bios | Select-Object -Expand serialnumber
$domain = 'sigma.com'
$company = 'ssa'
$name = '' #Only used for remote computers
$newname = $sn, '-', $company -Join ''

# ***EXECUTION***
Add-Computer -DomainName $domain -ComputerName $name -NewName $newname