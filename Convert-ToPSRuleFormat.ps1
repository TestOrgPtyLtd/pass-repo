# Convert GitHub branch data to PSRule-compatible input format

# Read in the raw GitHub API data
$branches = Get-Content ./github-branches.json | ConvertFrom-Json

# Prepare an array for PSRule-formatted objects
$psruleFormat = @()

foreach ($b in $branches) {
    $psruleFormat += [pscustomobject]@{
        apiVersion = 'github.com/microsoft/PSRule/v1'
        kind       = 'api.github.com/repos/branches'
        metadata   = @{ name = $b.name }
        Name       = $b.name
        Protected  = $b.protected
        Commit     = @{
            sha = $b.commit.sha
        }
    }
}

# Output to a new JSON file
$psruleFormat | ConvertTo-Json -Depth 5 | Out-File ./psrule-branches.json

Write-Host "Converted data written to psrule-branches.json"
