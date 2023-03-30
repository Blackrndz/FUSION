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
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_PERCENT_COMP_METHOD'
	AND LOOKUP_CODE = planOptionsE0.PERCENT_COMP_CALC_METHOD
	) RES_PHYSICAL_PERCENT_COMPLETE_
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_ETC_METHOD'
	AND LOOKUP_CODE = planOptionsE0.ETC_METHOD_CODE
	) RES_ETC_METHOD
,DECODE(planOptionsE0.ALLOW_NEG_ETC_FLAG,'Y','Yes','No') RES_ALLOW_NEGATIVE_ETC_CALCULA
,DECODE(planOptionsE0.PROG_UPD_PLAN_QTY_WITH_EAC,'Y','Yes','No') RES_UPDATE_PLANNED_QUANTITY_WI
,DECODE(planOptionsE0.PROG_AUTO_GEN_FCST_VER,'Y','Yes','No') RES_AUTOMATICALLY_GENERATE_FOR
,(SELECT NAME
	FROM PJO_PLAN_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND PLAN_TYPE_ID = planOptionsE0.PROG_FCST_PLAN_TYPE_ID
	) RES_FINANCIAL_PLAN_TYPE
,DECODE(planOptionsE0.PROG_AUTO_APPR_FCST_VER,'Y','Yes','No') RES_AUTOMATICALLY_APPROVE_FORE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_PERCENT_COMP_METHOD'
	AND LOOKUP_CODE = planOptionsE0.PERCENT_COMP_ROLLUP_METHOD
	) RES_PRIMARY_PHYSICAL_PERCENT_C
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