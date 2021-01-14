Function Remove-SmartsheetGroupMember {
<#
    .SYNOPSIS
        Removes specified  member(s) from a group.
    
    .DESCRIPTION
        Removes specified  member(s) from a group.
    
    .PARAMETER GroupID
        Id of the group to remove users from
    
    .PARAMETER User
        The userID or email of the user to be removed from the group
    
    .PARAMETER Force
        Removes user(s) group the specified group without prompting
    
    .EXAMPLE
        PS C:\> Remove-SmartsheetGroupMember -GroupID $value1 -UserID $value2
    
    .NOTES
        This operation is only available to group administrators and system administrators.
#>
    
    [CmdletBinding(ConfirmImpact = 'Medium',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $GroupID,
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [Alias('Email', 'UserID')]
        [string[]]
        $User,
        [switch]
        $Force
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        $GroupObj = Get-SmartsheetGroup -GroupID $GroupID
        ForEach ($U In $User) {
            If ($U -match "^[^@\s]+@[^@\s]+\.[^@\s]+$") {
            $UserObj = Get-SmartsheetUser -Email $U
            }
            Else {
                $UserObj = (Get-SmartsheetUser -UserID $U)
            }
            If ($Force -or $pscmdlet.ShouldProcess("Removing user with email $($UserObj.Email) from $($GroupObj.Name)")) {
                $script:SmartsheetClient.GroupResources.RemoveGroupMember(
                    $GroupID,
                    $UserObj.ID
                )
            }
        }
    }
}
