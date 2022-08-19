@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'PSSmartsheet.psm1'

    # Version number of this module.
    ModuleVersion     = '0.1.6'

    # Supported PSEditions
    CompatiblePSEditions = @('Core', 'Desktop')

    # ID used to uniquely identify this module
    GUID              = '599a5f68-e16b-430f-8314-84a2bf7bac6f'

    # Author of this module
    Author            = 'Skylar Ragan'

    # Company or vendor of this module
    # CompanyName       = ''

    # Copyright statement for this module
    Copyright         = '(c) Skylar Ragan. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'A Powershell wrapper for the Smartsheet C# SDK'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    DotNetFrameworkVersion = '4.6.1'

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # ClrVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @(
        ".\Lib\Newtonsoft.Json.dll",
        ".\Lib\NLog.dll",
        ".\Lib\RestSharp.dll",
        ".\Lib\smartsheet-csharp-sdk.dll"
    )

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = '*'

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('SmartSheet', 'API', 'Admin')

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/skywayskase/PSSmartsheet/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/skywayskase/PSSmartsheet'

            # A URL to an icon representing this module.
            IconUri = 'https://lh3.googleusercontent.com/-gr588Q7q2AI/Wygda7E1irI/AAAAAAAAAGE/13kbguD6xTUmR1PFuyva0KKxn1IhKwO0QCLcBGAs/s400/smartsheet-128.png'

            # ReleaseNotes of this module
            ReleaseNotes = ''

            # Prerelease string of this module
            Prerelease   = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}