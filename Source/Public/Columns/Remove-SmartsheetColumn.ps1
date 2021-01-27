Function Remove-SmartsheetColumn {
<#
    .SYNOPSIS
        Deletes a specified column.

    .DESCRIPTION
        Deletes a specified column.

    .PARAMETER SheetId
        The ID of the sheet to delete columns from

    .PARAMETER ColumnId
        The ID of the column(s) to delete from the specified sheet.

    .PARAMETER Force
        Forces the rows to be deleted without prompting.

    .EXAMPLE
        Remove-SmartsheetColumn -SheetId '9283173393803140' -ColumnId '0123456789012345' -Force

#>
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [long[]]
        $ColumnId,
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
            ForEach ($ID In $ColumnId) {
                $Column = Get-SmartsheetColumn -SheetId $SheetId -ColumnId $ID
                If ($Force -or $pscmdlet.ShouldProcess("The column $($Column.title) will be deleted. This cannot be undone")) {
                    $Script:SmartsheetClient.SheetResources.ColumnResources.DeleteColumn(
                        $SheetId,
                        $Column.Id
                    )
                }
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
