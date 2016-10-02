Set-PSDebug -Strict
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$PSScriptRoot\..\Forge\_Context.ps1"
. "$PSScriptRoot\..\Forge\$sut"

Describe "Copy-ForgeFile" {
    $Script:SourcesPath = Setup -Dir Templates -PassThru
    $Script:DestinationPath = Setup -Dir Destination -PassThru

    Setup -File (Join-path Templates TEST) -Content "COU<%= `$a %>COU"

    $Script:Binding     = @{ a = "-" }

    It "should copy file" {
        Copy-ForgeFile -Source "TEST"

        "$Script:DestinationPath\TEST" | Should Exist
        "$Script:DestinationPath\TEST" | Should Contain "^COU-COU$"
    }

    It "should copy file to new name" {
        Copy-ForgeFile -Source "TEST" -Destination "TEST1"

        "$Script:DestinationPath\TEST"  | Should Not Exist
        "$Script:DestinationPath\TEST1" | Should Exist
        "$Script:DestinationPath\TEST1" | Should Contain "^COU-COU$"
    }

    It "should copy file to directory" {
        $SomeDirectory = New-Item -Type Container (Join-Path $Script:DestinationPath SomeDir)

        Copy-ForgeFile -Source "TEST" -Destination SomeDir

        "$SomeDirectory\TEST"  | Should Exist
        "$SomeDirectory\TEST"  | Should Contain "^COU-COU$"
    }

    AfterEach {
        Remove-Item -Recurse $Script:DestinationPath/*
   }
}
