@{
    Path                     = "PSSmartsheet.psd1"
    Prefix                   = '$ModuleRoot = $PSScriptRoot'
    Suffix                   = "Import-SmartsheetSDK"
    CopyDirectories          = "Lib"
    VersionedOutputDirectory = $true
    OutputDirectory          = "..\PSSmartSheet"
}