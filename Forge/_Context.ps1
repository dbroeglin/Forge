$ErrorActionPreference = "Stop"
$ScaffoldsPath = Join-Path $PSScriptRoot Scaffolds

function New-ForgeDirectory {
    Param(
        [String]$Destination = ""
    )
    New-Item -Type Directory -Path (Join-Path $DestinationPath $Destination) > $Null
}

function Copy-ForgeFile {
    Param(
        [String]$Source,

        [String]$Destination = $Source,

        [PSCustomObject]$Binding = $Script:Binding
    )
    $Template = Get-Content -Raw (Join-Path $SourcesPath $Source)
    if (Test-Path -Type Container $Destination) {
        $DestinationName = Split-Path -Leaf $Source
        $Destination = Join-Path $Destination $DestinationName
    }
    # Write as UTF-8 without BOM
    [System.IO.File]::WriteAllText((Join-Path $Script:DestinationPath $Destination),
        (Expand-Template -Template $template -Binding $Binding))
}

function Get-ValueOrGitOrDefault {
    Param([String]$Value, [String]$GitConfigKey, [String]$Default)

    if ([string]::IsNullOrWhitespace($Value)) {
        if (-not (Get-Command $GitCommand -ErrorAction SilentlyContinue) -or
            [string]::IsNullOrWhitespace(($Value = (& $GitCommand config $GitConfigKey)))) {
            $Value = $Default
        }
    }
    return $Value
}