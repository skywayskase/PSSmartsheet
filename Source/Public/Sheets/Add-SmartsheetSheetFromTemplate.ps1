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
    
    .EXAMPLE
        PS C:\> Add-SmartsheetSheetFromTemplate
    
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
        [Alias('CopyFrom', 'TemplateID')]
        [long]
        $FromID,
        [Smartsheet.Api.Models.TemplateInclusion[]]
        $Includes = $null,
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
