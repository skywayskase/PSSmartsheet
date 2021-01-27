Function Move-SmartsheetSheet {
<#
    .SYNOPSIS
        Moves the specified sheet to a new location.
    
    .DESCRIPTION
        Moves the specified sheet to a new location. When a sheet that is shared to one or more users and/or groups is moved into or out of a workspace, those sheet-level shares are preserved.
    
    .PARAMETER SheetID
        Sheet Id of the sheet being accessed.
    
    .PARAMETER DestinationID
        Id of the destination container (when copying or moving a folder or a sheet). Required if destinationType is "folder" or "workspace" If destinationType is "home", this value must be null.
    
    .PARAMETER DestinationType
        Type of the destination container (when copying or moving a folder or a sheet). One of the following values:
        folder
        home
        workspace
    
    .EXAMPLE
        Move-SmartsheetSheet -SheetID '9283173393803140' -DestinationID '3791509922310020' -DestinationType FOLDER
    
    .EXAMPLE
        Move-SmartsheetSheet -SheetID '9283173393803140'
    
#>
    
    [CmdletBinding()]
    Param
    (
        [long]
        $SheetID,
        [AllowNull()]
        [long]
        $DestinationID = $null,
        [Smartsheet.Api.Models.DestinationType]
        $DestinationType = "HOME"
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
        
        Try {
            $script:SmartsheetClient.SheetResources.MoveSheet(
                $SheetID,
                $Destination
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
