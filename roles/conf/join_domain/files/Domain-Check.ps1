$ErrorActionPreference = "Stop"
$domaininformation = (Get-WmiObject win32_computersystem).partofdomain
if ($domaininformation -eq $true) {
    if (((Get-ComputerInfo).OsProductType) -eq "WorkStation") {
        Restart-Service Netlogon
    }
    Test-ComputerSecureChannel
    
} else {   
    Write-Host "Something went wrong"
}
