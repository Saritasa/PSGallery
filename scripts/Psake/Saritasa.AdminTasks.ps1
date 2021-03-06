<#PSScriptInfo

.VERSION 1.9.0

.GUID 6d562cb9-4323-4944-bb81-eba9b99b8b21

.AUTHOR Anton Zimin

.COMPANYNAME Saritasa

.COPYRIGHT (c) 2016-2018 Saritasa. All rights reserved.

.TAGS WinRM WSMan

.LICENSEURI https://raw.githubusercontent.com/Saritasa/PSGallery/master/LICENSE

.PROJECTURI https://github.com/Saritasa/PSGallery

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES

.SYNOPSIS
Contains Psake tasks for remote server administration.

.DESCRIPTION

#>

Properties `
{
    $AdminCredential = $null # If it's not set, new credential will be assigned there.
    $AdminUsername = $null
    $AdminPassword = $null
    $Environment = $null
    $ServerHost = $null
    $SiteName = $null # Unique site name, it may include slot suffix (example.org, example.org-blue, example.org-green, example.com-001, example.com-002).
    $Slot = $null # Deployment slot (Blue, Green, 001, 002).
    $WwwrootPath = $null
    $WinrmPort = 5986
    $WinrmAuthentication = [System.Management.Automation.Runspaces.AuthenticationMechanism]::Default
}

<#
SSH is used in PowerShell Core, WSMan - in PowerShell.

WSMan:
AdminCredential will be used for WinRM connection.
If it's empty, AdminUsername and AdminPassword will be converted to AdminCredential.
If AdminPassword is empty, new credential will be requested (if target server is not localhost).
#>
Task init-remoting -description 'Initializes PowerShell Remoting configuration.' `
{
    if ($PSVersionTable.PSVersion.Major -ge 6) # PowerShell Core
    {
        Initialize-RemoteManagement -UserName $AdminUsername
    }
    else # PowerShell
    {
        if (!$AdminCredential)
        {
            if ($AdminPassword)
            {
                $credential = New-Object System.Management.Automation.PSCredential($AdminUsername, (ConvertTo-SecureString $AdminPassword -AsPlainText -Force))
            }
            elseif (!(Test-IsLocalhost $ServerHost)) # Not localhost.
            {
                $credential = Get-Credential
            }

            Expand-PsakeConfiguration @{ AdminCredential = $credential }
        }

        Initialize-RemoteManagement -Credential $AdminCredential -Port $WinrmPort -Authentication $WinrmAuthentication
    }
}

Task init-winrm -depends init-remoting `
{
    Write-Warning 'The init-winrm task is obsolete. Use init-remoting instead.'
}

# Use following params to import sites on localhost:
# psake import-sites -properties @{ServerHost='.';Environment='Development'}
Task import-sites -depends init-remoting -description 'Import app pools and sites to IIS.' `
    -requiredVariables @('Environment', 'ServerHost', 'SiteName', 'WwwrootPath') `
{
    Write-Warning 'The import-sites task is obsolete. Use Ansible to set up sites.'

    $params = @{ Slot = $Slot }
    $appPoolsPath = [System.IO.Path]::GetTempFileName()
    Copy-Item "$root\IIS\AppPools.${Environment}.xml" $appPoolsPath
    Update-VariablesInFile -Path $appPoolsPath -Variables $params
    Import-AppPool $ServerHost $appPoolsPath
    Remove-Item $appPoolsPath

    $params = @{ SiteName = $SiteName; WwwrootPath = $WwwrootPath; Slot = $Slot; SiteNameHash = (GetShortHash $siteNameWithSlot); SlotHash = (GetShortHash $Slot) }
    $sitesPath = [System.IO.Path]::GetTempFileName()
    Copy-Item "$root\IIS\Sites.${Environment}.xml" $sitesPath
    Update-VariablesInFile -Path $sitesPath -Variables $params
    Import-Site $ServerHost $sitesPath
    Remove-Item $sitesPath
}

# Use following params to export sites from localhost:
# psake export-sites -properties @{ServerHost='.';Environment='Development'}
Task export-sites -depends init-remoting -description 'Export app pools and sites from IIS.' `
    -requiredVariables @('Environment', 'ServerHost') `
{
    Write-Warning 'The export-sites task is obsolete. Use Ansible to set up sites.'

    Export-AppPool $ServerHost "$root\IIS\AppPools.${Environment}.xml"
    Export-Site $ServerHost "$root\IIS\Sites.${Environment}.xml"
}

Task trust-host -description 'Add server''s certificate to trusted root CA store.' `
    -requiredVariables @('ServerHost', 'WinrmPort') `
{
    $fqdn = [System.Net.Dns]::GetHostByName($ServerHost).Hostname
    Import-TrustedSslCertificate $fqdn $WinrmPort
}

<#
.SYNOPSIS
Returns number in 0-999 which is derived from input string hash.
#>
function GetShortHash([string] $String)
{
    $md5 = [System.Security.Cryptography.MD5CryptoServiceProvider]::new()
    $utf8 = [System.Text.Encoding]::UTF8
    $bytes = $md5.ComputeHash($utf8.GetBytes($String))

    $hash = 17
    foreach ($byte in $bytes)
    {
        $hash = $hash * 23 + $byte
    }

    $hash % 1000
}
