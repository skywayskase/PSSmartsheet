Function Get-SmartsheetColumn {
<#
    .SYNOPSIS
        Gets a specified column or a list of columns on a specified sheet
    
    .DESCRIPTION
        Gets a specified column or a list of columns on a specified sheet
    
    .PARAMETER SheetID
        Sheet Id of the sheet being accessed.
    
    .PARAMETER Include
        A description of the Include parameter.
    
    .PARAMETER ColumnID
        Column Id in the sheet being accessed.
    
    .PARAMETER Level
        Specifies whether new functionality, such as multi-contact data is returned in a backwards-compatible, text format (level=0, default), multi-contact data (level=1), or multi-picklist data (level=2).
    
    .EXAMPLE
        PS C:\> Get-SmartsheetColumns -SheetID $value1
    
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
        [Smartsheet.Api.Models.ColumnInclusion[]]
        $Include = $null,
        [ValidateNotNullOrEmpty()]
        [long[]]
        $ColumnID,
        [ValidateSet('0', '1', '2')]
        [int]
        $Level = 0
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
        Try {
            If ($ColumnID) {
                ForEach ($column In $ColumnID) {
                    $Script:SmartsheetClient.SheetResources.ColumnResources.getColumn(
                        $SheetID,
                        $column,
                        $Include
                    )
                }
            }
            Else {
                $Script:SmartsheetClient.SheetResources.ColumnResources.ListColumns(
                    $SheetID,
                    $Include,
                    $PagingParams,
                    $level
                )
            }
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
