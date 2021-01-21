Function Set-SmartsheetGroup {
<#
    .SYNOPSIS
        Updates the Group specified
    
    .DESCRIPTION
        Updates the Group Specified.
    
    .PARAMETER GroupObject
        The group object created using New-SSGroupObject
    
    .PARAMETER GroupID
        The ID of the group to update
    
    .PARAMETER Name
        A new name for the group. Must be unique accross the org.
    
    .PARAMETER Description
        A new description for the group
    
    .PARAMETER OwnerID
        The userID of a user to transfer ownership to.
        NOTE: Must be either a Group Admin or System Admin
    
    .EXAMPLE
        $Group = New-SSGroupObject -GroupId '2331373580117892' -Name 'New Group Name' -OwnerID '2331373580117892'
        Set-SmartsheetGroup -GroupObject $group
    
    .EXAMPLE
        New-SSGroupObject -GroupId '2331373580117892' -Name 'New Group Name' -OwnerID '2331373580117892' | Set-SmartsheetGroup
    
    .NOTES
        This operation is only available to group administrators and system administrators.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'Params')]
    Param
    (
        [Parameter(ParameterSetName = 'GroupObject',
                   Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('InputObject')]
        [Smartsheet.Api.Models.Group[]]
        $GroupObject,
        [Parameter(ParameterSetName = 'Params',
                   Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $GroupID,
        [Parameter(ParameterSetName = 'Params')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,
        [Parameter(ParameterSetName = 'Params')]
        [string]
        $Description,
        [Parameter(ParameterSetName = 'Params')]
        [ValidateNotNullOrEmpty()]
        [long]
        $OwnerID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        If ($PSCmdlet.ParameterSetName -eq 'Params') {
            $GroupObject = New-SSGroupObject -GroupID $GroupID
            $PSBoundParameters.Keys.Where{
                $_ -ne 'GroupID'
            }.Foreach{
                $GroupObject.$_ = $PSBoundParameters[$_]
            }
        }
        ForEach ($GO In $GroupObject) {
            Try {
                $script:SmartsheetClient.GroupResources.UpdateGroup($GO)
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
