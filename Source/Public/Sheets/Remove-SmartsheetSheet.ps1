Function Remove-SmartsheetSheet {
<#
    .SYNOPSIS
        Deletes a specified sheet.
    
    .DESCRIPTION
        Deletes a specified sheet. This cannot be undone!
    
    .PARAMETER SheetId
        The Id of the sheet(s) to delete.
    
    .PARAMETER Force
        Forces the sheet to be deleted without prompting
    
    .EXAMPLE
        Remove-SmartsheetSheet -SheetId 1531988831168388 -Force
    
#>
    
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long[]]
        $SheetId,
        [switch]
        $Force
    )
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        ForEach ($ID In $SheetId) {
            Try {
                $SheetObj = Get-SmartsheetSheet -SheetID $ID
                If ($Force -or $pscmdlet.ShouldProcess("The sheet $($SheetObj.Name) will be deleted. This cannot be undone")) {
                    $Script:SmartsheetClient.SheetResources.DeleteSheet(
                        $SheetObj.ID)
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
}
