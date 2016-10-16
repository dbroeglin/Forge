function Get-ForgeContext {
    <#
    .SYNOPSIS
        Get-ForgeContext synopsis.

    .DESCRIPTION
        Get-ForgeContext description.

    .EXAMPLE
        Get-FogeContext #...
    #>
    [CmdletBinding()]
    Param(
        [String]$ContextName = $(Get-CallerModuleName)
    )
    
    $Context = $Script:ForgeContexts[$ContextName]
    if (!($Context)) {
        throw "Unable to find context for name '$ContextName', did you call Initialize-ForgeContext ?"
    }
    return $Context
}
