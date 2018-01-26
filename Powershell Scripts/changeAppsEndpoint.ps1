$site=$args[0]
$endpoint=$args[1]

(Get-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config) | ForEach-Object { $_ -replace "qa1apps.geninfo.com", "$endpoint" } | Set-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config
(Get-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config) | ForEach-Object { $_ -replace "qa2apps.geninfo.com", "$endpoint" } | Set-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config
(Get-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config) | ForEach-Object { $_ -replace "model1apps.geninfo.com", "$endpoint" } | Set-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config
(Get-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config) | ForEach-Object { $_ -replace "model2apps.geninfo.com", "$endpoint" } | Set-Content E:\$site\Services\GIS.Pangea.NW.ServiceHosts.NewWorld.exe.config

if($site -match "NW_Bengals") 
{ 
	spsv $site 
	spsv $site 
}

if($site -match "NW_Jets")
{ 
	spsv $site 
	sasv $site 
}

if($site -match "NW_Panthers")
{ 
	spsv $site 
	sasv $site 
}

if($site -match "NW_Patriots")
{ 
	spsv $site 
	sasv $site 
}

if($site -match "NW_QA_Bleed")
{ 
	spsv $site 
	sasv $site 
}

if($site -eq "NW_CowboysHR")
{ 
	spsv "New World Service - CowboysHR" 
	sasv "New World Service - CowboysHR" 
}

if($site -eq "NW_CowboysINS")
{ 
	spsv "New World Service - CowboysINS" 
	sasv "New World Service - CowboysINS" 
}

if($site -eq "NW_TexansHR")
{ 
	spsv "New World Service - TexansHR" 
	sasv "New World Service - TexansHR" 
}

if($site -eq "NW_TexansINS")
{ 
	spsv "New World Service - TexansINS" 
	sasv "New World Service - TexansINS"
}
