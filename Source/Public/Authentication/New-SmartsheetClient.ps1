Function New-SmartsheetClient {
<#
    .SYNOPSIS
        Returns a Smartsheet Client Object that you can use to make API calls
    .DESCRIPTION
        Returns a Smartsheet Client Object that you can use to make API calls
    .PARAMETER AccessToken
        A description of the AccessToken parameter.
    .PARAMETER AssumedUser
        The email address of a member of your Org that you want to impersonate.
        NOTE: You must have Sys Admin privileges to use this.
    .PARAMETER Gov
        Use this switch if you are interacting with Smartsheet Gov
    .EXAMPLE
        		PS C:\> New-SmartsheetClient -AccessToken 'll352u9jujauoqz4gstvsae05'
#>
    
    [CmdletBinding()]
    [OutputType([Smartsheet.Api.SmartsheetBuilder])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $AccessToken,
        [string]
        $AssumedUser,
        [switch]
        $Gov
    )
    Process {
        If ($Gov) {
            $client = [Smartsheet.Api.SmartsheetBuilder]::new().SetAccessToken($AccessToken).SetBaseURI([Smartsheet.Api.SmartsheetBuilder]::GOV_BASE_URI)
        }
        Else {
            $client = [Smartsheet.Api.SmartsheetBuilder]::new().SetAccessToken($AccessToken)
        }
        If (![string]::IsNullOrWhiteSpace($AssumedUser)) {
            [Void]$Client.SetAssumedUser($AssumedUser)
        }
        $client
    }
}