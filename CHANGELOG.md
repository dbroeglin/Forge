# 0.4.0 (October 16, 2016)
 * Refactored to allow each calling module to have it's own context
 * Added proper test for Get-ForgeBinding
 * Refactored New-ForgeScript to use external template
 * Made destination path test portable
 * Refactored to allow functions to share their context
 * Rewrote New-ForgeScript with an EPS template
 * Refactored New-ForgeModule and New-ForgeModuleFunction out to module 'Forge.Module'
 * Corrected Test for -NoExport

# 0.3.2 (October 2, 2016)
 * Need NoExport switch
 * Corrected bad copy/paste from main module
 * Added documentation for New-ForgeModuleFunction
 * Removed erroneous sourcing of _context.ps1 in generated modules
 * Refactored New-ForgeDirectory and Copy-ForgeFile into public functions
 * Added Pester manifest testing to the module scaffold$
 * Automatically add function to exported functions
 * Replaced use of MyInvocation by  in tests
 * Added option to generate a parameter list for a module function

# 0.3.1 (September 21, 2016)
 * Added New-ForgeModuleFunction to generate module functions
 * Renamed Skeletons dir to Scaffolds
 * Added Vagrantfile to for easy testing on Mac
 * Corrected base skeletons path computation

# 0.3.0 (September 21, 2016)
 * Added .gitignore
 * Fixed loading order and win relative path resolution

# 0.2.0 (September 20, 2016) 
 * Added appveyor, refactored & structured skeletons
 * Added a License param to New-ForgeModule
 * Added skeleton content for the module file
 * Resolved PSScriptAnalyzer non-conformities
 * Added module manifest
 * Added a New-ForgeModule based on EPS templates
 * Added a first set of tests for New-ForgeScript

# 0.1.0 (August 21, 2016) 
 * Initial version with simple New-ForgeScript cmdlet
