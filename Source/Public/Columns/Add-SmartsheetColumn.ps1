Function Add-SmartsheetColumn {
<#
    .SYNOPSIS
        Inserts one or more columns into the sheet specified.

    .DESCRIPTION
        Inserts one or more columns into the sheet specified.

    .PARAMETER SheetId
        The ID of the sheet to add columns to.

    .PARAMETER Column
        One or more column objects to add to the specified sheet.

    .EXAMPLE
        $column1 = New-SSColumnObject -Title "Column 1" -Primary
        $column2 = New-SSColumnObject -Title "Second Column" -Type CHECKBOX
        Add-SmartsheetColumn -SheetId '2252168947361668' -Column $column1,$Column2

    .NOTES
        If multiple columns are specified in the request, the index attribute must be set to the same value for all columns.
#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Column[]]
        $Column
    )

    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $script:SmartsheetClient.SheetResources.ColumnResources.AddColumns(
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
