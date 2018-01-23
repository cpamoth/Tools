@echo off
setlocal

start "NW_ABCFWS_Service" sc stop "New World Service - ABCFWS"

start "NW_AetnaCOV_Service" sc stop "New World Service - AetnaCOV"

start "NW_ALB_Service" sc stop "New World Service - ALB"

start "NW_AMNHealthcare_Service" sc stop "New World Service - AMNHealthcare"

start "NW_ARTVAN_Service" sc stop "New World Service - ARTVAN"

start "NW_BodyCentral_Service" sc stop "New World Service - BodyCentral"

start "NW_CenteneAmbetter_Service" sc stop "New World Service - CenteneAmbetter"

start "NW_EQUITYLIFESTYLE_Service" sc stop "New World Service - EQUITYLIFESTYLE"

start "NW_Experis_Service" sc stop "New World Service - Experis"

start "NW_ExpressScripts_Service" sc stop "New World Service - ExpressScripts"

start "NW_GMP_Service" sc stop "New World Service - GMP"

start "NW_GoDaddy_Service" sc stop "New World Service - GoDaddy"

start "NW_GPMLife_Service" sc stop "New World Service - GPMLife"

start "NW_GrangeInsurance_Service" sc stop "New World Service - GrangeInsurance"

start "NW_JAlexanders_Service" sc stop "New World Service - JAlexanders"

start "NW_KEMPERBENEFITS_Service" sc stop "New World Service - KEMPERBENEFITS"

start "NW_LIFEMgmt_Service" sc stop "New World Service - LIFEMgmt"

start "NW_PROTECTIONONE_Service" sc stop "New World Service - PROTECTIONONE"

start "NW_RGARE_Service" sc stop "New World Service - RGARE"

start "NW_RHI3_Service" sc stop "New World Service - RHI3"

start "NW_RWOC_Service" sc stop "New World Service - RWOC"

start "NW_SakConstruction_Service" sc stop "New World Service - SakConstruction"

start "NW_STANDARDPARKING_Service" sc stop "New World Service - STANDARDPARKING"

start "NW_TETRAPAK_Service" sc stop "New World Service - TETRAPAK"

start "NW_UNITEDHERITAGE_Service" sc stop "New World Service - UNITEDHERITAGE"

start "NW_USPS_Service" sc stop "New World Service - USPS"

start "NW_VCCT_Service" sc stop "New World Service - VCCT"

start "NW_Walmart_Service" sc stop "New World Service - Walmart"


endlocal
