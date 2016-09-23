Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\_Context.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "New-ForgeModuleScript" {
    $ModuleName = "TestModule"
    $FunctionName = "TestFunction"
    $TestPath   = Setup -Dir $ModuleName -Passthru

    Context "-Name $FunctionName -Parameter a,b,c" {
        $ModulePath = Setup -Dir (Join-Path $ModuleName $ModuleName) -Passthru
        $TestsPath  = Setup -Dir (Join-Path $ModuleName Tests) -Passthru
        $FunctionName = "TestFunction1"

        it "should generate a function file with parameters" {
            $FunctionPath = (Join-Path $ModulePath "$FunctionName.ps1")
            $FunctionTestPath = (Join-Path Tests "$FunctionName.Tests.ps1")

            New-ForgeModuleFunction -Name $FunctionName -Parameter a1,b1,c1
            $FunctionPath     | Should Exist
            $FunctionPath     | Should Contain "a1,"
            $FunctionPath     | Should Contain "b1,"
            $FunctionPath     | Should Contain "c1"
            $FunctionTestPath | Should Exist
        }
    }

    Context "-Name $FunctionName" {
        $ModulePath = Setup -Dir (Join-Path $ModuleName $ModuleName) -Passthru
        $TestsPath  = Setup -Dir (Join-Path $ModuleName Tests) -Passthru

        it "should generate a function file" {
            New-ForgeModuleFunction -Name $FunctionName 
            (Join-Path $ModulePath "$FunctionName.ps1") | Should Exist
            (Join-Path Tests "$FunctionName.Tests.ps1") | Should Exist
        }
    }

    Context "Incorrect directory structure: no module dir" {
        $TestsPath  = New-Item (Join-path $TestPath Tests) -Type Container
    
        It "should fail if '<ModuleName>' directory does not exist" {
            { 
                New-ForgeModuleFunction -Name $FunctionName
            } | Should Throw "Module directory 'TestModule' does not exist"            
        }

        AfterEach {
            Remove-Item $TestsPath 
        }
    }

    Context "Incorrect directory structure: no Tests dir" {
        $ModulePath = New-Item (Join-Path $TestPath $ModuleName) -Type Container

        It "should fail if 'Tests' directory does not exist" {
            { 
                New-ForgeModuleFunction -Name $FunctionName
            } | Should Throw "Test directory 'Tests' does not exist"
            
        }

        AfterEach {
            Remove-Item $ModulePath 
        }
    }

    BeforeEach {
        $Script:OldLocation = Get-Location
        Set-Location $TestPath
    }

    AfterEach {
        Set-Location $Script:OldLocation
    }
    
}