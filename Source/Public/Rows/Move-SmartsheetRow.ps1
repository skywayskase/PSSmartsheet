Function Move-SmartsheetRow {
<#
    .SYNOPSIS
        Moves the specified rows from one sheet to another.

    .DESCRIPTION
        Moves the specified rows from one sheet to another.

    .PARAMETER Source
        The ID of the sheet to move rows from.

    .PARAMETER Destination
        The ID of the sheet to move rows to.

    .PARAMETER Rows
        The ID of the row(s) to move from the source sheet to the destination sheet.

    .PARAMETER Include
        A comma-separated list of row elements to move in addition to the cell data

    .EXAMPLE
        Move-SmartsheetRow -Source '4583173393803140' -Destination '2258256056870788' -Rows '145417762563972','8026717110462340'

#>

    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('MoveFrom')]
        [long]
        $Source,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('MoveTo')]
        [long]
        $Destination,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long[]]
        $Rows,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.MoveRowInclusion[]]
        $Include = $null
    )

    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $DestinationObj = [Smartsheet.Api.Models.CopyOrMoveRowDestination]::new()
            $DestinationObj.SheetId = $Destination

            $DirectiveObj = [Smartsheet.Api.Models.CopyOrMoveRowDirective]::new()
            $DirectiveObj.RowIds = $Rows
            $DirectiveObj.To = $DestinationObj

            $script:SmartsheetClient.SheetResources.RowResources.MoveRowsToAnotherSheet(
                $Source,
                $DirectiveObj,
                $Include,
                $true
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
