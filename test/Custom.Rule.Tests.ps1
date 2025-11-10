# Test suite created not aligned with current test suite
# Can delete later, keep for learning purposes if needed

Import-Module PSRule
Import-Module PSRule.Rules.GitHub
. "$PSScriptRoot/../.ps-rule/Custom.Rule.ps1"

Describe 'Repo.MainBranchProtected Rule' {
    # The test suite
    Context 'When the main branch is protected' {
        # Grouping by condition
        It 'should pass' {
            # Arrange
            $input = [PSCustomObject]@{
                apiVersion = 'github.com/microsoft/PSRule/v1'
                kind = 'api.github.com/repos/branches'
                metadata = @{ name = 'main'}
                Name = 'main'
                Protected = $true
                Commit = @{ sha = '123'}
            }

            # Act
            $result = Invoke-PSRule -InputObject $input -Outcome All

            # Assert
            $result.Outcome | Should -Contain 'Pass'
        }
    }

    Context 'When the main branch is unprotected' {
        It 'should fail' {
            # Arrange
            $input = [PSCustomObject]@{
                apiVersion = 'github.com/microsoft/PSRule/v1'
                kind = 'api.github.com/repos/branches'
                metadata = @{ name = 'main'}
                Name = 'main'
                Protected = $false
                Commit = @{ sha = '123'}
            }

            # Act
            $result = Invoke-PSRule -InputObject $input -Outcome All

            # Assert
            $result.Outcome | Should -Contain 'Fail'
        }
    }
}