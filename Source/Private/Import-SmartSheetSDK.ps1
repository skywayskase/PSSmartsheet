Function Import-SmartsheetSDK {
    [CmdletBinding()]
    Param ()
    Process {
        $lib = Resolve-Path "$($script:ModuleRoot)\Lib"
        Add-Type -Path "$lib\Newtonsoft.Json.dll"
        Add-Type -Path "$lib\NLog.dll"
        Add-Type -Path "$lib\RestSharp.dll"
        Add-Type -Path "$lib\smartsheet-csharp-sdk.dll"
    }
}
