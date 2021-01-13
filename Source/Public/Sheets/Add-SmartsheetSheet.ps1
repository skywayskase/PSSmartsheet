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
    
    [CmdletBinding(DefaultParameterSetName = 'Folder')]
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
        [int]
        $WorkspaceID,
        [Parameter(ParameterSetName = 'Folder')]
        [int]
        $FolderID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            $PSCmdlet.ThrowTerminatingError("Smartsheet API Client has not yet been invoked. Please run Invoke-SmartsheetClient and try again.")
        }
        $NewSheet = [Smartsheet.Api.Models.Sheet+CreateSheetBuilder]::($Name,$Column).Build()
    }
    Process {
        If ($PsCmdlet.ParameterSetName -eq 'Workspace') {
            Try {
                $Script:SmartsheetClient.WorkspaceResources.SheetResources.CreateSheet(
                    $WorkspaceID,
                    $NewSheet
                )
            }
            Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
        ElseIf ($PsCmdlet.ParameterSetName -eq 'Folder') {
            Try {
                $Script:SmartsheetClient.FolderResources.SheetResources.CreateSheet(
                    $FolderID,
                    $NewSheet
                )
            }
            Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
        Else {
            Try {
                $Script:SmartsheetClient.SheetResources.CreateSheet(
                    $NewSheet
                )
            }
            Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
    }
}
