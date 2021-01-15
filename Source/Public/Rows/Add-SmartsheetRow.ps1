Function Add-SmartsheetRow {
<#
    .SYNOPSIS
        Inserts one or more rows into the sheet specified.
    
    .DESCRIPTION
        Inserts one or more rows into the sheet specified.
    
    .PARAMETER SheetId
        The Id of the sheet to add rows to.
    
    .PARAMETER Rows
        One or more Row Objects to add to the specified sheet.
    
    .EXAMPLE
        		PS C:\> Add-SmartsheetRow -SheetId $value1 -Rows $value2
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Row[]]
        $Rows
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
    }
    Process {
        Try {
            $Script:SmartsheetClient.SheetResources.RowResources.AddRows(
                $SheetId,
                $Rows
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
