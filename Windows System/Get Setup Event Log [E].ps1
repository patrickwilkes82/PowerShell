# ***VARIABLES
$log = 'Setup'
$filepath = 'C:\temp\' #Set Folder where export will be generated
$filename = $log, '_', $type, '_','log' -Join "" #Name of file of export without file extension type
$date = Get-Date #Current date to add to filename
$date = $date.ToString('MM-dd-yy') #Date format
$export = $filepath,  $filename, '_', $computer, '_', $date, '.csv' -Join "" #Full file path and name joined

# ***EXECUTE***
Get-WinEvent -LogName $log -ComputerName $computer | Select-Object TimeCreated, Id, LevelDisplayName, Message  | Export-Csv $export -notypeinformation