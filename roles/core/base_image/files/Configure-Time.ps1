$Zone = "UTC"
$Server = "pool.ntp.org"
$DNS = "8.8.8.8"

Set-Service W32Time -StartupType Automatic
Start-Service W32Time
Set-TimeZone -Id $Zone

$ntp = Resolve-DnsName $Server -Server $DNS -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress | Get-Random -Count 1
Start-Process w32tm.exe -ArgumentList "/config /manualpeerlist:$ntp /syncfromflags:manual /reliable:yes /update" -Wait
Start-Process w32tm.exe -ArgumentList "/resync" -Wait