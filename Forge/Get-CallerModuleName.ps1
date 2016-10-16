function Get-CallerModuleName {
    <#
    .SYNOPSIS
        Get-CallerModuleName synopsis.

    .DESCRIPTION
        Get-CallerModuleName description.

    .EXAMPLE
        Get-CallerModuleName #...
    #>
    [CmdletBinding()]
    Param(
    )

    (Get-PSCallStack)[1].InvocationInfo.MyCommand.ModuleName
}
