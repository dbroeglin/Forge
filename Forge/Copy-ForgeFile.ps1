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

        [String]$Destination = $Source,

        [PSCustomObject]$Binding = $Script:Binding
    )

    Write-Verbose "Copying file '$Source' to '$Destination'"
    $Template = Get-Content -Raw (Join-Path $Script:SourcesPath $Source)
    $Destination = Join-Path $Script:DestinationPath $Destination

    if (Test-Path -Type Container $Destination) {
        Write-Verbose "Destination is a directory"
        $DestinationName = Split-Path -Leaf $Source
        $Destination = Join-Path $Destination $DestinationName
    }
    Write-Verbose "Writing to file '$Destination'"

    # Write as UTF-8 without BOM
    [System.IO.File]::WriteAllText($Destination,
        (Expand-Template -Template $template -Binding $Binding))
}