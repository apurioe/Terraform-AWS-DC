###########################################################
# Name        : CreateDomain.ps1
# Author      : Rafa Bolivar
# Version     : 1.0
# Description : Script is used to Create Windows Domain.
###########################################################

$DCUSER = "Administrator"
$DCPASSWD ="!Servicenow22"
$DCPWSEC = $DCPASSWD | ConvertTo-SecureString -asPlainText -Force
$CREDENTIAL = New-Object System.Management.Automation.PSCredential($DCUSER,$DCPWSEC)

# Password Change
net user Administrator $DCPASSWD

# DC Create
#$username = \"Administrator\"
#$password = \"nutanix\/4u\" | ConvertTo-SecureString -asPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential($DCUSER,$DCPASSWD)
shutdown /r /f /d p:1:1 /t ([decimal]::round(((Get-Date).AddMinutes(4) - (Get-Date)).TotalSeconds)) /c "reboot"
install-windowsfeature -Name AD-Domain-Services -IncludeManagementTools
sleep(5)
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -DomainName "midominio.local" -DomainNetbiosName "MIDOMINIO" -ForestMode "Win2012R2" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$true -SysvolPath "C:\Windows\SYSVOL" -Confirm:$false -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "!Servicenow22" -Force) -Force:$true
sleep(10)
exit 0
