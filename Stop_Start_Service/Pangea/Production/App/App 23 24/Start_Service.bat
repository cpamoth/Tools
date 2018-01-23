@echo off
setlocal

Start "NW_NEXCOM_Service" sc start "New World Service - NEXCOM"

Start "NW_WKU_Service" sc start "New World Service - WKU"


endlocal
