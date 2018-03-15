Get-DscResource -Module PSDesiredStateConfiguration | ? {$_.Name -eq "File"} | fl *
Get-DscResource -Module PSDesiredStateConfiguration | Select-Object Name,Properties | ft -AutoSize
(Get-DscResource -Module PSDesiredStateConfiguration).Path