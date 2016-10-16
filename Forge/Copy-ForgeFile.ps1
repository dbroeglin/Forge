function Copy-ForgeFile {
    <#
    .SYNOPSIS
        Generates a new file based on the source.

    .DESCRIPTION
        Generates a new file based on the source file. The source file comes
        from the template directory and is handled as an EPS template.

    .EXAMPLE
        Copy-ForgeFile -Source "README.md" -Destination "Tests\README.md"

        Generate a 'Tests\README.md' file based on the 'README.md' template.

    .PARAMETER Source

        Template file used to generate the file (relative to the template 
        directory).

    .PARAMETER Destination

        Name of the file to be generated (relative to the generated directory).        
    #>
    [CmdletBinding()]
    Param(
        [String]$Source,

	    [Alias("Dest")]
        [String]$Destination = $Source,

        [String]$ContextName = $(Get-CallerModuleName)
    )

    $Context = Get-ForgeContext -ContextName $ContextName
    $TemplatePath = Join-Path $Context.SourceRoot $Source
    if (!(Test-Path -Type Leaf -Path $TemplatePath)) {
        $TemplatePath = "$TemplatePath.eps"
        if (!(Test-Path -Type Leaf -Path $TemplatePath)) {
            throw "Unable to find either '$Source' or '$Source.eps' source file"
        }
    }

    Write-Verbose "Copying file '$Source' to '$Destination'"
    $Template = Get-Content -Raw $TemplatePath
    $Destination = Join-Path $Context.DestinationPath $Destination

    if (Test-Path -Type Container $Destination) {
        Write-Verbose "Destination is a directory"
        $DestinationName = Split-Path -Leaf $Source
        $Destination = Join-Path $Destination $DestinationName
    }
    Write-Verbose "Writing to file '$Destination'"

    # Write as UTF-8 without BOM
    [System.IO.File]::WriteAllText($Destination,
        (Expand-Template -Template $Template -Binding $Context.Binding))
}
