@echo off
setlocal

Start "NW_RHI_Service" sc start "New World Service - RHI"

Start "NW_RHI2_Service" sc start "New World Service - RHI2"

endlocal
