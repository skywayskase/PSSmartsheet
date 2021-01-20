<#
    .SYNOPSIS
        Inserts one or more columns into the sheet specified.
    
    .DESCRIPTION
        Inserts one or more columns into the sheet specified.
    
    .PARAMETER SheetId
        The ID of the sheet to add columns to.
    
    .PARAMETER Column
        One or more column objects to add to the specified sheet.
    
    .EXAMPLE
        		PS C:\> Add-SmartsheetColumn -SheetId $value1 -Column $value2
    
    .NOTES
        If multiple columns are specified in the request, the index attribute must be set to the same value for all columns.
#>
Function Add-SmartsheetColumn {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Column[]]
        $Column
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $script:SmartsheetClient.SheetResources.ColumnResources.AddColumns(
                $SheetId,
                $Column
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
