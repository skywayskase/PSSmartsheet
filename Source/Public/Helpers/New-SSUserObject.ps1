Function New-SSUserObject {
<#
    .SYNOPSIS
        Builds a Smartsheet User Object
    
    .DESCRIPTION
        Builds a Smartsheet User Object that can be used to add or update a user.
    
    .PARAMETER Email
        User's primary email address.
    
    .PARAMETER ID
        A description of the ID parameter.
    
    .PARAMETER FirstName
        User's first name.
    
    .PARAMETER LastName
        User's last name.
    
    .PARAMETER LicensedSheetCreator
        Indicates whether the user is a licensed user (can create and own sheets).
    
    .PARAMETER Admin
        Indicates whether the user is a system admin (can manage user accounts and organization account).
    
    .PARAMETER GroupAdmin
        Indicates whether the user is a group admin (can create and edit groups).
    
    .PARAMETER ResourceViewer
        Indicates whether the user is a resource viewer (can access resource views).
    
    .EXAMPLE
        New-SSUserObject -Email "test@example.com" -LicensedSheetCreator
        
        Returns a user object with the email of "test@example.com" that will be a licensed sheet creator that can be fed to Add-SmartsheetUser creating the account.
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'NewUserObject')]
    [OutputType([Smartsheet.Api.Models.User])]
    Param
    (
        [Parameter(ParameterSetName = 'NewUserObject',
                   Mandatory = $true)]
        [string]
        $Email,
        [Parameter(ParameterSetName = 'UpdateUserObject',
                   Mandatory = $true)]
        [int]
        $ID,
        [string]
        $FirstName,
        [string]
        $LastName,
        [Alias('Licensed')]
        [switch]
        $LicensedSheetCreator = $false,
        [Alias('IsAdmin')]
        [switch]
        $Admin,
        [switch]
        $GroupAdmin,
        [switch]
        $ResourceViewer
    )
    
    Process {
        If ($PSCmdlet.ParameterSetName -eq 'NewUserObject') {
            $userObj = [Smartsheet.Api.Models.User+AddUserBuilder]::new($null, $false, $false).Build()
        }
        ElseIf ($PSCmdlet.ParameterSetName -eq 'UpdateUserObject') {
            $userObj = [Smartsheet.Api.Models.User+UpdateUserBuilder]::new($null, $false, $false).Build()
        }
        $PSBoundParameters.Keys.ForEach{
            $userObj.$_ = $PSBoundParameters[$_]
        }
        $userObj
    }
}

    