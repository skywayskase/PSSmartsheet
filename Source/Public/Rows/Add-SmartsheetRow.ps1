Function Add-SmartsheetRow {
<#
    .SYNOPSIS
        Inserts one or more rows into the sheet specified.
    
    .DESCRIPTION
        Inserts one or more rows into the sheet specified.
    
    .PARAMETER SheetId
        The Id of the sheet to add rows to.
    
    .PARAMETER Rows
        One or more Row Objects to add to the specified sheet.
    
    .EXAMPLE
        $Cell1 = New-SSCellObject -ColumnId '7960873114331012' -Value $true
        $Cell2 = New-SSCellObject -ColumnId '642523719853956' -Value "Enabled"
        $Cell3 = New-SSCellObject -ColumnID '7960873114331012' -Value $false
        $Row1 = NewSSRowObject -ToBottom -Cells $Cell1,$Cell2
        $Row2 = NewSSRowObject -ToTop -Cells $Cell3
        Add-SmartsheetRow -SheetId '2331373580117892' -Rows $Row1,$Row2
    
    .NOTES
        Column Ids must be valid for the sheet to which the row belongs, and must only be used once for each row in the operation.
        Cells of a project sheet in the "Finish Date" column cannot be updated via API.
        Cells of a project sheet in the "Start Date" column cannot be updated via API for rows that contain a value in the "Predecessor" column.
        Max length for a cell value is 4000 characters after which truncation occurs without warning. Empty string values are converted to null.
        Calculation errors or problems with a formula do not cause the API call to return an error code. Instead, the response contains the same value as in the UI, such as cell.value = "#CIRCULAR REFERENCE".
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
        [Smartsheet.Api.Models.Row[]]
        $Rows
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $Script:SmartsheetClient.SheetResources.RowResources.AddRows(
                $SheetId,
                $Rows
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
