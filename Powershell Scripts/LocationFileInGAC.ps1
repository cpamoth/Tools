#params ([string]$Name)
$Name = "microsoft"

#Shows the assemblies in the GAC, including the file version
Get-GacAssembly *${Name}*  | Format-Table -View FileVersion



