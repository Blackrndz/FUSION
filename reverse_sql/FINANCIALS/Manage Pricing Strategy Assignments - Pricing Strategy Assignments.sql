/* ****************************************************************************
 * $Revision: 78343 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-04-21 11:13:50 +0700 (Thu, 21 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Pricing%20Strategy%20Assignments%20-%20Pricing%20Strategy%20Assignments.sql $:
 * $Id: Manage Pricing Strategy Assignments - Pricing Strategy Assignments.sql 78343 2022-04-21 04:13:50Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=QP_STRATEGY_ASSIGNMENTS

SELECT (SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_STRATEGY_ASSIGN_LEVELS'
	AND LOOKUP_CODE = QpStrategyAssignmentsE0.STRATEGY_ASSIGNMENT_LEVEL_CODE
	) RES_ASSIGNMENT_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_PRICING_CONTEXTS'
	AND LOOKUP_CODE = QpStrategyAssignmentsE0.PRICING_CONTEXT_CODE 
	) RES_PRICING_CONTEXT
,DECODE(QpStrategyAssignmentsE0.TRANSACTION_TYPE_CODE,'ALL','All',(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_QP_SALES_TRANSACTION_TYPES'
	AND LOOKUP_CODE = QpStrategyAssignmentsE0.TRANSACTION_TYPE_CODE
	)) RES_TRANSACTION_TYPE
,TO_CHAR(QpStrategyAssignmentsE0.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,TO_CHAR(QpStrategyAssignmentsE0.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,QpStrategyAssignmentsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QpStrategyAssignmentsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QpStrategyAssignmentsE0.CREATED_BY RSC_CREATED_BY
,QpStrategyAssignmentsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_STRATEGY_ASSIGNMENTS QpStrategyAssignmentsE0