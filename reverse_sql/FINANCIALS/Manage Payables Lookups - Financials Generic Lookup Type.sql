/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payables%20Lookups%20-%20Financials%20Generic%20Lookup%20Type.sql $:
 * $Id: Manage Payables Lookups - Financials Generic Lookup Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT  LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LOOKUPGENERICEO.LOOKUP_CODE RES_LOOKUP_CODE
,SetIdSetPEO.SET_NAME RES_REFERENCE_DATA_SET
,LOOKUPGENERICEO.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LOOKUPGENERICEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LOOKUPGENERICEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LOOKUPGENERICEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LOOKUPGENERICEO.MEANING RES_MEANING
,LOOKUPGENERICEO.DESCRIPTION RES_DESCRIPTION
,LOOKUPGENERICEO.TAG RES_TAG
,LOOKUPGENERICEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LOOKUPGENERICEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LOOKUPGENERICEO.CREATED_BY  RSC_CREATED_BY
,LOOKUPGENERICEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,FND_LOOKUP_VALUES_VL LOOKUPGENERICEO
,FND_SETID_SETS_VL SetIdSetPEO
where (LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'AP'
	AND at.module_id     = rf.ancestor_module_id
	))
and LOOKUPGENERICEO.set_id = SetIdSetPEO.SET_ID
and LOOKUPTYPEEO.LOOKUP_TYPE = LOOKUPGENERICEO.LOOKUP_TYPE	
and LOOKUPGENERICEO.VIEW_APPLICATION_ID = 200
ORDER BY LOOKUPGENERICEO.DISPLAY_SEQUENCE
,LOOKUPGENERICEO.MEANING