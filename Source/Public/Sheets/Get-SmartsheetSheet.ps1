<#
    .SYNOPSIS
        Retrieves a list of sheets
    
    .DESCRIPTION
        Retrieves a list of sheets. By default this will be sheets the calling user has access to, but if the user is a system administrator they can use the "ListOrgSheets" switch to list all sheets owned by members of the organization.
    
    .PARAMETER ListOrgSheets
        Gets a summarized list of all sheets owned by the members of the organization account.
        NOTE: This operation is only available to system administrators
    
    .PARAMETER ModifiedSince
        When specified with a date and time value, response only includes the objects that are modified on or after the date and time specified. If you need to keep track of frequent changes, it may be more useful to use Read-SmartsheetSheet and reference the 'Version' property.
    
    .PARAMETER Include
        A comma-separated list of optional elements to include in the respons.
    
    .EXAMPLE
        Get-SmartsheetSheet
    
    .EXAMPLE
        Get-SmartsheetSheet -ListOrgSheets

#>
Function Get-SmartsheetSheet {
    [CmdletBinding(DefaultParameterSetName = 'Individual')]
    [OutputType([Smartsheet.Api.Models.Sheet[]])]
    Param
    (
        [Parameter(ParameterSetName = 'FullOrg')]
        [switch]
        $ListOrgSheets,
        [datetime]
        $ModifiedSince = $null,
        [Parameter(ParameterSetName = 'Individual')]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.SheetInclusion[]]
        $Include = $null
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
        Try {
            If ($ListOrgSheets) {
                $Script:SmartsheetClient.UserResources.SheetResources.ListOrgSheets(
                    $PagingParams,
                    $ModifiedSince
                ).data
            }
            Else {
                $cript:SmartsheetClient.SheetResources.ListSheets(
                    $Include,
                    $PagingParams,
                    $ModifiedSince
                ).data
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
