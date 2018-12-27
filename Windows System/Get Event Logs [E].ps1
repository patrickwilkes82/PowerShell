# ***VARIABLES*** 
$log = 'Setup' #Windows Log [Use 'Get-Event Log -list' to see all possible logs]
$type = 'Information' #Log Type [Error, Warning, Information]
$computer = 'SurfacePro6_PW' #Name of Computer
$filepath = 'C:\temp\' #Set Folder where export will be generated
$filename = $log, '_', $type, '_','log' -Join "" #Name of file of export without file extension type
$date = Get-Date #Current date to add to filename
$date = $date.ToString('MM-dd-yy') #Date format
$export = $filepath,  $filename, '_', $computer, '_', $date, '.csv' -Join "" #Full file path and name joined

# ***EXECUTE*** 
Get-EventLog -LogName $log -EntryType $type -ComputerName $computer | Export-Csv $export -notypeinformation