# Forge - A set of tools to automate PowerShell code generation

The `Forge` module contains a set of tools to automate PowerShell code generation. It 
does nothing by itself actual generators are published in separate modules named `Forge.*`. 
Take a look at [`Forge.Module`](https://github.com/dbroeglin/Forge.Module) a PowerShell 
module generator.

`Forge` contains support _cmdlets_ that aim at making writing a generator very easy. The most
useful _cmdlets_ are:
* `New-ForgeDirectory`: generates a new directory in the destination path.
* `Copy-ForgeFile`: copies a file from the template directory to the destination path. If the 
file is an EPS template, the template will be expanded.
* `Get-ValueOrGitOrDefault`: is It will return the value passed as an argument or, if the value 
is absent, it looks in `git config key_name` and return the value. If git is absent or no 
config exists, it returns the default value passed as an argument. 

# Installation

    Find-Module Forge | Install-Module

# Dependencies

## Run time

At run time, the following modules are required:

    Install-Module EPS

## Build time

Additionally, at build time, the following modules are required:

    Install-Module Pester

## Similar projects

* https://github.com/PowerShell/Plaster
* https://github.com/LaurentDardenne/Template
* https://github.com/zloeber/PSModuleBuild is based on the excelent Invoke-Build module.
