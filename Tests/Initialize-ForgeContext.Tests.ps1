Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\$sut"

Describe "Initialize-ForgeContext" {
    It "should create a context" {
        Initialize-ForgeContext -SourceRoot "source" -DestinationPath "destination"

        $Script:ForgeContext.SourceRoot      | Should Be "source"
        $Script:ForgeContext.DestinationPath | Should Be "$PWD/destination"
        $Script:ForgeContext.Binding         | Should BeOfType [System.Collections.Hashtable]
        $Script:ForgeContext.Binding.Count   | Should Be 0
    }
}
