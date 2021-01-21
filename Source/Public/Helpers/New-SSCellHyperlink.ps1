Function New-SSCellHyperlinkObject {
<#
    .SYNOPSIS
        Builds a hyperlink object to a URL, a sheet, or a report.
    
    .DESCRIPTION
        Builds a hyperlink object to a URL, a sheet, or a report.
    
    .PARAMETER ReportId
        The ID of a report to link to.
    
    .PARAMETER SheetId
        The ID of a sheet to link to.
    
    .PARAMETER SightId
        The ID of a sight/dashboard to link to.
    
    .PARAMETER URL
        A URL to link to.
    
    .EXAMPLE
        $HyperLink = New-SSCellHyperlinkObject -URL 'https://smartsheet-platform.github.io/api-docs/'
        $Cell = New-SSCellObject -ColumnId '7518312134403972' -HyperLink $HyperLink
    
    .NOTES
        If no parameters are specified, object will reset a hyperlink.
#>
    
    [CmdletBinding(DefaultParameterSetName = 'URL')]
    [OutputType([Smartsheet.Api.Models.Hyperlink])]
    Param
    (
        [Parameter(ParameterSetName = 'Report')]
        [ValidateNotNullOrEmpty()]
        [long]
        $ReportId,
        [Parameter(ParameterSetName = 'Sheet')]
        [ValidateNotNullOrEmpty()]
        [long]
        $SheetId,
        [Parameter(ParameterSetName = 'Sight')]
        [ValidateNotNullOrEmpty()]
        [long]
        $SightId,
        [Parameter(ParameterSetName = 'URL')]
        [ValidatePattern('http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?')]
        [ValidateNotNullOrEmpty()]
        [string]
        $URL
    )
    
    $HyperlinkObj = [Smartsheet.Api.Models.Hyperlink]::new()
    $PSBoundParameters.Keys.ForEach{
        $HyperlinkObj.$_ = $PSBoundParameters[$_]
    }
    $HyperlinkObj
}
