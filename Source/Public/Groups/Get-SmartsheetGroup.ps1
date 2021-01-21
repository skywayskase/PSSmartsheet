Function Get-SmartsheetGroup {
<#
    .SYNOPSIS
        Retrieves information about a specified group or a list of all groups in the org.
    
    .DESCRIPTION
        Retrieves information about a specified group or a list of all groups in the org. When specifying a specific group, an array of group memebers is also returned.
    
    .PARAMETER GroupID
        The group ID of a specific group
    
    .EXAMPLE
        Get-SmartsheetGroup
    
    .EXAMPLE
        Get-SmartsheetGroup -GroupID '6932724448552836'
    
#>
    
    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.Group])]
    Param
    (
        [Parameter(ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [long[]]
        $GroupID
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            Throw "Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again."
        }
        $PagingParams = [Smartsheet.Api.Models.PaginationParameters]::new($true, $null, $null)
    }
    Process {
        If ($GroupID) {
            ForEach ($group In $GroupID) {
                Try {
                    $script:SmartsheetClient.GroupResources.GetGroup($group)
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
        Else {
            Try {
                $script:SmartsheetClient.GroupResources.ListGroups($PagingParams).Data
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
}
