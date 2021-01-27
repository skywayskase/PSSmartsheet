Function Add-SmartsheetSheetFromTemplate {
<#
    .SYNOPSIS
        Creates a sheet from a template

    .DESCRIPTION
        Creates a sheet from a template in either the user's "Sheets" folder, or the specified folder or workspace

    .PARAMETER Name
        Name of the new sheet

    .PARAMETER FromID
        Template Id from which to create the sheet.

    .PARAMETER Includes
        Additional parameter to create a sheet from template. A comma-separated list of elements to copy from the template.

    .PARAMETER WorkspaceID
        Workspace Id where the sheet will be created

    .PARAMETER FolderID
        Folder Id where the sheet will be created

    .PARAMETER HomeFolder
        Indicates that the new sheet should be created in the user's "Sheets" folder.

    .EXAMPLE
        Add-SmartsheetSheetFromTemplate -Title "A new sheet" -FromID '7679398137620356' -Include ATTACHMENTS,DISCUSSIONS

    .NOTES
        Additional information about the function.
#>

    [CmdletBinding(DefaultParameterSetName = 'Home')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification='Param used for ParameterSetName matching')]
    Param
    (
        [Parameter(Mandatory = $true)]
        [Alias('Title')]
        [string]
        $Name,
        [Parameter(Mandatory = $true)]
        [Alias('CopyFrom', 'TemplateID')]
        [long]
        $FromID,
        [Smartsheet.Api.Models.TemplateInclusion[]]
        $Includes = $null,
        [Parameter(ParameterSetName = 'Workspace',
                   Mandatory = $true)]
        [long]
        $WorkspaceID,
        [Parameter(ParameterSetName = 'Folder',
                   Mandatory = $true)]
        [long]
        $FolderID,
        [Parameter(ParameterSetName = 'Home')]
        [switch]
        $HomeFolder
    )

    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $NewSheet = [Smartsheet.Api.Models.Sheet+CreateSheetFromTemplateBuilder]::New($Name, $FromID).Build()
    }
    Process {
        Try {
            If ($PsCmdlet.ParameterSetName -eq 'Workspace') {
                $Script:SmartsheetClient.WorkspaceResources.SheetResources.CreateSheetFromTemplate(
                    $WorkspaceID,
                    $NewSheet,
                    $Includes
                )
            }
            ElseIf ($PsCmdlet.ParameterSetName -eq 'Folder') {
                $Script:SmartsheetClient.FolderResources.SheetResources.CreateSheetFromTemplate(
                    $FolderID,
                    $NewSheet,
                    $Includes
                )
            }
            Else {
                $Script:SmartsheetClient.SheetResources.CreateSheetFromTemplate(
                    $NewSheet,
                    $Includes
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
