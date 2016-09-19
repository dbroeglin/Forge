Set-PSDebug -Strict
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\Forge\_Context.ps1"
. "$here\..\Forge\$sut"


Describe "New-ForgeModule" {
    $Name = "TestModule"
    $TestPath = "TestDrive:\$Name" 
    $Params = @{ 
        Name = $Name
        Path = $TestPath
    }

    Context "-Name $Name -Path... "{
        $TestPath = "TestDrive:\$Name" 
        New-ForgeModule @Params

        It "should create a project directory" {
            $TestPath | Should Exist
        }

        It "should create a README.md" {
            "$TestPath\README.md" | Should Exist
            "$TestPath\README.md" | Should Contain "# TestModule PowerShell module"
        }

        It "should create a module directory" {
            "$TestPath\$Name" | Should Exist
        }

        It "should create a module file" {
            "$TestPath\$Name\$Name.psm1" | Should Exist
            "$TestPath\$Name\$Name.psm1" | Should Contain "Set-StrictMode"
        }

        It "should create a manifest file" {
            "$TestPath\$Name\$Name.psd1" | Should Exist
        }

        It "should create a test directory" {
            "$TestPath\Tests" | Should Exist
        }
    }

    Context "-License Apache" {
        New-ForgeModule @Params -License Apache

        It "should create an Apache LICENSE file" {
            "$TestPath\LICENSE" | Should Exist
            "$TestPath\LICENSE" | Should Contain "Apache License"            
        }
    }

    Context "-License MIT" {
        New-ForgeModule @Params -License MIT

        It "should create a MIT LICENSE file" {
            "$TestPath\LICENSE" | Should Exist
            "$TestPath\LICENSE" | Should Contain "The MIT License"            
        }
    }
}