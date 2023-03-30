/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Overhead%20Expense%20Pools%20-%20Expense%20Pools.sql $:
 * $Id: Manage Overhead Expense Pools - Expense Pools.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CST_EXPENSE_POOLS_VL

SELECT ExpensePoolsE0.EXPENSE_POOL_CODE RES_CODE
,ExpensePoolsE0.EXPENSE_POOL_NAME RES_NAME
,ExpensePoolsE0.EXPENSE_POOL_DESC RES_DESCRIPTION
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE 
	LOOKUP_CODE = ExpensePoolsE0.EXPENSE_POOL_TYPE AND LOOKUP_TYPE = 'ORA_CST_EXPENSE_POOL_TYPES'
	AND LANGUAGE = USERENV('LANG')) RES_TYPE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = ExpensePoolsE0.SET_ID
	) RES_SET_NAME
,DECODE(ExpensePoolsE0.INACTIVE_FLAG,'Y','Yes','No') RES_INACTIVE
,ExpensePoolsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExpensePoolsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExpensePoolsE0.CREATED_BY RSC_CREATED_BY
,ExpensePoolsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_EXPENSE_POOLS_VL ExpensePoolsE0
ORDER BY ExpensePoolsE0.EXPENSE_POOL_CODE