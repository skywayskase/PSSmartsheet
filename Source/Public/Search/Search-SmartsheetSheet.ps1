Function Search-SmartsheetSheet {
<#
    .SYNOPSIS
        Searches for the specified text in a sheet.
    
    .DESCRIPTION
        Searches for the specified text in a sheet. By default will search all sheets the user has access two unless a sheetID is specified
    
    .PARAMETER Query
        Text with which to perform the search.
    
    .PARAMETER SheetID
        Sheet Id of the sheet being searched
    
    .EXAMPLE
        PS C:\> Search-SmartsheetSheets -Query 'Value1'
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.SearchResult])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Query,
        [long]
        $SheetID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            If ($SheetID) {
                $Script:SmartsheetClient.SearchResources.SearchSheet(
                    $SheetID,
                    $Query
                )
            }
            Else {
                $script:SmartsheetClient.SearchResources.Search($Query)
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
