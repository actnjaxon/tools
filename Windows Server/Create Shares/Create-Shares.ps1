# To run just call the script in Powershell from the target server:
# PS > .\Create Shares.ps1
#
# Format of the CSV files is important!
# --------------------------------
# name;sharePath;allowAccess
# --------------------------------
# This MUST be the first line of the Shares.csv files. Without this the script will error out because the viarable names won't match.
# The delimiter for this CSV is a ';', because of this, the file is easier to edit in notepad or another text editor.
# See the included Shares.csv file as an example for the format.
#
# NOTE: the allowAccess section can be a comma seperated list of Local or AD Users, or Security Groups.
#
# Also NOTE: Quotes are not required in the CSV file. If you ad them the script will ignore them.

$csv = Import-Csv -Path .\Shares.csv -Delimiter ";"
foreach ($line in $csv){
 New-SMBShare -Name $line.name -Path $line.sharePath -FolderEnumerationMode AccessBased -FullAccess $line.allowAccess.split(",")
}
