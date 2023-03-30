/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Cash%20Management%20Lookups%20-%20Financials%20Generic%20Lookup%20Type.sql $:
 * $Id: Manage Cash Management Lookups - Financials Generic Lookup Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


select LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LOOKUPEO.LOOKUP_CODE RES_LOOKUP_CODE
,SetIdSetPEO.SET_NAME RES_REFERENCE_DATA_SET
,LOOKUPEO.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LOOKUPEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LOOKUPEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LOOKUPEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LOOKUPEO.MEANING RES_MEANING
,LOOKUPEO.DESCRIPTION RES_DESCRIPTION
,LOOKUPEO.TAG RES_TAG
,LookupEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LookupEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LookupEO.CREATED_BY  RSC_CREATED_BY
,LookupEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
from FND_LOOKUP_TYPES_VL LOOKUPTYPEEO
,FND_LOOKUP_VALUES_VL LOOKUPEO
,FND_SETID_SETS_VL SetIdSetPEO
WHERE LOOKUPTYPEEO.LOOKUP_TYPE         = LOOKUPEO.LOOKUP_TYPE
AND LOOKUPEO.set_id        = SetIdSetPEO.set_id
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'LBA'
	AND at.module_key    = 'FinCeSharedSetup'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LOOKUPTYPEEO.LOOKUP_TYPE
,LOOKUPEO.LOOKUP_CODE
,LookupEO.DISPLAY_SEQUENCE