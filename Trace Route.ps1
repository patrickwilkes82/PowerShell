$IP = '68.15.183.45' #Enter IP of Destination - Variable
Test-NetConnection $IP -TraceRoute | Select -ExpandProperty TraceRoute | % { Resolve-DnsName $_ -type PTR -ErrorAction SilentlyContinue }