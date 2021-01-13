Function New-SSColumnObject {
<#
    .SYNOPSIS
        Builds a Smartsheet Column Object
    
    .DESCRIPTION
        Builds a Smartsheet Column Object that can be used to add or update columns on a sheet
    
    .PARAMETER Title
        A description of the Title parameter.
    
    .PARAMETER Index
        Column index or position. Defaults to '0'. If multiple columns are added to a sheet, the index attribute must be set to the same value for all columns. Columns are inserted into the sheet starting at the specified position (index), in the sequence that the columns appear in the request.
    
    .PARAMETER ColumnType
        The type used for the column. Defaults to "TEXT_NUMBER".
    
    .PARAMETER Primary
        A description of the Primary parameter.
    
    .PARAMETER ID
        A description of the ID parameter.
    
    .EXAMPLE
        		PS C:\> New-SSColumnObject -Title 'Value1'
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Title,
        [int]
        $Index = 0,
        [Smartsheet.Api.Models.ColumnType]
        $ColumnType = "TEXT_NUMBER",
        $Primary,
        $ID
    )
    #TODO: Place script here
}
