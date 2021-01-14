Function Add-SmartsheetUser {
<#
    .SYNOPSIS
        Adds a user to the organization account.
    
    .DESCRIPTION
        Adds a user to the organization account.
    
    .PARAMETER UserObject
        A description of the User parameter.
    
    .PARAMETER sendEmail
        Indicates whether to send a welcome email. Defaults to false.
    
    .EXAMPLE
        PS C:\> Add-SmartsheetUser -User $value1
    
    .NOTES
        This operation is only available to system administrators
        
        If successful, and user auto provisioning (UAP) is on, and user matches the auto provisioning rules, user is added to the org.
        If UAP is off, or user does not match UAP rules, user is invited to the org and must explicitly accept the invitation to join.
        
        In some specific scenarios, supplied attributes such as firstName and lastName may be ignored.
        For example, if you are inviting an existing Smartsheet user to join your organization account, and the invited user has not yet accepted your invitation, any supplied firstName and lastName are ignored.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [Alias('User')]
        [Smartsheet.Api.Models.User[]]
        $UserObject,
        [switch]
        $sendEmail
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        ForEach ($U In $UserObject) {
            If ([string]::IsNullOrEmpty($U.Email)) {
                Write-Error "No email address specified. Please set the Email property of the userobject with that of the user to add"
                Continue
            }
            Try {
                Write-Verbose "Adding user $($U.Email)"
                $script:SmartsheetClient.UserResources.AddUser($U,
                    $sendEmail.IsPresent,
                    $null
                )
                Write-Verbose "User $($U.Email) has been Added."
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
