Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\Initialize-ForgeContext.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "Copy-ForgeFile" {
    Initialize-ForgeContext -SourceRoot (Setup -Dir Templates -PassThru) `
        -DestinationPath ($DestinationPath = Setup -Dir Destination -PassThru) `
        -Binding @{ a = "-" }

    Setup -File (Join-path Templates TEST) -Content "COU<%= `$a %>COU"

    It "should copy file" {
        Copy-ForgeFile -Source "TEST"

        "$DestinationPath\TEST" | Should Exist
        "$DestinationPath\TEST" | Should Contain "^COU-COU$"
    }

    It "should copy file to new name" {
        Copy-ForgeFile -Source "TEST" -Destination "TEST1"

        "$DestinationPath\TEST"  | Should Not Exist
        "$DestinationPath\TEST1" | Should Exist
        "$DestinationPath\TEST1" | Should Contain "^COU-COU$"
    }

    It "should copy file to directory" {
        $SomeDirectory = New-Item -Type Container (Join-Path $DestinationPath SomeDir)

        Copy-ForgeFile -Source "TEST" -Destination SomeDir

        "$SomeDirectory\TEST"  | Should Exist
        "$SomeDirectory\TEST"  | Should Contain "^COU-COU$"
    }

    AfterEach {
        if ($DestinationPath) {
            Remove-Item -Recurse $DestinationPath/*
        }
   }
}
