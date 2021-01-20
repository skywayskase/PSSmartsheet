Function New-SSColumnObject {
<#
    .SYNOPSIS
        Builds a Smartsheet Column Object
    
    .DESCRIPTION
        Builds a Smartsheet Column Object that can be used to add or update columns on a sheet
    
    .PARAMETER Title
        The title of the column. Required if the column is new.
    
    .PARAMETER Description
        The description of the column.
    
    .PARAMETER Index
        Column index or position. Defaults to '0'. If multiple columns are added to a sheet, the index attribute must be set to the same value for all columns. Columns are inserted into the sheet starting at the specified position (index), in the sequence that the columns appear in the request.
    
    .PARAMETER Type
        The type used for the column. Defaults to "TEXT_NUMBER".
    
    .PARAMETER Primary
        Indicates if the column will be the "Primary" column of the sheet.
        NOTE: The praimary column can only have a type of "TEXT_NUMBER". A sheet can only have 1 primary column.
    
    .PARAMETER ID
        The ID of a column to update.
    
    .PARAMETER Hidden
        Indicates if the column will be hidden.
    
    .PARAMETER SystemColumnType
        System columns represent data that is filled in by Smartsheet and whose values cannot be changed by the user.
    
    .PARAMETER Width
        The display width of the column in pixels.
    
    .EXAMPLE
        PS C:\> New-SSColumnObject -Title 'Value1'
    
    .NOTES
        Additional information about the function.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'RegularColumn')]
    Param
    (
        [ValidateNotNullOrEmpty()]
        [string]
        $Title,
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Description,
        [int]
        $Index = 0,
        [Parameter(ParameterSetName = 'RegularColumn')]
        [ValidateNotNullOrEmpty()]
        [Alias('ColumnType')]
        [Smartsheet.Api.Models.ColumnType]
        $Type = "TEXT_NUMBER",
        [Parameter(ParameterSetName = 'RegularColumn')]
        [switch]
        $Primary,
        [Alias('ColumnID')]
        [long]
        $ID,
        [switch]
        $Hidden,
        [Parameter(ParameterSetName = 'SystemColumn')]
        [Smartsheet.Api.Models.SystemColumnType]
        $SystemColumnType,
        [ValidateNotNullOrEmpty()]
        [long]
        $Width
    )
    
    $ColumnObject = [Smartsheet.Api.Models.Column]::new()
    $PSBoundParameters.Keys.ForEach{
        $ColumnObject.$_ = $PSBoundParameters[$_]
    }
    $ColumnObject
    
}
