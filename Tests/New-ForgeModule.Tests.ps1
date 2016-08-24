$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\Forge\$sut"


Describe "New-ForgeModule" {
    $Name = "TestModule"

    Context "-Name $Name -Path... "{
        $TestPath = "TestDrive:\$Name" 
        New-ForgeModule -Name $Name -Path $TestPath

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
        }

        It "should create a test directory" {
            "$TestPath\Tests" | Should Exist
        }        
    }
}