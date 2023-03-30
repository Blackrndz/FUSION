/* ****************************************************************************
 * $Revision: 55237 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-16 16:43:24 +0700 (Mon, 16 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Standard%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Standard Lookups - Lookup Codes.sql 55237 2016-05-16 09:43:24Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupEO.LOOKUP_CODE RES_LOOKUP_CODE
,LookupEO.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
,DECODE(LookupEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,TO_CHAR(LookupEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(LookupEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,LookupEO.MEANING RES_MEANING
,LookupEO.DESCRIPTION RES_DESCRIPTION
,LookupEO.TAG RES_TAG
,LookupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupEO.CREATED_BY RSC_CREATED_BY
,LookupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
    
FROM FND_LOOKUP_TYPES_VL LOOKUPTYPEEO
,FND_LOOKUP_VALUES_VL LookupEO
WHERE(((LookupEO.VIEW_APPLICATION_ID = 0)
AND(LOOKUPEO.SET_ID                  = 0)))
AND LOOKUPTYPEEO.LOOKUP_TYPE         = LOOKUPEO.LOOKUP_TYPE
AND LOOKUPEO.VIEW_APPLICATION_ID     = 0
AND LOOKUPTYPEEO.LOOKUP_TYPE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'HZ_MANAGE_RELATIONSHIP_LOOKUPS'
		))
	)
ORDER BY LOOKUPTYPEEO.LOOKUP_TYPE
,LookupEO.DISPLAY_SEQUENCE
,LookupEO.MEANING