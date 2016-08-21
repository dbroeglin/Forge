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

function New-ForgeScript {
    <#
    .SYNOPSIS
        Creates a new script.

    .DESCRIPTION
        Creates a new skeleton script based on the arguments passed to the function.

    .EXAMPLE
        New-ForgeScript -Name MyScript -Parameters a,b,c

    .PARAMETER Name
        The name of the new script.

    .PARAMETER Parameter
        An array of parameter names for the new script.

    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact='Low')]
    Param(
        [String]$Name = "New-Script",

        [Parameter()]
        [String[]]$Parameter = @()
    )

    Process {
        $Path = "$Name.ps1"
        if (!$PSCmdlet.ShouldProcess($Path, "Create script named $Name")) {
            return
        }

        $CommentParamBlock = ($Parameter | % {
            "    .PARAMETER $_`n        $_ description."
        }) -join "`n`n" 

        $ParamBlock = ($Parameter | % {
            "        `$$_"
        }) -join ",`n" 
        
@"
function $Name {
    <#
    .SYNOPSIS
        $Path synopsis.

    .DESCRIPTION
        $Path description.

    .EXAMPLE
        $Name #...

        Example description

$CommentParamBlock

    #>
    [CmdletBinding()]
    Param(
$ParamBlock
    )
    Begin {
        # Begin block
    }
    Process {
        # Process block
    }
    End {
        # End block
    }
}
"@ | Out-File -Encoding UTF8 -FilePath $Path
    }
}