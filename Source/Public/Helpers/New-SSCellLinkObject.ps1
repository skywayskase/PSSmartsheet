Function New-SSCellLinkObject {
<#
    .SYNOPSIS
        Builds a CellLink object that can be added to a cell object

    .DESCRIPTION
        Builds a CellLink object that can be added to a cell object to link data from a cell in one sheet to a cell in another sheet.

    .PARAMETER ColumnId
        The ColumnId of the cell to link

    .PARAMETER RowId
        The RowId of the cell to link

    .PARAMETER SheetId
        The SheetId of the cell to link

    .EXAMPLE
        $CellLink = New-SSCellLinkObject -ColumnId '1888812600190852' -RowId '6572427401553796' -SheetId '2068827774183300'
        $Cell = New-SSCellObject -ColumnId '7518312134403972' -LinkInFromCell $CellLink

    .NOTES
        A given row or cell update operation may contain only link updates, or no link updates.
        Attempting to mix row/cell updates with cell link updates results in error code 1115.
        Additionally, a CellLink object can only be added to an existing cell, so the cell.linkInFromCell attribute is not allowed when POSTing a new row to a sheet.
#>

    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.CellLink])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $ColumnId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $RowId,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId
    )

    $CellLink = [Smartsheet.Api.Models.CellLink]::new()
    $PSBoundParameters.Keys.ForEach{
        $CellLink.$_ = $PSBoundParameters[$_]
    }
    $CellLink
}
