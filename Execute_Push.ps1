#-------------------------------------------------------
#specify remote device details
$s1 = "SERVER1"
$creds = Get-Credential -Message "Enter Credentials"
#-------------------------------------------------------
#create remote sessions
#$so = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
#$session = New-PSSession -ComputerName $ip -Credential $creds -SessionOption $so -UseSSL
$sop = New-CimSessionOption –UseSSL -SkipCACheck -SkipCNCheck -SkipRevocationCheck
$cim = New-CimSession -ComputerName $s1 -Credential $creds -SessionOption $sop
#-------------------------------------------------------
#push the configuration
Start-DSCConfiguration -CimSession $cim -Path C:\DSC\Test -Wait -Verbose -Force
#-------------------------------------------------------

$s2 = "SERVER2"
$cim = New-CimSession -ComputerName $s2 -Credential $creds -SessionOption $sop
Start-DSCConfiguration -CimSession $cim -Path C:\DSC\Test -Wait -Verbose -Force
