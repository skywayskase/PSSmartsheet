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
        PS C:\> Move-SmartsheetSheet
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [long]
        $SheetID,
        [Parameter(ParameterSetName = 'DestinationSpecified',
                   Mandatory = $true)]
        [AllowNull()]
        [long]
        $DestinationID = $null,
        [Parameter(ParameterSetName = 'DestinationSpecified',
                   Mandatory = $true)]
        [Smartsheet.Api.Models.DestinationType]
        $DestinationType = "HOME"
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        $Destination = [Smartsheet.Api.Models.ContainerDestination]::new(
            $DestinationID,
            $DestinationType,
            $Null
        )
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
