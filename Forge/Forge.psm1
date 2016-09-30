<#
Copyright 2016 Dominique Broeglin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

Set-StrictMode -Version 3

Import-Module EPS 

# Load functions
$functions = Get-ChildItem -Path $PSScriptRoot -Recurse -Include *.ps1 | 
    Where-Object { -not ($_.Fullname -match "Scaffold") } |
    Sort-Object
$functions | ForEach-Object { . $_.FullName }
