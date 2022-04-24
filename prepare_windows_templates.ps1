[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

reg add HKLM\Software\OpenSSH /v DefaultShell /t REG_SZ /d C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

C:\ProgramData\chocolatey\choco.exe install openssh -params /SSHServerFeature -y

New-LocalUser INSERT_USERNAME -Password (ConvertTo-SecureString INSERT_PASSWORD -AsPlainText -force) -FullName INSERT_USERNAME
Add-LocalGroupMember -Group Administrators -Member sdl

Set-Service wuauserv -StartupType Disabled