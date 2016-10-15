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
    )
    return $Script:ForgeContext
}
