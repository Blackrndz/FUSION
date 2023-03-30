/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT fndlookups.LOOKUP_TYPE RES_LOOKUP_TYPE
, LookupValue.LOOKUP_CODE RES_LOOKUP_CODE
, LookupValue.DISPLAY_SEQUENCE RES_DISPLAY_SEQUENCE
, DECODE(LookupValue.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
, TO_CHAR(LookupValue.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
, TO_CHAR(LookupValue.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
, LookupValue.MEANING RES_MEANING
, LookupValue.DESCRIPTION RES_DESCRIPTION
, LookupValue.TAG RES_TAG
,LookupValue.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LookupValue.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LookupValue.CREATED_BY RSC_CREATED_BY
,LookupValue.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL fndlookups
,Fusion.FND_LOOKUP_VALUES_VL LookupValue
WHERE fndlookups.LOOKUP_TYPE = LookupValue.LOOKUP_TYPE
AND fndlookups.LOOKUP_TYPE  IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'HZ_MANAGE_CUSTOMER_ACCOUNT_LOOKUPS'
		))
	)
AND fndlookups.VIEW_APPLICATION_ID  = 0
AND LookupValue.VIEW_APPLICATION_ID = 0
AND LookupValue.SET_ID              = 0
ORDER BY fndlookups.LOOKUP_TYPE
,LookupValue.DISPLAY_SEQUENCE