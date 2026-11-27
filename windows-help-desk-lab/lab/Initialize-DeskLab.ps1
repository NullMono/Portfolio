#Requires -Version 5.1
#Requires -RunAsAdministrator
#Requires -Modules ActiveDirectory, SmbShare
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$domain = Get-ADDomain
if ($env:COMPUTERNAME -ne 'DC01' -or $domain.DNSRoot -ne 'altdesk.test' -or
    (Get-CimInstance Win32_ComputerSystem).DomainRole -lt 4) {
    throw 'Run this in Windows PowerShell on the DC01 domain controller in altdesk.test.'
}

$marker = 'Atlanta Windows Help Desk practice lab'
$base = $domain.DistinguishedName
function New-LabOU([string]$Name, [string]$Parent) {
    $dn = "OU=$Name,$Parent"
    $ou = Get-ADOrganizationalUnit -Filter { Name -eq $Name } -SearchBase $Parent -SearchScope OneLevel -Properties Description
    if ($ou -and $ou.Description -ne $marker) { throw "Existing OU is outside this lab: $dn" }
    if (-not $ou) { New-ADOrganizationalUnit -Name $Name -Path $Parent -Description $marker }
    return $dn
}
$labOU = New-LabOU 'DeskLab' $base
$staffOU = New-LabOU 'Staff' $labOU
$opsOU = New-LabOU 'Operators' $labOU
$groupOU = New-LabOU 'Groups' $labOU

function New-LabUser([string]$Login, [string]$Name, [string]$OU) {
    $user = Get-ADUser -Filter { SamAccountName -eq $Login } -Properties Description
    if ($user) {
        if ($user.Description -ne $marker -or $user.DistinguishedName -ne "CN=$Name,$OU") {
            throw "Conflicting AD user: $Login"
        }
        if ($user.Enabled) { return }
        $choice = Read-Host "$Login is disabled. To finish this lab account, type RESUME to reset its password and enable it"
        if ($choice -ne 'RESUME') { throw "Setup stopped with $Login still disabled." }
    } else {
        $user = New-ADUser -Name $Name -DisplayName $Name -SamAccountName $Login -UserPrincipalName "$Login@altdesk.test" -Path $OU -Description $marker -Enabled $false -PassThru
    }

    while ($true) {
        $password = Read-Host "Choose a unique lab password for $Login (14+ mixed characters, omit the user's names)" -AsSecureString
        try {
            Set-ADAccountPassword -Identity $user.ObjectGUID -Reset -NewPassword $password -ErrorAction Stop
            break
        } catch [Microsoft.ActiveDirectory.Management.ADPasswordComplexityException] {
            Write-Warning 'The domain rejected that password. Enter a new one that meets domain policy.'
        }
    }
    Enable-ADAccount -Identity $user.ObjectGUID -ErrorAction Stop
}

New-LabUser 'desk.tech' 'Desk Technician' $opsOU
New-LabUser 'maya.patel' 'Maya Patel' $staffOU
New-LabUser 'jordan.brooks' 'Jordan Brooks' $staffOU
New-LabUser 'olivia.chen' 'Olivia Chen' $staffOU

$groupName = 'Dispatch-Readers'
$group = Get-ADGroup -Filter { SamAccountName -eq $groupName } -Properties Description
if ($group) {
    if ($group.Description -ne $marker -or $group.DistinguishedName -ne "CN=$groupName,$groupOU") {
        throw "Conflicting security group: $groupName"
    }
} else {
    New-ADGroup -Name $groupName -SamAccountName $groupName -Path $groupOU -GroupScope Global -GroupCategory Security -Description $marker
}
$reader = Get-ADUser 'olivia.chen'
if ($reader.DistinguishedName -notin (Get-ADGroupMember $groupName | Select-Object -ExpandProperty DistinguishedName)) {
    Add-ADGroupMember -Identity $groupName -Members $reader
}

$directory = 'C:\ATLDeskLab\Dispatch'
$shareName = 'Dispatch'
$share = Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue
if ($share -and ($share.Path -ne $directory -or $share.Description -ne $marker)) {
    throw "A different share already uses $shareName."
}
$tagFile = Join-Path $directory '.desk-lab'
if (Test-Path -LiteralPath $directory) {
    if (-not (Test-Path -LiteralPath $tagFile) -or (Get-Content -LiteralPath $tagFile -Raw).Trim() -ne $marker) {
        throw "Existing folder is outside this lab: $directory"
    }
} else {
    New-Item -ItemType Directory -Path $directory | Out-Null
    Set-Content -LiteralPath $tagFile -Value $marker
}
$readers = "$($domain.NetBIOSName)\$groupName"
$sampleFile = Join-Path $directory 'shift-notes.txt'
if (-not (Test-Path -LiteralPath $sampleFile)) {
    Set-Content -LiteralPath $sampleFile -Value 'Training dispatch board: Bay 2 opens at 08:30.'
}
& icacls.exe $directory /grant:r "$($readers):(OI)(CI)RX" | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Failed to grant the reader group NTFS read access.' }
if (-not $share) {
    $admins = ([System.Security.Principal.SecurityIdentifier]'S-1-5-32-544').Translate([System.Security.Principal.NTAccount]).Value
    New-SmbShare -Name $shareName -Path $directory -Description $marker -ReadAccess $readers -FullAccess $admins | Out-Null
}
Write-Output 'Lab objects ready. Finish delegation on DC01, then validate the client and share as described in the guide.'
