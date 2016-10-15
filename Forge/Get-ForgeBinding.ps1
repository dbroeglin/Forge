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
    )

    return (Get-ForgeContext).Binding
}
