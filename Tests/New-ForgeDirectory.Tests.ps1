Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\$sut"

Describe "New-ForgeDirectory" {
    $DestinationPath = Setup -Dir Destination -PassThru

    It "should create a directory" {
        New-ForgeDirectory -Destination "TEST" -DestinationPath $DestinationPath
        
        Test-Path -Type Container "$DestinationPath\TEST" | Should Be $True
    }
}
