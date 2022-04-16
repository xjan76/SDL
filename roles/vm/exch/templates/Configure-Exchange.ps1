$ErrorActionPreference = 'Stop'

Add-PSSnapin Microsoft.Exch*
$ExternalDomain = "{{ ad_domain_name }}"
$ExchangeServer = Get-ExchangeServer | Select-Object -ExpandProperty Fqdn
$exch = "{{ parent_hostname }}"
$FQDN= $exch + "." + $ExternalDomain 
New-SendConnector -SourceTransportServers $ExchangeServer -Internet -AddressSpaces * -Fqdn $FQDN -Name SC -Force

Write-Host "Sleeping for 30 seconds..." -ForegroundColor Cyan
Start-Sleep -Seconds 30

if ((Get-AcceptedDomain | Where-Object DomainName -Like $ExternalDomain | Select-Object -ExpandProperty DomainName | Select-Object -ExpandProperty Domain) -ne $ExternalDomain ) {

    New-AcceptedDomain -Name $ExternalDomain -DomainName $ExternalDomain -DomainType Authoritative
    Set-AcceptedDomain -Identity $ExternalDomain -MakeDefault $true

}

