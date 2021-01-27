Function Initialize-SmartsheetClient {
<#
    .SYNOPSIS
        Creates a Smartsheet Client Object that you can use to make API calls and sets it to the default

    .DESCRIPTION
        Creates a Smartsheet Client Object that you can use to make API calls and sets it to the default

    .PARAMETER AccessToken
        A description of the AccessToken parameter.

    .PARAMETER AssumedUser
        The email address of a member of your Org that you want to impersonate.
        NOTE: You must have Sys Admin privileges to use this.

    .PARAMETER CustomURI
        Use this Param if you are interacting with a custom intance of Smartsheet.
        NOTE: Intended for internal use only

    .PARAMETER DefaultURI
        Use this switch if you are interacting with them main Smartsheet app

    .PARAMETER Gov
        Use this switch if you are interacting with Smartsheet Gov

    .EXAMPLE
        Initialize-SmartsheetClient -AccessToken 'll352u9jujauoqz4gstvsae05'

    .EXAMPLE
        Initialize-SmartsheetClient -AccessToken 'll352u9jujauoqz4gstvsae05' -AssumedUser 'john.doe@example.com'

    .Example
        Initialize-SmartsheetClient -AccessToken 'll352u9jujauoqz4gstvsae05' -Gov

#>

    [CmdletBinding(DefaultParameterSetName = 'DefaultURI')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification='Param used for ParameterSetName matching')]
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $AccessToken,
        [string]
        $AssumedUser,
        [Parameter(ParameterSetName = 'CustomURI',
                   DontShow = $true)]
        [ValidatePattern('http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?')]
        [String]
        $CustomURI,
        [Parameter(ParameterSetName = 'DefaultURI')]
        [Switch]
        $DefaultURI,
        [Parameter(ParameterSetName = 'GovURI')]
        [switch]
        $Gov
    )

    Process {
        Switch ($PSCmdlet.ParameterSetName) {
            "DefaultURI" {
                $client = [Smartsheet.Api.SmartsheetBuilder]::new().SetAccessToken($AccessToken)
            }
            "GovURI" {
                $client = [Smartsheet.Api.SmartsheetBuilder]::new().SetAccessToken($AccessToken).SetBaseURI([Smartsheet.Api.SmartsheetBuilder]::GOV_BASE_URI)
            }
            "CustomURI" {
                $client = [Smartsheet.Api.SmartsheetBuilder]::new().SetAccessToken($AccessToken).SetBaseURI($CustomURI)
            }
        }

        If (![string]::IsNullOrWhiteSpace($AssumedUser)) {
            [Void]$Client.SetAssumedUser($AssumedUser)
        }
        Try {
            [Void]$client.Build().UserResources.GetCurrentUser()
            $script:SmartsheetClient = $Client.Build()
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