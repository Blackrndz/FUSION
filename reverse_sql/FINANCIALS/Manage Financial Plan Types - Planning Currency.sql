/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Financial%20Plan%20Types%20-%20Planning%20Currency.sql $:
* $Id: Manage Financial Plan Types - Planning Currency.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjoPlanTypeEO.NAME												RES_NAME
,pjoPlanCurrencieEO.TXN_CURRENCY_CODE									RES_CURRENCY
,pjoPlanCurrencieEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjoPlanCurrencieEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjoPlanCurrencieEO.CREATED_BY  RSC_CREATED_BY
,pjoPlanCurrencieEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJO_PLAN_TYPES_VL pjoPlanTypeEO
,PJO_PLANNING_OPTIONS pjoPlanOptionEO
,PJO_PLANNING_CURRENCIES pjoPlanCurrencieEO
WHERE pjoPlanTypeEO.PLAN_TYPE_CODE = 'FINANCIAL_PLAN'
AND pjoPlanTypeEO.PLAN_TYPE_ID = pjoPlanOptionEO.PLAN_TYPE_ID
AND pjoPlanOptionEO.PLANNING_OPTION_ID = pjoPlanCurrencieEO.PLANNING_OPTION_ID
AND pjoPlanTypeEO.PLAN_TYPE_ID = pjoPlanCurrencieEO.PLAN_TYPE_ID
AND pjoPlanOptionEO.PLAN_OPTION_LEVEL_CODE = 'PLAN_TYPE'
AND pjoPlanOptionEO.PROJECT_ID = 0
ORDER BY pjoPlanTypeEO.NAME