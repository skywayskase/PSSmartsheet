Function Set-SmartsheetColumn {
<#
    .SYNOPSIS
        Updates properties of the column, moves the column, and/or renames the column.
    
    .DESCRIPTION
        Updates properties of the column, moves the column, and/or renames the column.
    
    .PARAMETER SheetId
        The sheet containing the column to update.
    
    .PARAMETER Column
        A column object representing the column to update. Must include an ID for the specified column.
    
    .EXAMPLE
        $column = New-SSColumnObject -Title "Column 1" -Id '5005385858869124' -Index 0
        Set-SmartsheetColumn -SheetId '2252168947361668' -Column $column
    
    .NOTES
        You cannot change the type of a Primary column.
        While dependencies are enabled on a sheet, you can't change the type of any special calendar/Gantt columns.
        If the column type is changed, all cells in the column are converted to the new column type and column validation is cleared.
        Type is optional when moving or renaming, but required when changing type or dropdown values.
#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Column]
        $Column
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $script:SmartsheetClient.SheetResources.ColumnResources.UpdateColumn(
                $SheetId,
                $Column
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
