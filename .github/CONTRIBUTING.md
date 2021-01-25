# Contributing to PSSmartsheet

<!-- TOC -->

* [Contributing to PSGSmartsheet](#contributing-to-pssmartsheet)
    * [Git and Pull requests](#git-and-pull-requests)
    * [Overview](#overview)
        * [Step by Step (High-Level)](#step-by-step-high-level)
        * [Contributing Guidelines](#contributing-guidelines)
    * [Adding or Updating Functions](#adding-or-updating-functions)
        * [Smartsheet API Documentation](#smartsheet-api-documentation)

<!-- /TOC -->

Thank you for your interest in helping PSSmartsheet grow! Below you'll find some guidelines around developing additional features and squashing bugs, including some how-to's to get started quick, general style guidelines, etc.


## Git and Pull requests

* Contributions are submitted, reviewed, and accepted using Github pull requests. [Read this article](https://help.github.com/articles/using-pull-requests) for some details. We use the _Fork and Pull_ model, as described there. More info can be found here: [Forking Projects](https://guides.github.com/activities/forking/)
* Please make sure to leave the `Allow edits from maintainers` box checked when submitting PR's so that any edits can be made by maintainers of the repo directly to the source branch and into the same PR. More info can be found here: [Allowing changes to a pull request branch created from a fork](https://help.github.com/articles/allowing-changes-to-a-pull-request-branch-created-from-a-fork/#enabling-repository-maintainer-permissions-on-existing-pull-requests)

## Overview

### Step by Step (High-Level)

Here's the overall flow of making contributions:
1. Fork the repo
2. Make your edits / additions on your fork
3. Push your changes back to your fork on GitHub
4. Submit a pull request
5. Pull request is reviewed. Any necessary edits / suggestions will be made
6. Once changes are approved, the pull request is merged into the origin's main branch and deployed to the PowerShell Gallery

### Contributing Guidelines

Please follow these guidelines for any content being added:

* **ALL functions must...**
    * work in the supported PowerShell versions by this module
    * work in any OS;
        * any code that includes paths must build the path using OS-agnostic methods, i.e. by using `Resolve-Path`, `Join-Path` and `Split-Path`
        * paths also need to use correct casing, as some OS's are case-sensitive in terms of paths
* **Public functions must...**
    * include comment-based help
    * include Write-Verbose calls to describe what the function is doing (I admit this is something I'm still working on myself)
    * be placed in the correct API/use-case folder in the Public sub-directory of the module path (if it's a new API/use-case, create the new folder as well)
    * use `SupportsShouldProcess` if...
        * the function's verb is `Remove`.
        * it can be included on `Set` functions as well, if felt that the actions executed by the function should be guarded
        * `Get` functions should **never** need `SupportsShouldProcess`
        * All functions that use `SupportsShouldProcess` must include a `Force` switch in the parameters
* **Every Pull Request must...**
    > These can be added in during the pull request review process, but are nice to have if possible
    * have the module version bumped appropriately in the manifest (Major for any large updates, Minor for any new functionality, Patch for any hotfixes)
    * have an entry in the [Changelog](https://github.com/skywayskase/PSSmartsheet/blob/main/CHANGELOG.md) describing what was added, updated and/or fixed with this version number
        * *Please follow the same format already present*

### Adding or Updating Functions

## Smartsheet API Documentation

Smartsheet's API documentation can be found [here](https://smartsheet-platform.github.io/api-docs/?csharp).
I think it's pretty well written and includes plenty of examples.
