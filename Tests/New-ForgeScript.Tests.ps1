Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\Get-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\Copy-ForgeFile.ps1"
. "$PSScriptRoot\..\Forge\Initialize-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "New-ForgeScript" {
    function Get-CallerModuleName { return "Forge.Test" }

    Context "New-ForgeScript -Path test.txt" {
        $TestPath = Join-Path $TestDrive "test.txt" 
        New-ForgeScript -Name "Get-TestScript" -Path $TestPath

        It "contains a function declaration" {
            $TestPath | Should -FileContentMatch 'function Get-TestScript'
        }

        It "contains a synopsis" {
            $TestPath | Should -FileContentMatch '.SYNOPSIS'
        }

        It "contains a description" {
            $TestPath | Should -FileContentMatch '.DESCRIPTION'
        }    
    }

    Context "New-ForgeScript -Path test.txt -Parameter a,b" {
        $TestPath = Join-Path $TestDrive "test.txt" 
        New-ForgeScript -Name "Get-TestScript" -Path $TestPath -Parameter a,b

        It "contains a parameter documentation for a" {
            $TestPath | Should -FileContentMatch '.PARAMETER a'
        }

        It "contains a parameter declaration for a" {
            $TestPath | Should -FileContentMatch '\$a,'
        }

        It "contains a parameter documentation for b" {
            $TestPath | Should -FileContentMatch '.PARAMETER b'
        }

        It "contains a parameter declaration for b" {
            $TestPath | Should -FileContentMatch '\$b'
        }     
    }
}