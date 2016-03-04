@echo off
setlocal

Start "NW_RHI_Service" sc stop "New World Service - RHI"

Start "NW_RHI2_Service" sc stop "New World Service - RHI2"
 
endlocal
