function New-ForgeDirectory {
    <#
    .SYNOPSIS
        Generates a directory.

    .DESCRIPTION
        New-ForgeDirectory creates a directory where the code is being
        generated.

    .EXAMPLE
        New-ForgeDirectory -Destination "Tests"

        Generates a Tests directory.

    .PARAMETER Destination 

        Relative name of the directory to create.        
    #>
    [CmdletBinding()]
    Param(
	    [Alias("Dest")]
        [String]$Destination,

        [String]$ContextName = $(Get-CallerModuleName)
    )
    $Destination = Join-Path (Get-ForgeContext -ContextName $ContextName).DestinationPath $Destination

    New-Item -Type Directory -Path $Destination > $Null
}
