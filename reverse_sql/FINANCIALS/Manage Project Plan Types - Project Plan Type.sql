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
,planTypesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(planTypesE0.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(planTypesE0.END_DATE,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(planOptionsE0.USE_THIRD_PARTY_SOFTWARE,'Y','Yes','No') RES_USE_THIRD_PARTY_SOFTWARE_F
,DECODE(planTypesE0.PLAN_IN_MULTI_CURR_FLAG,'Y','Yes','No') RES_ENABLE_PLANNING_IN_MULTIPL
,planTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,planTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,planTypesE0.CREATED_BY  RSC_CREATED_BY
,planTypesE0.CREATION_DATE  RSC_CREATION_DATE
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