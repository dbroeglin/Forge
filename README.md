# Forge
PowerShell code generation (aka scaffolding) module. Aims at making starting a new 
PowerShell project a snap by using templates to generate scripts or whole projects 
in just one command.

# Getting started

This cmdlet creates a new PowerShell script:

    New-ForgeScript -Name MyScript -Parameters a,b,c

This cmdlet create a new PowerShell module project in the `MyModule` directory:

    New-ForgeModule -Name MyModule