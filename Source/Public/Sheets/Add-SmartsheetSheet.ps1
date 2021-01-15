Function Add-SmartsheetSheet {
<#
    .SYNOPSIS
        Creates a sheet from scratch
    
    .DESCRIPTION
        Creates a sheet from scratch in either the user's "Sheets" folder, or the specified folder or workspace
    
    .PARAMETER Name
        A description of the Name parameter.
    
    .PARAMETER Column
        A description of the Column parameter.
    
    .PARAMETER WorkspaceID
        A description of the WorkspaceID parameter.
    
    .PARAMETER FolderID
        A description of the FolderID parameter.
    
    .EXAMPLE
        PS C:\> Add-SmartsheetSheet
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [Alias('Title')]
        [string]
        $Name,
        [Parameter(Mandatory = $true)]
        [Smartsheet.Api.Models.Column[]]
        $Column,
        [Parameter(ParameterSetName = 'Workspace')]
        [long]
        $WorkspaceID,
        [Parameter(ParameterSetName = 'Folder')]
        [long]
        $FolderID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $NewSheet = [Smartsheet.Api.Models.Sheet+CreateSheetBuilder]::($Name,$Column).Build()
    }
    Process {
        Try {
            If ($PsCmdlet.ParameterSetName -eq 'Workspace') {
                $Script:SmartsheetClient.WorkspaceResources.SheetResources.CreateSheet(
                    $WorkspaceID,
                    $NewSheet
                )
            }
            ElseIf ($PsCmdlet.ParameterSetName -eq 'Folder') {
                $Script:SmartsheetClient.FolderResources.SheetResources.CreateSheet(
                    $FolderID,
                    $NewSheet
                )
            }
            Else {
                $Script:SmartsheetClient.SheetResources.CreateSheet(
                    $NewSheet
                )
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
