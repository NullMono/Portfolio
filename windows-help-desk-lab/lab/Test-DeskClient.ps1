#Requires -Version 5.1
# Read-only baseline. Run in an elevated Windows PowerShell session on the lab client.
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$computer = Get-CimInstance Win32_ComputerSystem
if ($env:COMPUTERNAME -ne 'W11-01' -or -not $computer.PartOfDomain -or $computer.Domain -ne 'altdesk.test') {
    throw 'Use the domain-joined W11-01 lab VM.'
}
function Test-LabDns([string]$Name, [string]$Type, [string]$ValueField, [string]$Expected) {
    try {
        $records = Resolve-DnsName -Name $Name -Type $Type -DnsOnly -NoHostsFile -ErrorAction Stop
        return (@($records | ForEach-Object { if ($_.$ValueField) { ([string]$_.$ValueField).TrimEnd('.') } }) -contains $Expected)
    } catch { return $false }
}
$secureChannel = try { Test-ComputerSecureChannel -ErrorAction Stop } catch { $false }
$result = [pscustomobject]@{
    Computer           = $env:COMPUTERNAME
    Domain             = $computer.Domain
    DcAddressMatches   = Test-LabDns 'dc01.altdesk.test' 'A' 'IPAddress' '192.168.77.10'
    DirectoryDnsRecord = Test-LabDns '_ldap._tcp.dc._msdcs.altdesk.test' 'SRV' 'NameTarget' 'dc01.altdesk.test'
    FilePortByIP       = Test-NetConnection '192.168.77.10' -Port 445 -InformationLevel Quiet -WarningAction SilentlyContinue
    SecureChannel      = $secureChannel
}
$result
if (-not ($result.DcAddressMatches -and $result.DirectoryDnsRecord -and $result.FilePortByIP -and $result.SecureChannel)) {
    Write-Warning 'One or more baseline tests failed. Compare tests and inspect the adapter DNS, clock and VM segment.'
    exit 1
}
