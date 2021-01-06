Function Set-SmartsheetUser {
<#
    .SYNOPSIS
        Updates a Smartsheet user
    
    .DESCRIPTION
        Updates a specified Smartsheet user account
    
    .PARAMETER UserObject
        A user object created with the New-SSUserObject cmdlet
    
    .EXAMPLE
        PS C:\> Set-SmartsheetUser
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true)]
        [Alias('User')]
        [Smartsheet.Api.Models.User[]]
        $UserObject
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been invoked. Please run Invoke-SmartsheetClient and try again."
        }
    }
    Process {
        ForEach ($U In $UserObject) {
            If ([string]::IsNullOrEmpty($U.Id) -and ![string]::IsNullOrEmpty($U.Email)) {
                $U.Id = (Get-SmartsheetUser -Email $U.Email).Id
            }
            ElseIf ([string]::IsNullOrEmpty($U.Id) -and [string]::IsNullOrEmpty($U.Email)) {
                Write-Error "No UserID specified. Please set the ID property of the userobject with that of the user to update"
                Continue
            }
            Try {
                Write-Verbose "Updating user $($U.Id)"
                $script:SmartsheetClient.UserResources.UpdateUser($U)
                Write-Verbose "User $($U.Id) has been updated."
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
