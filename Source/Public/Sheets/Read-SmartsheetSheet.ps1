Function Read-SmartsheetSheet {
<#
    .SYNOPSIS
        Gets the sheet specified by SheetID. Returns the sheet, including rows, and optionally populated with discussion and attachment objects.
    
    .DESCRIPTION
        Gets the sheet specified by SheetID. Returns the sheet, including rows, and optionally populated with discussion and attachment objects.
    
    .PARAMETER SheetID
        Sheet Id of the sheet being accessed.
    
    .PARAMETER Include
        A comma-separated list of optional elements to include in the response
    
    .PARAMETER Exclude
        A comma-separated list of optional elements to not include in the response
    
    .PARAMETER ColumnIDs
        A comma-separated list of column ids. The response contains only the specified columns in the "columns" array, and individual rows' "cells" array only contains cells in the specified columns.
    
    .PARAMETER RowIds
        A comma-separated list of row Ids on which to filter the rows included in the result.
    
    .PARAMETER RowNumbers
        A comma-separated list of row numbers on which to filter the rows included in the result. Non-existent row numbers are ignored.
    
    .EXAMPLE
        Read-SmartsheetSheet -SheetID '4583173393803140'
    
    .EXAMPLE
        Read-SmartsheetSheet -SheetID '4583173393803140' -Include FILTERS,DISCUSSIONS -Exclude NONEXISTANTCELLS
#>
    
    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.Sheet])]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetID,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.SheetLevelInclusion[]]
        $Include = $null,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.SheetLevelExclusion[]]
        $Exclude = $null,
        [long[]]
        $ColumnIDs = $null,
        [long[]]
        $RowIds = $null,
        [int[]]
        $RowNumbers = $null
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        
    }
    Process {
        Try {
            $script:SmartsheetClient.SheetResources.GetSheet(
                $SheetID,
                $Include,
                $Exclude,
                $RowIds,
                $RowNumbers,
                $ColumnIDs,
                $null,
                $null
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
