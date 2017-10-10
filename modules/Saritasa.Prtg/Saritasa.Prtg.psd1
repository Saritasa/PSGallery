﻿#
# Module manifest for module 'Saritasa.Prtg'
#
# Generated by: Anton Zimin
#
# Generated on: 4/26/2016
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Saritasa.Prtg'

# Version number of this module.
ModuleVersion = '1.5.0'

# ID used to uniquely identify this module
GUID = '5d34804a-169a-4fb1-bc0d-cc81f925f992'

# Author of this module
Author = 'Anton Zimin'

# Company or vendor of this module
CompanyName = 'Saritasa'

# Copyright statement for this module
Copyright = '(c) 2016-2017 Saritasa. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Contains functions to call PRTG monitoring service (www.paessler.com/prtg) APIs.'

# Minimum version of the Windows PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @(
    @{ ModuleName='Saritasa.General'; ModuleVersion='1.1.0'; GUID='7c7dc05c-033b-4838-8619-b84792571317' },
    @{ ModuleName='Saritasa.Web'; ModuleVersion='1.4.0'; GUID='6aeb9fa0-7096-4488-9d49-4f16578d7be0' }
)

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @('Initialize-Prtg', 'Get-PrtgSensorId', 'Start-PrtgSensor',
    'Stop-PrtgSensor')

# Cmdlets to export from this module
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'PRTG', 'Monitoring', 'Sensor'

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/Saritasa/PSGallery/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Saritasa/PSGallery'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

