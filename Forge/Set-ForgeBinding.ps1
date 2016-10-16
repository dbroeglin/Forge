function Set-ForgeBinding {
    <#
    .SYNOPSIS
        Set-ForgeBinding synopsis.

    .DESCRIPTION
        Set-ForgeBinding description.

    .EXAMPLE
        Set-ForgeBinding #...
    #>
    [CmdletBinding()]
    Param(
        [Hashtable]$Binding,

        [String]$ContextName = $(Get-CallerModuleName)
    )

    (Get-ForgeContext -ContextName $ContextName).Binding = $Binding
}
