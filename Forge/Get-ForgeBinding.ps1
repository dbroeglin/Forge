function Get-ForgeBinding {
    <#
    .SYNOPSIS
        Returns the forge binding.

    .DESCRIPTION
        Returns the forge binding associated with the current caller's module name
        or the given context name.

    .EXAMPLE
        Return the forge binding associated with the caller's module name.

        Get-ForgeBinding

    .EXAMPLE

        Return the forge binding associated with the given context name.

        Get-ForgeBinding -ContextName Foo
    #>
    [CmdletBinding()]
    Param(
        [String]$ContextName = $(Get-CallerModuleName)
    )

    return (Get-ForgeContext -ContextName $ContextName).Binding
}
