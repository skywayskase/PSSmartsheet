Function Search-SmartsheetSheets {
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
            Throw "Smartsheet API Client has not yet been invoked. Please run Invoke-SmartsheetClient and try again."
        }
    }
    Process {
        If ($SheetID) {
            Try {
                $Script:SmartsheetClient.SearchResources.SearchSheet(
                    $SheetID,
                    $Query
                )
            }
            Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
        Else {
            Try {
                $script:SmartsheetClient.SearchResources.Search($Query)
            }
            Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
    }
}
