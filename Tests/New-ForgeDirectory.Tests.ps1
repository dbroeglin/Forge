Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\_Context.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "New-ForgeDirectory" {
    $Script:DestinationPath = Setup -Dir Destination -PassThru

    It "should create a directory" {
        New-ForgeDirectory -Destination "TEST"
        
        Test-Path -Type Container "$Script:DestinationPath\TEST" | Should Be $True
    }
}
