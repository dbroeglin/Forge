<#
Copyright 2016 Dominique Broeglin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

Import-Module EPS -MinimumVersion "0.2.0"

$SkeletonsPath = "$(Split-Path -Parent $PSScriptRoot)\Forge\Skeletons\Module"


function New-ForgeModule {
    <#
    .SYNOPSIS
        Creates a new module.

    .DESCRIPTION
        Creates a new skeleton module based on the arguments passed to the function.

    .EXAMPLE
        New-ForgeModule -Name MyModule

    .PARAMETER Name
        The name of the new module.

    .PARAMETER Path
        The path where the new module is created.

    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$Path = $Name,

        [String]$Description = "$Name module"
    )

    Process {
        if (!$PSCmdlet.ShouldProcess($Name, "Create module")) {
            return
        }
        $Binding = @{
            Name = $Name        
        }

        New-Item -Type Directory -Path $Path > $Null

        Expand-ForgeTemplate -Name "README.md" -Path "$Path\README.md" -Binding $Binding

        New-Item -Type Directory -Path "$Path\$Name" > $Null
        Expand-ForgeTemplate -Name "Module.psm1" -Path "$Path\$Name\$Name.psm1" -Binding $Binding

        New-ModuleManifest -Path "$Path\$Name\$Name.psd1" -RootModule "$Name.psm1" `
            -ModuleVersion "0.1.0" -Description $Description
        New-Item -Type Directory -Path "$Path\Tests" > $Null
    }
}

function Expand-ForgeTemplate {
    Param(
        [String]$Name,

        [String]$Path,

        [PSCustomObject]$Binding
    )
    $Template = Get-Content -Raw "$SkeletonsPath\$Name.eps"
    Expand-Template -Template $template -Binding $Binding |
        Out-File $Path -Encoding UTF8    
}