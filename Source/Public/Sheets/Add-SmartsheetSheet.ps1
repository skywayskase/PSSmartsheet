Function Add-SmartsheetSheet {
<#
    .SYNOPSIS
        Creates a sheet from scratch

    .DESCRIPTION
        Creates a sheet from scratch in either the user's "Sheets" folder, or the specified folder or workspace

    .PARAMETER Name
        The name for the new sheet.

    .PARAMETER Column
        One or more column objects built using New-SSColumnObject.

    .PARAMETER WorkspaceID
        The ID of a workspace to create the sheet in.

    .PARAMETER FolderID
        The ID of a folder to create the sheet in.

    .EXAMPLE
        $column1 = New-SSColumnObject -Title "Column 1" -Primary
        $column2 = New-SSColumnObject -Title "Second Column" -Type CHECKBOX
        Add-SmartsheetSheet -Column $column1,$column2

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
