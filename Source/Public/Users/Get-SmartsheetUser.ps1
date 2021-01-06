Function Get-SmartsheetUsers {
<#
    .SYNOPSIS
        Returns specified Smartsheet user or list of users
    
    .DESCRIPTION
        Returns the specified Smartsheet user or a list of users
    
    .PARAMETER UserID
        A description of the UserID parameter.
    
    .PARAMETER Email
        A description of the Email parameter.
    
    .PARAMETER List
        A description of the List parameter.
    
    .PARAMETER Me
        A description of the Me parameter.
    
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
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'Me',
                   SupportsPaging = $true)]
    [OutputType([Smartsheet.Api.Models.UserProfile], ParameterSetName = 'Me')]
    [OutputType([Smartsheet.Api.Models.User], ParameterSetName = 'List')]
    [OutputType([Smartsheet.Api.Models.UserProfile], ParameterSetName = 'UserID')]
    [OutputType([Smartsheet.Api.Models.User], ParameterSetName = 'Email')]
    Param
    (
        [Parameter(ParameterSetName = 'UserID',
                   Mandatory = $true)]
        [int]
        $UserID,
        [Parameter(ParameterSetName = 'Email',
                   Mandatory = $true)]
        [string[]]
        $Email,
        [Parameter(ParameterSetName = 'List',
                   Mandatory = $true)]
        [switch]
        $List,
        [Parameter(ParameterSetName = 'Me',
                   Mandatory = $true)]
        [switch]
        $Me
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been invoked. Please run Invoke-SmartsheetClient and try again."
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
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
}
