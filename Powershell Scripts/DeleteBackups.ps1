param([string]$search="C:\Users\tkoehler\Desktop\testdir") 
Write-Host "Searching $search for backup directories..."
Get-ChildItem $search -Recurse -filter *_BU | Select-Object FullName | % {   
    Write-Host deleting $_.FullName
    Remove-Item -Recurse -Force $_.FullName
}