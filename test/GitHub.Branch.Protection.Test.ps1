# Test Suite that follows the AzureDevOps Test Suite

[CmdletBinding()] # marks script as an advanced function
param ()

# For every PSRule test file, needs to import the module being tested and define paths before running
BeforeAll { # this block runs once before any test (It) in this file
    # Setup error handling
    $ErrorActionPreference = 'Stop'; # makes PowrShell throw errors
    Set-StrictMode -Version latest; # enforces best practices?

    $rootPath =$PWD

    # Loads the compiled PSRule.Rules.GitHub module from the local build output, so test knowsn what to test
    Import-Module (Join-Path -Path $rootPath -ChildPath out/modules/PSRule.Rules.GitHub) -Force;
    $here = (Resolve-Path $PSScriptRoot).Path; # records the test file's dir so can load input Json files easily
}

# Define a testsuite (top-level)
Describe 'GitHub.Branch.Protection' -Tag 'BranchProtection' {
    # So everything inside this block tests GitHub.Branch.Protection rules
    # -Tag allows you to selectively run certain test types later in 'Invoke-Pester -Tag 'BranchProtection'

    # Groups related test cases inside the suite (subgroup)
    # Everthing related to main branch protection here
    Context 'Check main branch protection' {
        BeforeAll {
            $dataPath = 
            # $dataPath points to JSON test data
        }
        It {

        }
    }
}