Function Remove-SmartsheetRow {
<#
    .SYNOPSIS
        Deletes one or more rows from the sheet specified.
    
    .DESCRIPTION
        Deletes one or more rows from the sheet specified.
    
    .PARAMETER SheetId
        The ID of the sheet to remove rows from
    
    .PARAMETER RowIds
        The ID of the row(s) to delete from the specified sheet.
    
    .PARAMETER Force
        Deletes the specified rows without prompting
    
    .EXAMPLE
        		PS C:\> Remove-SmartsheetRow -SheetId $value1 -RowIds $value2
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long[]]
        $RowIds,
        [switch]
        $Force
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            If ($Force -or $pscmdlet.ShouldProcess("$($RowIds.count) rows will be deleted. This cannot be undone")) {
                $Script:SmartsheetClient.SheetResources.RowResources.DeleteRows(
                    $SheetId,
                    $RowIds,
                    $true
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
