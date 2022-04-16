$ErrorActionPreference = 'Stop'
Set-DnsClientServerAddress -ResetServerAddresses -InterfaceAlias *
Set-DnsClientServerAddress -InterfaceAlias "{{ ansible_facts.interfaces[0].connection_name }}" -ServerAddresses "{{ dns_servers | join('", "') }}"

