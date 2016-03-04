
@echo off
setlocal

Start "NW_AIG_Service" sc stop "New World Service - AIG"

Start "NW_Arete_Service" sc stop "New World Service - Arete"

Start "NW_BSF_Service" sc stop "New World Service - BSF"

Start "NW_chuckecheese_Service" sc stop "New World Service - CECEntertainment"

Start "NW_ClientSolutions_Service" sc stop "New World Service - ClientSolutions"

Start "NW_diebold_Service" sc stop "New World Service - diebold"

Start "NW_ECOLAB_Service" sc stop "New World Service - ECOLAB"

Start "NW_FurstStaffing_Service" sc stop "New World Service - FurstStaffing"

Start "NW_GAIC_Service" sc stop "New World Service - GAIC"

Start "NW_IndianaUniversity_Service" sc stop "New World Service - IndianaUniversity"

Start "NW_IntegrityInsurance_Service" sc stop "New World Service - IntegrityInsurance"

Start "NW_KeySolution_Service" sc stop "New World Service - KeySolution"

Start "NW_KeySolutionNewCase_Service" sc stop "New World Service - KeySolutionNewCase"

Start "NW_Kroger_Service" sc stop "New World Service - Kroger"

Start "NW_LibertyMutualHomeRepair_Service" sc stop "New World Service - LibertyMutualHomeRepair"

Start "NW_lumberliquidators_Service" sc stop "New World Service - lumberliquidators"

Start "NW_McDonaldsFieldRecruiting_Service" sc stop "New World Service - McDonaldsFieldRecruiting"

Start "NW_McDonaldsStaffRecruiting_Service" sc stop "New World Service - McDonaldsStaffRecruiting"

Start "NW_NationalLifeGroup_Service" sc stop "New World Service - NationalLifeGroup"

Start "NW_Octapharma_Service" sc stop "New World Service - Octapharma"

Start "NW_RMHCCF_Service" sc stop "New World Service - RMHCCF"

Start "NW_SGS_Service" sc stop "New World Service - SGS"

Start "NW_SpartanOffshore_Service" sc stop "New World Service - SpartanOffshore"

Start "NW_Specialty_Service" sc stop "New World Service - Specialty"

Start "NW_spplus_Service" sc stop "New World Service - spplus"

Start "NW_Tektronix_Service" sc stop "New World Service - Tektronix"

Start "NW_TripleplayFM_Service" sc stop "New World Service - TripleplayFM"

Start "NW_USAPARKING" sc stop "New World Service - USAPARKING"

Start "NW_USPIS_Service" sc stop "New World Service - USPIS"

Start "NW_WALMARTHAEP_Service" sc stop "New World Service - WALMARTHAEP"

Start "NW_WesternUnionContractors_Service" sc stop "New World Service - WesternUnionContractors"

Start "NW_WIS_Service" sc stop "New World Service - WIS"


endlocal
