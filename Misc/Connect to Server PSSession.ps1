# Connect to SIGMAPSYNC Server

$server = '172.16.129.11'
$username = 'admin.onepath'

Write-Host 'Attempting to Connect to' $server -ForegroundColor Yellow
    try {
        Enter-PSSession -ComputerName $server -Credential $username
        Write-Host 'Connected to' $server -ForegroundColor Green
        #start-adsyncsyncycle -policytype delta
    }
    catch {
        Write-Host 'Unable to Connect to' $server -ForegroundColor Red
    }