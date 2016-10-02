Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\$sut"

Describe "<%= $Name %>" {
    It "should just work" {
        # TODO: an actual test
    }
}