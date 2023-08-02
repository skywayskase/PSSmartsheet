Function New-SSCellObject {
<#
    .SYNOPSIS
        Builds a new cell object that can be used to create or update rows in sheets

    .DESCRIPTION
        Builds a new cell object that can be used to create or update rows in sheets

    .PARAMETER ColumnID
        The Id of the column that the cell is located in

    .PARAMETER Value
        A string, a number, or a Boolean value

    .PARAMETER OverrideValidation
        (Admin only) Indicates whether the cell value can contain a value outside of the validation limits (value = true).

    .PARAMETER Hyperlink
        A hyperlink to a URL, sheet, reportor dashboard.
        When used, the 'Value' parameter can be a string or null. If null:
        If the hyperlink is a URL link, the cell's value is set to the URL itself.
        If the hyperlink is a dashboard, report, or sheet link, the cell's value is set to the dashboard, report, or sheet name.

    .PARAMETER LinkInFromCell
        An inbound link from a cell in another sheet. This cell's value mirrors the linked cell's value.

    .EXAMPLE
        $Cell = New-SSCellObject -ColumnId '5005385858869124'

#>

    [CmdletBinding(DefaultParameterSetName = 'NoLink')]
    [OutputType([Smartsheet.Api.Models.Cell])]
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [long]
        $ColumnID,
        [AllowNull()]
        [object]
        $Value = $null,
        [Parameter(DontShow = $true)]
        [switch]
        $OverrideValidation,
        [Parameter(ParameterSetName = 'Hyperlink')]
        [ValidateNotNullOrEmpty()]
        [Smartsheet.Api.Models.Hyperlink]
        $Hyperlink,
        [Parameter(ParameterSetName = 'CellLink')]
        [ValidateNotNullOrEmpty()]
        [Alias('CellLink')]
        [Smartsheet.Api.Models.CellLink]
        $LinkInFromCell
    )

    Process {
        If ($PSCmdlet.ParameterSetName -eq 'CellLink') {
            $Value = $null
        }
        $CellObject = [Smartsheet.Api.Models.Cell+AddCellBuilder]::new(
            $ColumnID,
            $Value
        ).Build()
        $PSBoundParameters.Keys.ForEach{
            $CellObject.$_ = $PSBoundParameters[$_]
        }
        $CellObject
    }
}
