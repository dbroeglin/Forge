Set-PSDebug -Strict
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\Forge\_Context.ps1"
. "$here\..\Forge\$sut"

Describe "New-ForgeModuleScript" {
    $ModuleName = "TestModule"
    $FunctionName = "TestFunction"
    $TestPath   = Setup -Dir $ModuleName -Passthru

    Context "-Name $FunctionName" {
        $ModulePath = Setup -Dir (Join-Path $ModuleName $ModuleName) -Passthru
        $TestsPath  = Setup -Dir (Join-Path $ModuleName Tests) -Passthru

        it "should generate a function file" {
            New-ForgeModuleFunction -Name $FunctionName 
            (Join-Path $ModulePath "$FunctionName.ps1") | Should Exist
            (Join-Path Tests "$FunctionName.Tests.ps1") | Should Exist
        }

        BeforeEach {
            $Script:OldLocation = Get-Location
            Set-Location $TestPath            
        }

        AfterEach {
            Set-Location $Script:OldLocation            
        }
    }

    Context "Incorrect directory structure: no module dir" {
        $TestsPath  = New-Item (Join-path $TestPath Tests) -Type Container
    
        It "should fail if '<ModuleName>' directory does not exist" {
            { 
                New-ForgeModuleFunction -Name $FunctionName
            } | Should Throw "Module directory 'TestModule' does not exist"            
        }

        BeforeEach {
            $Script:OldLocation = Get-Location
            Set-Location $TestPath            
        }

        AfterEach {
            Set-Location $Script:OldLocation            
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

        BeforeEach {
            $Script:OldLocation = Get-Location
            Set-Location $TestPath            
        }

        AfterEach {
            Set-Location $Script:OldLocation            
            Remove-Item $ModulePath 
        }
    }
}