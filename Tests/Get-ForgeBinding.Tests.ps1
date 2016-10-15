Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\Get-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "Get-ForgeBinding" {
    It "should return the defined binding" {
        $Script:ForgeContext = @{ Binding = @{ A = 1 }}
        
        (Get-ForgeBinding).A | Should Be 1
    }
}
