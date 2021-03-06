<#
This script is for replacing one string with another for the files that match the filter provided.
Run this from the directory you want to recursively search.

Parameters:
filter - part fo the file name you want to search for
replace - string to replace
replacewith - string to replace with
ignores - '*' delimited list of strings.  If the script finds a file whose path contains one of these strings, it will be ignored

NOTE: it is safe to run this script.  It prompts you with "are you sure" questions before doing anything and all files are backed up with a time stamp before being modified.
#>
param([string]$filter, [string]$replace, [string]$replacewith, [string]$ignores)
Get-ChildItem "." -recurse -Filter $filter | Foreach-Object{
    $ignore = "false"
    if($ignores)
    {    
        foreach($i in $ignores.Split("*"))
        {
            if($_.FullName -like "*$i*")
            {
                $ignore = "true"
            }
        }
    }
    
    if($ignore -eq "false")
    {
        Write-Host Found $_.FullName -foregroundcolor green
    }
    else
    {
        Write-Host ignoring $_.FullName
    }
}

Write-Host Do you want to modify these files? yes or no -foregroundcolor yellow
$answ = Read-Host

if($answ -eq "yes")
{
    Write-Host Are you sure you want to replace "$replace" with "$replacewith"? yes or no -foregroundcolor yellow
    $answ = Read-Host
}

if($answ -eq "yes")
{
    Get-ChildItem "." -recurse -Filter $filter | Foreach-Object{
    
        $ignore = "false"
        if($ignores)
        {    
            foreach($i in $ignores.Split("*"))
            {
                if($_.FullName -like "*$i*")
                {
                    $ignore = "true"
                }
            }
        }
    
        if($ignore -eq "false")
        {
            Write-Host ------------------------------------------------------------------------------- -foregroundcolor cyan
            
            $content = (gc $_.FullName)
            if($content -like "*$replace*")
            {
                $bu = $_.FullName + $(get-date -f yyyy-MM-dd-hh-mm-ss)
                Write-Host Backing up original file to $bu -foregroundcolor gray
                Copy-Item $_.FullName $bu
    
                Write-Host Replacing $replace with $replacewith -foregroundcolor gray
                (gc $_.FullName) -replace $replace,$replacewith|sc $_.FullName
        
                Write-Host Done -foregroundcolor green
            }
            else
            {
                Write-Host $_.FullName does not contain $replace
            }
        }
    }
}
