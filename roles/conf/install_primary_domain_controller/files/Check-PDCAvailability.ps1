do {Start-Sleep -Seconds 30} until ((Get-EventLog -LogName 'DNS Server' | Where-Object InstanceID -EQ 4500 | Select-Object -ExpandProperty InstanceID -Unique) -eq 4500)
