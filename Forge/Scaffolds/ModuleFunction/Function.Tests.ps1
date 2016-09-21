Set-PSDebug -Strict
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\..\<%= $ModuleName %>\$sut"


Describe "<%= $Name %>" {
    It "should just work" {
        
    }
}