#-------------------------------------------------------
#add a trusted source - only if required
#winrm s winrm/config/client '@{TrustedHosts="783721-hyp41,10.127.57.25"}'
#-------------------------------------------------------
#specify test device details
$s1 = "SERVER1"
$creds = Get-Credential -Message "Enter Credentials"
#-------------------------------------------------------
#create remote sessions
$so = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
$session = New-PSSession -ComputerName $s1 -Credential $creds -SessionOption $so -UseSSL
#-------------------------------------------------------
#copy the custom module to the test device
$params = @{
    Path = 'C:\DSC\Test\localhost.mof'
    Destination = 'C:\rs-pkgs\localhost.mof'
    ToSession = $session
}
Copy-Item @params -Recurse -Force
#-------------------------------------------------------

Invoke-Command -Session $session `
    -ScriptBlock {Start-DSCConfiguration -Path C:\rs-pkgs -Wait -Verbose -Force}



$s2 = "SERVER2"
$session = New-PSSession -ComputerName $s2 -Credential $creds -SessionOption $so -UseSSL
#copy the custom module to the test device
$params = @{
    Path = 'C:\DSC\Test\localhost.mof'
    Destination = 'C:\rs-pkgs\localhost.mof'
    ToSession = $session
}
Copy-Item @params -Recurse -Force

Invoke-Command -Session $session `
    -ScriptBlock {Start-DSCConfiguration -Path C:\rs-pkgs -Wait -Verbose -Force}