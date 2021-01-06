Function Remove-SmartsheetUser {
<#
    .SYNOPSIS
        Removes A Smartsheet User from an organization account
    
    .DESCRIPTION
        Removes a user from an organization account. User is transitioned to a free collaborator with read-only access to owned dashboards, reports, sheets, workspaces, and any shared templates (unless those are optionally transferred to another user).
    
    .PARAMETER User
        The userID or email of the user to be removed from the organization
    
    .PARAMETER RemoveFromSharing
        Switch to remove the user from sharing for all sheets/workspaces in the organization account. If not specified, user is not removed from sharing.
    
    .PARAMETER TransferTo
        The userID or email of the user to transfer ownership to. If the user being removed owns groups, they are transferred to this user.
        If the user owns sheets, and transferSheets is true, the removed user's sheets are transferred to this user.
        NOTE: Required if user owns groups
        NOTE: If the TransferTo parameter is specified and the removed user owns groups, the user specified via the TransferTo parameter must have group admin rights.
    
    .PARAMETER TransferSheets
        If set, the removed user's sheets are transferred to the user specified with the TransferTo parameter. Else, sheets are not transferred
    
    .EXAMPLE
        PS C:\> Remove-SmartsheetUser
    
    .NOTES
        This operation is only available to system administrators.
        The transferTo and transferSheets parameters cannot be specified for a user who has not yet accepted an invitation to join the organization account (that is, if user status=PENDING).
#>
    
    [CmdletBinding(ConfirmImpact = 'High',
                   SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $User,
        [switch]
        $RemoveFromSharing,
        [Parameter(ParameterSetName = 'Transfer',
                   Mandatory = $true)]
        $TransferTo,
        [Parameter(ParameterSetName = 'Transfer')]
        [switch]
        $TransferSheets
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been invoked. Please run Invoke-SmartsheetClient and try again."
        }
    }
    Process {
        If (![String]::IsNullOrEmpty($TransferTo)) {
            If ($TransferTo -match "^[^@\s]+@[^@\s]+\.[^@\s]+$") {
                $TransferToObj = Get-SmartsheetUser -Email $TransferTo
            }
            Else {
                $TransferToObj = (Get-SmartsheetUser -UserID $TransferTo)
            }
            
        }
        ForEach ($U In $User) {
            If ($U -match "^[^@\s]+@[^@\s]+\.[^@\s]+$") {
                $UserObj = Get-SmartsheetUser -Email $U
            }
            Else {
            	$UserObj = (Get-SmartsheetUser -UserID $U)
            }
            If ($pscmdlet.ShouldProcess("Removing user with email $($UserObj.Email) from Org")) {
                If ($PSCmdlet.ParameterSetName -eq 'Transfer') {
                    $script:SmartsheetClient.UserResources.RemoveUser($userObj.ID,
                        $TransferToObj.ID,
                        $TransferSheets.IsPresent,
                        $RemoveFromSharing.IsPresent
                    )
                }
                Else {
                    $script:SmartsheetClient.UserResources.RemoveUser($userObj.ID,
                        $null,
                        $TransferSheets.IsPresent,
                        $RemoveFromSharing.IsPresent
                    )
                }
            }
        }
        
    }
}
