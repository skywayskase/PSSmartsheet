Function Add-SmartsheetGroup {
<#
    .SYNOPSIS
        Creates a new Group
    
    .DESCRIPTION
        Creates a new Group
    
    .PARAMETER GroupObject
        The group object created using New-SSGroupObject
    
    .PARAMETER Name
        Name of the group to create.
        NOTE: Must be unique accross org
    
    .PARAMETER Description
        A description of the new group to create
    
    .PARAMETER MemberEmail
        Email address(es) of user(s) to initially populate the new group with.
    
    .EXAMPLE
        		PS C:\> Add-SmartsheetGroup
    
    .NOTES
        This operation is only available to group administrators and system administrators.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'Params')]
    Param
    (
        [Parameter(ParameterSetName = 'GroupObject',
                   ValueFromPipeline = $true)]
        [Alias('InputObject')]
        [Smartsheet.Api.Models.Group[]]
        $GroupObject,
        [Parameter(ParameterSetName = 'Params',
                   Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,
        [Parameter(ParameterSetName = 'Params')]
        [string]
        $Description = $null,
        [Parameter(ParameterSetName = 'Params')]
        [ValidatePattern('^[^@\s]+@[^@\s]+\.[^@\s]+$')]
        [string[]]
        $MemberEmail
    )
    
    Begin {
        If ([String]::IsNullOrEmpty($Script:SmartsheetClient)) {
            $PSCmdlet.ThrowTerminatingError("Smartsheet API Client has not yet been initialized. Please run Initialize-SmartsheetClient and try again.")
        }
    }
    Process {
        If ($PSCmdlet.ParameterSetName -eq 'Params') {
            If ($MemberEmail) {
                $GroupObject = New-SSGroupObject -Name $Name -Description $Description -MemberEmail $MemberEmail
            }
            Else {
                $GroupObject = New-SSGroupObject -Name $Name -Description $Description
            }
            
        }
        ForEach ($GO In $GroupObject) {
            Try {
                $script:SmartsheetClient.GroupResources.CreateGroup($GO)
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
