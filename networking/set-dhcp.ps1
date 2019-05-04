<#
.SYNOPSIS
  Sets ALL IP enabled network adapters on a given PC to use DHCP
.DESCRIPTION
  This script will use CIM to step though each IP enabled network adapter on a computer then configure it for DHCP.
.EXAMPLE
  PS C:\> set-dhcp
  Configures the network adapters on the local system to use DHCP.
.EXAMPLE
  PS C:\> set-dhcp -computername PC1,PC2,...
  PC C:\> PC1,PC2 | set-dhcp
  Configures the network adapters on remote PCs to use DHCP

.INPUTS
  System.String[]
.OUTPUTS
  none
.NOTES
  This command is a bit of a blunt implement. Since it's using Win32_NetworkAdapterConfiguration it can't easily filter for a specific network adapter.
#>

[CmdletBinding()]
param(
  [parameter(Mandatory=$False,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName)]
    [String[]]
    [Alias("ServerName", "cn")]
    $Computername = $null
)

BEGIN{

}

PROCESS{
  $net = Get-CimInstance -ClassName "Win32_NetworkAdapterConfiguration" -computername $Computername -Filter "IPEnabled=$True"
  Foreach ($adapter in $net) {
    adapter.setDHCP > $null
  }
}
END{

}