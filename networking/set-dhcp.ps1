#The reverse of set-static
#This rolls you back to useing DHCP
#NOTE THIS WILL RUN AGAINS ALL ACTIVE ADAPTERS, DON'T USE ON A SERVER UNLESS YOU FILTER THE OUTPUT FIRST

Function Set-DHCP {
  param(
    [String]$ComputerName = "."
  )
  $net = Get-WmiObject -class "Win32_NetworkAdapterConfiguration" -computername $ComputerName | Where-Object {$_.IPEnabled -Match "True"}
  Foreach ($adapter in $net) {
    adapter.setDHCP() > $null
  }
}
