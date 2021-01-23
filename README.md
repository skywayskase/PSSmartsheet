# PSSmartsheet

## Description ##
Powershell Module for interacting with the Smartsheet API.

I wrote this module part as a learning excersize, but also to be used by the scripts I've written for work. It is by no means feature complete. I'm hoping that other may find it usefull, and even be able to contribute to make it better.

## Installation ##
This module is available for download on the Powershell Gallery at https://www.powershellgallery.com/packages/PSSmartsheet/.
You can install in with the following Powershell command:

`Install-Module -Name PSSmartsheet`

You can also simply clone this repo and import the PSD1 file manually.

## Getting Started ##
To use PSSmartsheet, you'll need to have an API token. To get an API token, please follow the instructions [here](https://smartsheet-platform.github.io/api-docs/#raw-token-requests)

Once you have a token, and you've installed/imported PSSmartsheet, the first command you'll want to run is:
`Initialize-SmartsheetClient -AccessToken $AVariableRepresentingYourToken`
If you don't, most of the commands will yell at you to do so anyway.

## Code of Conduct
Please adhere to our [CODE of Conduct](https://github.com/skywayskase/PSSmartsheet/blob/main/CODE_OF_CONDUCT.md) when interacting with the repo.

## Contributing ##
Want to help make this module even better? Awesome!
Please check out our [Contribution Guidelines](https://github.com/skywayskase/PSSmartsheet/blob/main/CONTRIBUTING.md)!

### Please Note ###
While I am/was an employee of Smartsheet at the time that I wrote this, they are not responsible for this module and will likely be unable to help you troubleshoot this module.
That said, their support team is pretty great and they should be able to help you with any questions regarding the application itself and/or the API itself.