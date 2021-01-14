Function Get-SmartsheetCellHistory {
<#
    .SYNOPSIS
        Gets the cell modification history.
    
    .DESCRIPTION
        Gets the cell modification history for a specified cell.
    
    .PARAMETER SheetID
        Sheet Id of the sheet being accessed.
    
    .PARAMETER RowID
        Row Id in the sheet being accessed.
    
    .PARAMETER ColumnID
        Column Id in the sheet being accessed.
    
    .PARAMETER Includes
        A comma-separated list of elements to include in the query.
    
    .EXAMPLE
        		PS C:\> Get-SmartsheetCellHistory -SheetID $value1 -RowID $value2 -ColumnID $value3
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $RowID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $ColumnID,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.CellInclusion[]]
        $Includes = $null
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            $PSCmdlet.ThrowTerminatingError("Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again.")
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
        Try {
            $Script:SmartsheetClient.SheetResources.RowResources.CellResources.GetCellHistory(
                $SheetID,
                $RowID,
                $ColumnID,
                $Includes,
                $PagingParams
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
