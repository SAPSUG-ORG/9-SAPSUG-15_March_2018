Configuration Demo2 {
	Param ()
	Import-DscResource -ModuleName PSDesiredStateConfiguration
	
	node $AllNodes.NodeName {
		#------------------------------------
		WindowsFeature 'Telnet-Client' {
			#DependsOn = "[WindowsFeature]Failover-Clustering"
			Ensure = "Absent"
			Name = "Telnet-Client"
        } #clusterPowerShell
        #------------------------------------
		File RequiredDirectory {
			Ensure = 'Present'
			Type = 'Directory'
			DestinationPath = "C:\RequiredDirectory"
		} #VMsFile
		#------------------------------------
    }#localhost
} #close configuration

$cd = @{
	AllNodes = @(
        @{ NodeName = 'Server1'},
		@{ NodeName = 'Server2'}
	)
}

Demo2 -Configuration $cd -outputpath c:\DSC\Test