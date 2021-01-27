Function New-SSRowObject {
<#
    .SYNOPSIS
        Builds a row object used to add or update a row on a sheet.

    .DESCRIPTION
        Builds a row object used to add or update a row on a sheet.

    .PARAMETER Cells
        Cell objects to add or update in the row

    .PARAMETER ToTop
        Adds or moves the row to the top of the sheet

    .PARAMETER ToBottom
        Adds or moves the row to the bottom of the sheet

    .PARAMETER ParentId
        Adds or moves the row to the first child of the specified Id.

    .PARAMETER SiblingId
        Adds or moves the row to the next location below the the specified row at same hierarchical level.
        Can be paried with "Above" to place above the specified row.

    .PARAMETER Above
        When specified, adds or moves the row above the row specified in "SiblingId" at the same hierarchical level

    .PARAMETER Expanded
        Indicates whether the row is expanded or collapsed.

    .PARAMETER Locked
        Indicates that the row will be locked.

    .PARAMETER Indent
        The number of times to indent the row

    .PARAMETER Outdent
        The number of times to outdent the row

    .PARAMETER Id
        Id of a row to update

    .EXAMPLE
        $Cell1 = New-SSCellObject -ColumnId '7960873114331012' -Value $true
        $Cell2 = New-SSCellObject -ColumnId '642523719853956' -Value "Enabled"
        $Row1 = NewSSRowObject -ToBottom -Cells $Cell1,$Cell2

#>

    [CmdletBinding()]
    [OutputType([Smartsheet.Api.Models.Row])]
    Param
    (
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Cell[]]
        $Cells,
        [switch]
        $ToTop,
        [switch]
        $ToBottom,
        [ValidateNotNullOrEmpty()]
        [long]
        $ParentId,
        [ValidateNotNullOrEmpty()]
        [long]
        $SiblingId,
        [switch]
        $Above,
        [switch]
        $Expanded,
        [switch]
        $Locked,
        [int]
        $Indent,
        [int]
        $Outdent,
        [ValidateNotNullOrEmpty()]
        [Alias('RowId')]
        [long]
        $Id
    )

    Process {
        $RowObj = [Smartsheet.Api.Models.Row]::new()
        $PSBoundParameters.Keys.ForEach{
            $RowObj.$_ = $PSBoundParameters[$_]
        }
        $RowObj
    }
}
