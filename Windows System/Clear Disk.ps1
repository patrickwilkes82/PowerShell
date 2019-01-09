#HELP: https://docs.microsoft.com/en-us/powershell/module/storage/clear-disk?view=win10-ps

# ***Get List of all Disks on local machine***
Get-Disk

# ***Get List of Disks that are not System Disks***
Get-Disk | Where-Object IsSystem -eq $False

# ***Get List of Offline Disks***
Get-Disk | Where-Object IsOffline –eq $True

____________________________________________________________________

# ***Set Disk Number from List as Variable***
$disk = Read-Host 'Select Disk Number'

____________________________________________________________________

# ***Clear Disk with no data***
Clear-Disk -Number $disk

# ***Clear Disk with Data but no OEM***
Clear-Disk -Number $disk -RemoveData

# ***Clear Disk with Data & OEM***
Clear-Disk -Number $disk -RemoveData -RemoveOEM

