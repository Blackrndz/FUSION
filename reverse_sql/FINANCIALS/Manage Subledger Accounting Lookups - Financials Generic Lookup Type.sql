/* ****************************************************************************
 * $Revision: 55904 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-06-15 10:41:26 +0700 (Wed, 15 Jun 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/Backup%20Trunk/reverse_sql/FINANCIALS/Manage%20Subledger%20Accounting%20Lookups%20-%20Financials%20Generic%20Lookup%20Type.sql $:
 * $Id: Manage Subledger Accounting Lookups - Financials Generic Lookup Type.sql 55904 2016-06-15 03:41:26Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LOOKUPEO.LOOKUP_CODE RES_LOOKUP_CODE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = LookupEO.SET_ID
	)      RES_REFERENCE_DATA_SET
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
,FND_LOOKUP_VALUES_VL LookupEO
WHERE LOOKUPTYPEEO.LOOKUP_TYPE         = LOOKUPEO.LOOKUP_TYPE
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'XLA'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LOOKUPTYPEEO.LOOKUP_TYPE
,LOOKUPEO.LOOKUP_CODE
,LookupEO.DISPLAY_SEQUENCE