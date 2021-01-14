Function Add-SmartsheetGroupMember {
<#
    .SYNOPSIS
        Adds one or more members to a group.
    
    .DESCRIPTION
        Adds one or more members to a group.
    
    .PARAMETER Email
        Email address of new user(s) to add to the specified group
    
    .PARAMETER GroupID
        ID of the group to add members to.
    
    .EXAMPLE
        		PS C:\> Add-SmartsheetGroupMembers -Email $value1 -GroupID $value2
    
    .NOTES
        This operation is only available to group administrators and system administrators.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[^@\s]+@[^@\s]+\.[^@\s]+$')]
        [string[]]
        $Email,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $GroupID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            $PSCmdlet.ThrowTerminatingError("Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again.")
        }
    }
    Process {
        [Smartsheet.Api.Models.GroupMember[]]$groupMembers = $Email.foreach{
            [Smartsheet.Api.Models.GroupMember+AddGroupMemberBuilder]::new($_).Build()
        }
        Try {
            $script:SmartsheetClient.GroupResources.AddGroupMembers(
                $GroupID,
                $groupMembers
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
