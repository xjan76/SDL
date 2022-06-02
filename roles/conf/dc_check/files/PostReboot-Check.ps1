$Date= Get-CimInstance -ClassName win32_operatingsystem | select-object -ExpandProperty lastbootuptime

do {Start-Sleep -Seconds 10} until ((Get-EventLog -LogName 'Active Directory Web Services' -after $Date | Where-Object InstanceID -EQ 1073743024 | Select-Object -ExpandProperty InstanceID -Unique) -eq 1073743024)