# Synopsis: Image files are not permitted
Rule 'Repo.ImageFileType' {
    # NotIn - the file extension must not be in this list
    # @('a', 'b) - an array
    # PSRule builds a $TargetObject for that file
    # It runs your rule script and calls $Assert.NotIn(..)
    # Grabs $TargetObject.Extension -> .png
    # Compares .png to the array  @('.jpg', '.png')
    # Since .png is in the list, the assertion fails.
    # PSRule records a failure: Rule name, target name, message
    $Assert.NotIn($TargetObject, 'Extension', @('.jpg', '.png'))

}

# Synopsis: Check main branch has protection enabled
Rule 'Repo.MainBranchProtected' -If { $TargetObject.kind -eq 'api.github.com/repos/branches' } {
    if ($TargetObject.Name -eq 'main') {
        if ($TargetObject.Protected -eq $true) {
            $Assert.Pass()
        }
        else {
            $Assert.Fail()
        }
    }
}

# Synopsis: Better rule to check branch protection
Rule 'Repo.DefaultBranchProtected' -If { $TargetObject.kind -eq 'api.github.com/repos/branches' } {
    $defaultBranch = @(GetRepositoryBranch -Name $TargetObject.DefaultBranch);
    $Assert.HasFieldValue($defaultBranch[0], 'Protection.Enabled', $True); 
}

