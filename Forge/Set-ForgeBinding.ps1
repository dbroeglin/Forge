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
        [Hashtable]$Binding
    )

    $Script:ForgeContext.Binding = $Binding
}
