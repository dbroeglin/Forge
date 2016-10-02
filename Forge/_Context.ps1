$ErrorActionPreference = "Stop"
$ScaffoldsPath = Join-Path $PSScriptRoot Scaffolds

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