###NOTE: This Script Must Be Run in PowerShell as an Administrator with Elevated Privileges###

$key = 'HKCU:\Software\Microsoft\MSOIdentityCRL'
$keyexport = 'HKCU\Software\Microsoft'
$fileoutput = 'C:\Temp\Registry_Backup.reg'

#Set Execution Policy
try {
Set-ExecutionPolicy unrestricted
}
catch {
Write-Host 'Unable to Change Execution Policy, please run script with elevated privileges!' -ForegroundColor Red
Write-Host 'Exiting Script' -ForegroundColor DarkYellow
pause
exit
}

#Stop Skype for Business
Write-Host 'Closing Skype for Business...' -ForegroundColor Yellow
Stop-Process -Name 'lync'

#Check if Registry Key is on Device
Write-Host 'Checking status of Registry Key' -ForegroundColor Yellow
Start-Sleep -Seconds 2

if (Get-Item -Path $key -ErrorAction SilentlyContinue) {
    #Backup Registry Key
    Write-Host 'Key is Present on Device' -ForegroundColor Green
    Start-Sleep -seconds 1
    Write-Host 'Attempting to Backup Registry Key...' -ForegroundColor Yellow

    try {
        Reg Export $keyexport $fileoutput /y > c:\temp\log.txt
        Start-Sleep -Seconds 2
        Write-Host 'Registry Key Backed Up Successfully To' $fileoutput -ForegroundColor Green
        start-sleep -seconds 2
    }
    catch {
        Write-Host 'An Error Occurred While Trying to Backup Registry Key, Exiting Script' -ForegroundColor Red
        pause
        exit
    }

    #Remove Registry Key
    Write-Host 'Attempting to Delete Registry Key...' -ForegroundColor Yellow
    start-sleep -seconds 2

    try {
        Remove-Item -Path $key -Recurse
        Write-Host 'Key has been Deleted Successfully' -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    catch {
        Write-Host 'An Error Occurred While Trying to Delete Registry Key, Exiting Script' -ForegroundColor Red
        pause
        exit
    }
    #Restarting Skype for Business App
    Write-Host 'Restarting Skype for Business...' -ForegroundColor Yellow
    try {
        Start-Sleep -Seconds 2
        Start-Process 'lync' 
    }
    catch {
        Write-Host 'Unable to Restart Skype for Business' -ForegroundColor Red
    }

}
else {
    Write-Host 'Key is not found on Device. Please Double Check Path' -ForegroundColor Red 
    pause
}

