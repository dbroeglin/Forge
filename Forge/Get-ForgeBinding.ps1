function Get-ForgeBinding {
    <#
    .SYNOPSIS
        Get-ForgeBinding synopsis.

    .DESCRIPTION
        Get-ForgeBinding description.

    .EXAMPLE
        Get-ForgeBinding #...
    #>
    [CmdletBinding()]
    Param(
        [String]$ContextName = $(Get-CallerModuleName)
    )

    return (Get-ForgeContext -ContextName $ContextName).Binding
}
