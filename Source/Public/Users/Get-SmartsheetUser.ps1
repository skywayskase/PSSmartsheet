Function Get-SmartsheetUser {
<#
    .SYNOPSIS
        Returns specified Smartsheet user or list of users
    
    .DESCRIPTION
        Returns the specified Smartsheet user or a list of users
    
    .PARAMETER UserID
        The ID of a specific user to get.
    
    .PARAMETER Email
        The email address or list of email addresses of users to get.
    
    .PARAMETER List
        Returns an array of all users in the org.
    
    .PARAMETER Me
        Returns a user object representing the calling user.
    
    .EXAMPLE
        Get-SmartsheetUsers -Email "John.Doe@example.com"
    
        Returns user info for a smartsheet user with the email of "John.Doe@exampled.com".
    
    .EXAMPLE
        Get-SmartsheetUsers -Email "John.Doe@example.com","Jane.Doe@example.com"
    
        Returns user info for both matching users
    
    .EXAMPLE
        Get-SmartsheetUsers -List
    
        Gets a list of users in the organization account.
    
    .EXAMPLE
        Get-SmartsheetUsers -Me
    
        Gets the current user.
    
    .OUTPUTS
        Smartsheet.Api.Models.User, Smartsheet.Api.Models.UserProfile, Smartsheet.Api.Models.User, Smartsheet.Api.Models.UserProfile
    
#>
    
    [CmdletBinding(DefaultParameterSetName = 'Me',
                   SupportsPaging = $true)]
    [OutputType([Smartsheet.Api.Models.UserProfile], ParameterSetName = 'Me')]
    [OutputType([Smartsheet.Api.Models.User], ParameterSetName = 'List')]
    [OutputType([Smartsheet.Api.Models.UserProfile], ParameterSetName = 'UserID')]
    [OutputType([Smartsheet.Api.Models.User], ParameterSetName = 'Email')]
    Param
    (
        [Parameter(ParameterSetName = 'UserID')]
        [long]
        $UserID,
        [Parameter(ParameterSetName = 'Email')]
        [string[]]
        $Email,
        [Parameter(ParameterSetName = 'List')]
        [switch]
        $List,
        [Parameter(ParameterSetName = 'Me')]
        [switch]
        $Me
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
        Try {
            Switch ($PSCmdlet.ParameterSetName) {
                "UserID" {
                    $script:SmartSheetClient.UserResources.GetUser($UserID)
                }
                "Email" {
                    $Script:SmartsheetClient.UserResources.ListUsers($Email, $PagingParams).Data
                }
                
                "List" {
                    $Script:SmartsheetClient.UserResources.ListUsers($null, $PagingParams).Data
                }
                "Me" {
                    $script:SmartSheetClient.UserResources.GetCurrentUser()
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
