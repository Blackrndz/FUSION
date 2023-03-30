/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Talent%20Review%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Talent Review Lookups - Lookup Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT LookupTypeEO.LOOKUP_TYPE RES_LOOKUP_TYPE
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

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,Fusion.FND_LOOKUP_VALUES_VL LookupValue
WHERE LookupTypeEO.LOOKUP_TYPE = LookupValue.LOOKUP_TYPE
AND LookupTypeEO.LOOKUP_TYPE IN
	(SELECT BoAttributeValuesEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE(BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'lookupType'
	AND BoAttributeValuesEO.TASK_ID                   =
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'HRR_MANAGE_TALENT_REVIEW_LOOKUPS'
		))
	)
AND LookupTypeEO.VIEW_APPLICATION_ID  = 3
AND LookupValue.VIEW_APPLICATION_ID = 3
AND LookupValue.SET_ID              = 0
ORDER BY LookupTypeEO.LOOKUP_TYPE
,LookupValue.DISPLAY_SEQUENCE