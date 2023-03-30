/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupGenericEO.LOOKUP_CODE RES_LOOKUP_CODE
,(SELECT SetIdSetPE.SET_NAME
	FROM FND_SETID_SETS_VL SetIdSetPE
	WHERE SetIdSetPE.SET_ID = LookupGenericEO.SET_ID
	) RES_REFERENCE_DATA_SET
,LookupGenericEO.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LookupGenericEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LookupGenericEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LookupGenericEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LookupGenericEO.MEANING RES_MEANING
,LookupGenericEO.DESCRIPTION RES_DESCRIPTION
,LookupGenericEO.TAG RES_TAG
,LookupGenericEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupGenericEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupGenericEO.CREATED_BY RSC_CREATED_BY
,LookupGenericEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,FND_LOOKUP_VALUES_VL LookupGenericEO
WHERE LookupTypeEO.LOOKUP_TYPE = LookupGenericEO.LOOKUP_TYPE
AND(LookupTypeEO.MODULE_ID    IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'IEX'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY LookupTypeEO.MEANING
,LookupGenericEO.LOOKUP_CODE