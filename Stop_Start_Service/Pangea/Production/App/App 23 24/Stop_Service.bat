
@echo off
setlocal

Start "NW_NEXCOM_Service" sc stop "New World Service - NEXCOM"

Start "NW_WKU_Service" sc stop "New World Service - WKU"


endlocal
