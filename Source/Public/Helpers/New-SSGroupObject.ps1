Function New-SSGroupObject {
<#
    .SYNOPSIS
        Creates a Group object that can be used to add memebers to a group

    .DESCRIPTION
        Creates a Group object that can be used to add memebers to a group

    .PARAMETER MemberEmail
        Email addresses of user to initially populate a new group

    .PARAMETER Name
        A name for the group. Must be unique within the org

    .PARAMETER Description
        A description of the group

    .PARAMETER GroupID
        The ID of the group to update

    .PARAMETER OwnerID
        The userID of a user to transfer ownership to.
        NOTE: Must be either a Group Admin or System Admin

    .EXAMPLE
        $Group = New-SSGroupObject -Name 'A new Group' -MemberEmail 'john.doe@example.com','Jane.doe@example.com'

    .EXAMPLE
        $Group = New-SSGroupObject -GroupId '2331373580117892' -Name 'New Group Name' -OwnerID '2331373580117892'

#>

    [CmdletBinding(DefaultParameterSetName = 'New')]
    [OutputType([Smartsheet.Api.Models.Group])]
    Param
    (
        [Parameter(ParameterSetName = 'New')]
        [ValidatePattern('^[^@\s]+@[^@\s]+\.[^@\s]+$')]
        [Alias('Email')]
        [string[]]
        $MemberEmail,
        [Parameter(ParameterSetName = 'New',
                   Mandatory = $true)]
        [Parameter(ParameterSetName = 'Update')]
        [string]
        $Name,
        [string]
        $Description = $null,
        [Parameter(ParameterSetName = 'Update',
                   Mandatory = $true)]
        [long]
        $GroupID,
        [Parameter(ParameterSetName = 'Update')]
        [long]
        $OwnerID
    )
    Process {
        Switch ($PsCmdlet.ParameterSetName) {
            'New' {
                $GroupObject = [Smartsheet.Api.Models.Group+CreateGroupBuilder]::new($Name, $Description)
                If ($MemberEmail) {
                    [Smartsheet.Api.Models.GroupMember[]]$groupMembers = $MemberEmail.foreach{
                        [Smartsheet.Api.Models.GroupMember+AddGroupMemberBuilder]::new($_).Build()
                    }
                    [void]$GroupObject.SetMembers($groupMembers)
                }
                $GroupObject.Build()
                Break
            }
            'Update' {
                $GroupObject = [Smartsheet.Api.Models.Group+UpdateGroupBuilder]::new($GroupID)
                Switch ($PSBoundParameters.Keys) {
                    'Name' {
                        [void]$GroupObject.SetName($Name)
                    }
                    'Description' {
                        [void]$GroupObject.SetDescription($Description)
                    }
                    'OwnerID' {
                        [void]$GroupObject.SetOwnerId($OwnerID)
                    }
                }
                $GroupObject.Build()
                Break
            }
        }
    }
}
