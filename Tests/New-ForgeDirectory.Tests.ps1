Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\Get-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\Initialize-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "New-ForgeDirectory" {
    function Get-CallerModuleName { return "Forge.Test" }
    Initialize-ForgeContext -DestinationPath ($DestinationPath = Setup -Dir Destination -PassThru)

    It "should create a directory" {
        New-ForgeDirectory -Destination "TEST" 
        
        Test-Path -Type Container "$DestinationPath\TEST" | Should Be $True
    }
}
