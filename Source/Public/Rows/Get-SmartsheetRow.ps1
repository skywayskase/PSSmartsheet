Function Get-SmartsheetRow {
<#
    .SYNOPSIS
        Retrieves the specified row
    
    .DESCRIPTION
        Retrieves the specified row
    
    .PARAMETER SheetID
        Sheet Id of the sheet being accessed.
    
    .PARAMETER RowID
        Row Id in the sheet being accessed.
    
    .PARAMETER Include
        A comma-separated list of elements to include in the response.
    
    .PARAMETER Exclude
        A comma-separated list of optional elements to not include in the response
    
    .EXAMPLE
        		PS C:\> Get-SmartsheetRow -SheetID $value1 -RowID $value2
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.Row])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $RowID,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.RowInclusion[]]
        $Include = $null,
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.RowExclusion[]]
        $Exclude = $null
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $script:SmartsheetClient.SheetResources.RowResources.GetRow(
                $SheetID,
                $RowID,
                $Include,
                $Exclude
            )
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
