Function Copy-SmartsheetSheet {
<#
    .SYNOPSIS
        Creates a copy of the specified sheet.

    .DESCRIPTION
        Creates a copy of the specified sheet.

    .PARAMETER SheetID
        Sheet Id of the sheet being copied

    .PARAMETER DestinationID
        Id of the destination container (when copying or moving a folder or a sheet). Required if destinationType is "folder" or "workspace" If destinationType is "home", this value must be null.

    .PARAMETER DestinationType
        Type of the destination container (when copying or moving a folder or a sheet). One of the following values:
        folder
        home
        workspace

    .PARAMETER NewName
        Name of the newly created sheet

    .PARAMETER Includes
        A comma-separated list of elements to copy

    .EXAMPLE
        Copy-SmartsheetSheet -SheetID '9283173393803140' -DestinationID '3791509922310020' -DestinationType FOLDER -NewName 'A copy of sheet 1'

    .EXAMPLE
        Copy-SmartsheetSheet -SheetID '9283173393803140' -NewName 'Another copy of a sheet' -Includes DATA

#>

    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [long]
        $SheetID,
        [Parameter(Mandatory = $false)]
        [AllowNull()]
        [long]
        $DestinationID = $null,
        [Smartsheet.Api.Models.DestinationType]
        $DestinationType = "HOME",
        [Parameter(Mandatory = $true)]
        [string]
        $NewName,
        [Smartsheet.Api.Models.SheetCopyInclusion[]]
        $Includes = $null
    )

    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        $Destination = [Smartsheet.Api.Models.ContainerDestination]::new()
        $Destination.DestinationId = $DestinationID
        $Destination.DestinationType = $DestinationType
        $Destination.NewName = $NewName

        Try {
            $script:SmartsheetClient.SheetResources.CopySheet(
                $SheetID,
                $Destination,
                $Includes
            )
        }
        Catch {
            If ($ErrorActionPreference -eq 'Stop') {
                $PSCmdlet.ThrowTerminatingError($_)
            }
            Else {
                Write-Error $_
            }
        }
    }
}
