$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\Forge\$sut"


Describe "New-ForgeScript" {
    Context "New-ForgeScript -Path test.txt" {
        $TestPath = "TestDrive:\test.txt" 
        New-ForgeScript -Name "Get-TestScript" -Path $TestPath

        It "contains a function declaration" {
            $TestPath | Should Contain 'function Get-TestScript'
        }

        It "contains a synopsis" {
            $TestPath | Should Contain '.SYNOPSIS'
        }

        It "contains a description" {
            $TestPath | Should Contain '.DESCRIPTION'
        }    
    }

    Context "New-ForgeScript -Path test.txt -Parameter a,b" {
        $TestPath = "TestDrive:\test.txt" 
        New-ForgeScript -Name "Get-TestScript" -Path $TestPath -Parameter a,b

        It "contains a parameter documentation for a" {
            $TestPath | Should Contain '.PARAMETER a'
        }

        It "contains a parameter declaration for a" {
            $TestPath | Should Contain '\$a,'
        }

        It "contains a parameter documentation for b" {
            $TestPath | Should Contain '.PARAMETER b'
        }

        It "contains a parameter declaration for b" {
            $TestPath | Should Contain '\$b'
        }     
    }
}