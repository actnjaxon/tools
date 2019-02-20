#PowerShell function for setting a static IP on a PC
#Leverages WMI to accomplish the reset
#
#Expected input:
# -ComputerName           Default target is the local PC, but in theroy this function can be run against any network PC
# -IpAddr                 The new IP address you'd like to use
# -NetMask                Subnet Mask for the new static IP
# -GWAddr                 Default Gateway IP (technically this can be a string array, but this script isn't coded for that)
# -DNS                    String Array containing the DNS servers you want to use. Default value is OpenDNS
# NOTE THIS WILL RUN AGAINS ALL ACTIVE ADAPTERS, DON'T USE ON A SERVER UNLESS YOU FILTER THE OUTPUT FIRST

Function set-static {
  param (
    [string] $ComputerName = ".",
    [paramater(manditory=$true)]
    [string] 
    $IpAddr,
    [paramater(manditory=$true)]
    [string]
    $NetMask,
    [paramater(manditory=$true)]
    [string]
    $GWAddr,
    $DNS=@("208.67.222.222","208.67.220.220")
  )
  $net = Get-WmiObject -class "Win32_NetworkAdapterConfiguration" -computername $ComputerName | Where-Object {$_.IPEnabled -Match "True"}
  Foreach ($adapter in $net){
    $adapter.EnableStatic($IpAddr,$NetMask) > $null
    $adapter.SetGateways($GWAddr) > $null
    $adapter.SetDNSServerSearchOrder($DNS) > $null
  }   
}
