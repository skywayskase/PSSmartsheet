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
        Get-SmartsheetCellHistory -SheetID '9283173393803140' -RowID '0123456789012345' -ColumnID '4567890123456789,'
    
    .NOTES
        This is a resource-intensive operation and incurs 10 additional requests against the rate limit.
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
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
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
