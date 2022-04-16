$ErrorActionPreference = 'Stop'

$TimeZone = "UTC"
$TimeServer = "pool.ntp.org"
$DNSServer = "8.8.8.8"

Set-Service W32Time -StartupType Automatic
Start-Service W32Time
Set-TimeZone -Id $TimeZone

do {Write-Host "Checking for $DNSServer availability..."} until ((Test-NetConnection $DNSServer -Port 53 | Select-Object -ExpandProperty TcpTestSucceeded) -eq "True")

function Set-Time {
    $NTPIP = Resolve-DnsName $TimeServer -Server $DNSServer -ErrorAction SilentlyContinue | Select-Object -ExpandProperty IPAddress | Get-Random -Count 1
    Write-Host "$NTPIP selected for NTP server."
    Start-Process w32tm.exe -ArgumentList "/config /manualpeerlist:$NTPIP /syncfromflags:manual /reliable:yes /update" -Wait
    Start-Process w32tm.exe -ArgumentList "/resync" -Wait
}   
do {Set-Time} until (((Get-EventLog -LogName System | Where-Object InstanceID -eq 37 | Select-Object -ExpandProperty InstanceID -Unique) -eq 37))