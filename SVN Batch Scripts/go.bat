@echo off

if (%1)==(memory) (
pushd C:\Documents and Settings\jemerson\scratch\Environment
goto EOF
)

if (%1)==(svn) (
pushd "C:\SVN\Gis\Development"
color 0b
goto EOF
)

if (%1)==(scratch) (
pushd C:\Documents and Settings\jemerson\scratch
goto EOF
)

if (%1)==(tools) (
pushd C:\SVN\Gis\Development\BuildTools\JeremyTools
color 05
goto EOF
)

if (%1)==(hcs) (
pushd C:\SVN\HCS\NewWorld
color 0e
goto EOF
)

if (%1)==(hcsbr) (
pushd C:\SVN\HCS\NewWorld\Branches\NewWorld_%2
color 0e
goto EOF
)

if (%1)==(hcsbu) (
pushd C:\SVN\HCS\NewWorld\Builds\NewWorld_%2
color 0e
goto EOF
)

if (%1)==(tax) (
pushd C:\SVN\HCS\TaxCredit
color 0d
goto EOF
)

if (%1)==(genwix) (
pushd C:\SVN\Gis\Development\BuildTools\Gis.MSBuild.Custom.Tasks\GenWix
goto EOF
)

if exist "C:\SVN\Gis\Development\DatabaseProjects\Code Move %1" (
pushd C:\SVN\Gis\Development\DatabaseProjects\Code Move %1
color 0b
goto EOF
)

if exist "C:\SVN\Gis\Development\Core Components\%1*" (
pushd "C:\SVN\Gis\Development\Core Components\%1*" 
color 0b
goto EOF
)

if exist "C:\SVN\Gis\Development\Core Applications\%1*" (
pushd "C:\SVN\Gis\Development\Core Applications\%1*" 
color 0b
goto EOF
)

if exist "C:\SVN\Gis\Development\Interfaces\%1*" (
pushd "C:\SVN\Gis\Development\Interfaces\%1*" 
color 0b
goto EOF
)


:EOF
echo.