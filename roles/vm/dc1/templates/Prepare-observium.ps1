New-ADUser -Name "observium.bind" -Description "Observium LDAP Bind" -AccountPassword (ConvertTo-SecureString "Password.123" -AsPlainText -Force) -ChangePasswordAtLogon:$false -PasswordNeverExpires:$true -Enabled:$true
New-ADGroup -name "Observium Admins" -GroupScope DomainLocal -GroupCategory Security
Add-ADGroupMember -Identity "Observium Admins" -Members "observium.bind"