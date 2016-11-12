function Get-CallerModuleName {
    <#
    .SYNOPSIS
        Returns the caller's module name.

    .DESCRIPTION
        Gets the caller's module name by retrieving it from the CallStack invokation
        information.

    .EXAMPLE
        Get-CallerModuleName
    #>
    [CmdletBinding()]
    Param(
    )

    (Get-PSCallStack)[1].InvocationInfo.MyCommand.ModuleName
}
