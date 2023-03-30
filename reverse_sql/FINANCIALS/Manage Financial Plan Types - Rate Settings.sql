/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Financial%20Plan%20Types%20-%20Rate%20Settings.sql $:
* $Id: Manage Financial Plan Types - Rate Settings.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjoPlanTypeEO.NAME							RES_NAME
,(SELECT BU_NAME FROM FUN_ALL_BUSINESS_UNITS_V 
	WHERE BU_ID = pjoPlanTypeRATEScEO.BU_ID
	) RES_BUSINESS_UNIT
,DECODE(pjoPlanTypeRATEScEO.USE_PLANNING_RATES_FLAG,'Y','Yes','No')	RES_USE_PLANNING_RATES
,pjoPlanTypeRATEScEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjoPlanTypeRATEScEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjoPlanTypeRATEScEO.CREATED_BY  RSC_CREATED_BY
,pjoPlanTypeRATEScEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,pjoPlanTypeRATEScEO.BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL pjoPlanTypeEO
,PJO_PLAN_TYPE_RATE_SCHS pjoPlanTypeRATEScEO
WHERE pjoPlanTypeEO.PLAN_TYPE_CODE = 'FINANCIAL_PLAN'
AND pjoPlanTypeEO.PLAN_TYPE_ID = pjoPlanTypeRATEScEO.PLAN_TYPE_ID
ORDER BY pjoPlanTypeEO.NAME