# Changelog

## 0.1.0 - 2021-01-22
- Published to Powershell Gallery

## 0.1.1 - 2021-01-26
- [Issue #4](https://github.com/skywayskase/PSSmartsheet/issues/4)
    - Removed DefaultParameterSetName attribute from function

## 0.1.2 - 2021-01-26
- [Issue #4](https://github.com/skywayskase/PSSmartsheet/issues/4)
    - Undid changes from 0.1.1 and improved logic

## 0.1.3 - 2021-01-27
- Miscellaneous
    - Fixed some parameter attributes for `New-SSCellHyperlink`, `Add-SmartsheetSheet`, `Add-SmartsheetSheetFromTemplate`, and `Move-SmartsheetSheet`.
## 0.1.4 - 2021-03-08
- Miscellaneous
    - Fixed issue where `New-SSGroupObject` returned both pre-built object and built object

## 0.1.5 - 2022-07-20
- [Issue #5](https://github.com/skywayskase/PSSmartsheet/issues/5)
    - Corrected misspelled variable in `Get-SmartsheetSheet`
- [Issue #6](https://github.com/skywayskase/PSSmartsheet/issues/6)
    - Updated type on `$ModifiedSince` attribute to allow it to be null

## 0.1.6 - 2022-08-19
- Updated assembly files

## 0.1.7 - 2023-07-21
- Updated assembly files
- Updated module requirements

## 0.1.8 - 2023-07-24
- Added 'level' parameter to `Read-SmartsheetSheet`

## 0.1.9 - 2023-08-02
- Fixed issue with `New-SSCellObject` failing when neither a LinkObject or HyperlinkObject are provided

## 0.2.0 - 2023-08-31
- Fixed name of New-SSCellHyperlinkObject file

## 0.2.1 - 2024-08-07