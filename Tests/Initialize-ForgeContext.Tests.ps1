Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\$sut"

Describe "Initialize-ForgeContext" {
    function Get-CallerModuleName { return "Forge.Test" }
    
    It "should create a context" {
        Initialize-ForgeContext -SourceRoot "source" -DestinationPath "destination"

        $Context = $Script:ForgeContexts['Forge.Test']
        $Context.SourceRoot      | Should Be "source"
        $Context.DestinationPath | Should Be (Join-Path $PWD "destination")
        $Context.Binding         | Should BeOfType [System.Collections.Hashtable]
        $Context.Binding.Count   | Should Be 0
    }
}
