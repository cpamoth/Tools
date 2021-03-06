Get-ChildItem "." -recurse -Filter "*.UPGRADE" | Foreach-Object{
    $upgrade = $_.FullName
    $parent = $upgrade -replace ".UPGRADE",""
    $bu = $parent + "." + $(get-date -f yyyy-MM-dd-hh-mm-ss)
    Rename-Item $parent $bu
    Rename-Item $upgrade $parent
}
