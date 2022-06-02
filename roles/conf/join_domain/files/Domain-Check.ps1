$domainstatus = (Get-WmiObject win32_computersystem).partofdomain
if ($domainstatus -eq $true){ Test-ComputerSecureChannel} 
else {write-host "not domain joined"}