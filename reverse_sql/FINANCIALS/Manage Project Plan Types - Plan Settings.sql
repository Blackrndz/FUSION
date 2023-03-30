 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT planTypesE0.NAME RES_NAME
,DECODE(planOptionsE0.ENABLE_COSTS_FOR_PROJ_PLAN,'Y','Yes','No') RES_ENABLE_COSTS_FOR_PROJECT_P
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJO_TIME_PHASED_TYPE'
	AND LOOKUP_CODE = planOptionsE0.TIME_PHASED_CODE
	) RES_CALENDAR_TYPE
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJO_PRJ_PLN_RATE_DRV_DATE_TYPE'
	AND LOOKUP_CODE = NVL(planOptionsE0.NTP_RATE_DATE_TYPE,'START_DATE_PRJ_PLAN')
	) RES_RATE_DERIVATION_DATE_TYPE
,TO_CHAR(planOptionsE0.NTP_RATE_DATE,'DD-Mon-YYYY') RES_RATE_DERIVATION_DATE
,(SELECT NAME
	FROM PJO_PERIOD_PROFILES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND PERIOD_PROFILE_ID = planOptionsE0.PERIOD_PROFILE_ID
	) RES_PERIOD_PROFILE
,planOptionsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,planOptionsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,planOptionsE0.CREATED_BY  RSC_CREATED_BY
,planOptionsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL planTypesE0
,PJO_PLANNING_OPTIONS planOptionsE0
WHERE planTypesE0.PLAN_TYPE_CODE = 'PROJECT_PLAN'
AND planTypesE0.PLAN_TYPE_ID = planOptionsE0.PLAN_TYPE_ID
AND planOptionsE0.PROJECT_ID = 0
ORDER BY planTypesE0.NAME