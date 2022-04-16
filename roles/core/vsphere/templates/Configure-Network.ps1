$ErrorActionPreference = 'Stop'
Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "{{ ifname }}" -ErrorAction SilentlyContinue | Remove-NetIPAddress -Confirm:$false

{% if item.ipv4_gateway is defined %}
Get-NetRoute -AddressFamily IPv4 | Where-Object InterfaceAlias -NotLike *loopback* | Remove-NetRoute -Confirm:$false -ErrorAction SilentlyContinue
New-NetIPAddress -AddressFamily IPv4 -IPAddress "{{ item.ipv4 | ipaddr('address') }}" -InterfaceAlias "{{ ifname }}" -PrefixLength "{{ item.ipv4 | ipaddr('prefix') }}" -DefaultGateway "{{ item.ipv4_gateway }}"
{% else %}
New-NetIPAddress -AddressFamily IPv4 -IPAddress "{{ item.ipv4 | ipaddr('address') }}" -InterfaceAlias "{{ ifname }}" -PrefixLength "{{ item.ipv4 | ipaddr('prefix') }}"
{% endif %}
Set-DnsClientServerAddress -InterfaceAlias "{{ ifname }}" -ServerAddresses "{{ dns_servers | join('", "') }}"