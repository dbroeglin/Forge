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
        [String]$Destination = ""
    )
    $Destination = Join-Path $Script:DestinationPath $Destination

    New-Item -Type Directory -Path $Destination > $Null
}