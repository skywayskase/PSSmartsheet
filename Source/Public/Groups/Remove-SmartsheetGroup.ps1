Function Remove-SmartsheetGroup {
<#
    .SYNOPSIS
        Deletes the group specified

    .DESCRIPTION
        Deletes the group specified

    .PARAMETER GroupID
        The ID of the group to delete

    .PARAMETER Force
        Removes group without prompting

    .EXAMPLE
        Remove-SmartsheetGroup -GroupID '6932724448552836' -Force

    .NOTES
        This operation is only available to group administrators and system administrators.
#>

    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [long[]]
        $GroupID,
        [switch]
        $Force
    )

    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        ForEach ($ID In $GroupID) {
            Try {
                $GroupObj = Get-SmartsheetGroup -GroupID $ID
                If ($Force -or $pscmdlet.ShouldProcess("Group $($GroupObj.Name) will be deleted. This cannot be undone")) {
                    $Script:SmartsheetClient.GroupResources.DeleteGroup(
                    $GroupObj.ID)
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
