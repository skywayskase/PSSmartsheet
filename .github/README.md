# PSSmartsheet
[![BuildStatus](https://github.com/skywayskase/PSSmartsheet/workflows/Build%20and%20Deploy/badge.svg)](https://github.com/skywayskase/PSSmartsheet/actions?query=workflow%3A%22Build+and+Deploy%22)
## Description ##
Powershell Module for interacting with the Smartsheet API.

I wrote this module part as a learning exercise, but also to be used by the scripts I've written for work. It is by no means feature complete. I'm hoping that others may find it usefull, and even be able to contribute to make it better.

## Installation ##
This module is available for download on the Powershell Gallery at https://www.powershellgallery.com/packages/PSSmartsheet/.
You can install in with the following Powershell command:

```Powershell
Install-Module -Name PSSmartsheet
```

You can also simply clone this repo and import the .psd1 file manually.

## Getting Started ##
To use PSSmartsheet, you'll need to have an API token. To get an API token, please follow the instructions [here](https://smartsheet-platform.github.io/api-docs/#raw-token-requests)

Once you have a token, and you've installed/imported PSSmartsheet, the first command you'll want to run is:
```Powershell
Initialize-SmartsheetClient -AccessToken $AVariableRepresentingYourToken
```
If you don't, most of the commands will yell at you to do so anyway.

## Code of Conduct
Please adhere to our [Code of Conduct](https://github.com/skywayskase/PSSmartsheet/blob/main/.github/CODE_OF_CONDUCT.md) when interacting with the repo.

## Contributing ##
Want to help make this module even better? Awesome!
Please check out our [Contribution Guidelines](https://github.com/skywayskase/PSSmartsheet/blob/main/.github/CONTRIBUTING.md)!

## Disclaimer ##
This module is not built or supported by Smartsheet and they will likely be unable to help you troubleshoot this module.
That said, their support team is pretty great and they should be able to help you with any questions regarding the application itself and/or the API itself.
