$ErrorActionPreference = 'Stop'
$interface = Get-NetIPAddress -AddressFamily IPv4 -IPAddress "10.80.69.69" | Select-Object -ExpandProperty InterfaceAlias
Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $interface | Remove-NetIPAddress -Confirm:$false
Get-NetRoute -AddressFamily IPv4 | Where-Object InterfaceAlias -NotLike *loopback* | Remove-NetRoute -Confirm:$false
New-NetIPAddress -AddressFamily IPv4 -IPAddress "{{ new_network.ipv4 | ipaddr('address') }}" -InterfaceAlias $interface -PrefixLength "{{ new_network.ipv4 | ipaddr('prefix') }}" -DefaultGateway "{{ new_network.ipv4_gateway }}"
Set-DnsClientServerAddress -InterfaceAlias $interface -ServerAddresses "{{ dns_servers[0] }}", "{{ dns_servers[1] }}"
