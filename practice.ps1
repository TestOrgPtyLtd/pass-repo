$randomWord = 'Porpoise'
Write-Host "The random word inside this script is $randomWord."

# Declaring a parameter called $Path
Param(
    [string]$Path = '',
    [string]$DestinationPath = ''
) 

New-Item $Path
Write-Host "File created at path $Path"