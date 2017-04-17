$Script:ForgeContexts = @{}

function Initialize-ForgeContext {
    <#
    .SYNOPSIS
        Initializes the context in which all generation fonctions will work.

    .DESCRIPTION
        Sets up the context for other Forge functions to reuse.

    .EXAMPLE
        Initialize-ForgeContext -SourceRoot (Join-Path $PSScriptRoot "Templates") -DestinationPath $Path
    #>
    [CmdletBinding()]
    Param(
        [String]$SourceRoot,

        [Parameter(Mandatory = $true)]
        [String]$DestinationPath,

        [Hashtable]$Binding = @{},

        [String]$ContextName = $(Get-CallerModuleName)
    )   

    $Script:FileConflictConfirmYesToAll = $False
    $Script:FileConflictConfirmNoToAll = $False

    $Script:ForgeContexts[$ContextName] = @{
        SourceRoot                  = $SourceRoot
        DestinationPath             = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($DestinationPath)
        Binding                     = $Binding
    }            
}
