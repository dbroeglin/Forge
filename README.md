# TestModule PowerShell module

Module TestModule has been generated with Forge.

# Installation

    Install-Module Forge

# Example

The following commands should generate a module named `PoshTodo`:

    New-ForgeModule -Name PoshTodo -License MIT -Author Léa -Email lea@example.com

Would create, in the current directory a scaffold for module `PoshTodo` with the following
structure:

    ./PoshTodo
    ├── LICENSE
    ├── PoshTodo
    │   ├── PoshTodo.psd1
    │   └── PoshTodo.psm1
    ├── README.md
    └── Tests

# Dependencies

## Run time

At run time, the following modules are required:

    Install-Module EPS

## Build time

Additionally, at build time, the following modules are required:

    Install-Module Pester

