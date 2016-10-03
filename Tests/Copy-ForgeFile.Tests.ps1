Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\$sut"

Describe "Copy-ForgeFile" {
    $SourceRoot = Setup -Dir Templates -PassThru
    $DestinationPath = Setup -Dir Destination -PassThru

    Setup -File (Join-path Templates TEST) -Content "COU<%= `$a %>COU"

    $Context = @{
        SourceRoot      = $SourceRoot
        DestinationPath = $DestinationPath
        Binding         = @{ a = "-" }
    }

    It "should copy file" {
        Copy-ForgeFile -Source "TEST" @Context

        "$DestinationPath\TEST" | Should Exist
        "$DestinationPath\TEST" | Should Contain "^COU-COU$"
    }

    It "should copy file to new name" {
        Copy-ForgeFile -Source "TEST" -Destination "TEST1" @Context

        "$DestinationPath\TEST"  | Should Not Exist
        "$DestinationPath\TEST1" | Should Exist
        "$DestinationPath\TEST1" | Should Contain "^COU-COU$"
    }

    It "should copy file to directory" {
        $SomeDirectory = New-Item -Type Container (Join-Path $DestinationPath SomeDir)

        Copy-ForgeFile -Source "TEST" -Destination SomeDir @Context

        "$SomeDirectory\TEST"  | Should Exist
        "$SomeDirectory\TEST"  | Should Contain "^COU-COU$"
    }

    AfterEach {
        Remove-Item -Recurse $DestinationPath/*
   }
}
