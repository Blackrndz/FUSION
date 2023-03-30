/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT bcStructuresE0.IND_STRUCTURE_NAME RES_NAME
,costbaseAssignmentsE0.COST_BASE RES_COST_BASE
,(SELECT EXPENDITURE_TYPE_NAME
	FROM PJF_EXP_TYPES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND EXPENDITURE_TYPE_ID = expTypesE0.EXPENDITURE_TYPE_ID 
	) RES_EXPENDITURE_TYPES
,expTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,expTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,expTypesE0.CREATED_BY  RSC_CREATED_BY
,expTypesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COST_PLUS_STRUCTURES bcStructuresE0
,(SELECT IND_STRUCTURE_NAME
	,COST_BASE
	,ROW_NUMBER() OVER(PARTITION BY IND_STRUCTURE_NAME,COST_BASE ORDER BY IND_STRUCTURE_NAME,COST_BASE) X1
	FROM PJF_COST_BASE_COST_CODES 
	) costbaseAssignmentsE0
,PJF_COST_BASE_EXP_TYPES expTypesE0
WHERE bcStructuresE0.IND_STRUCTURE_NAME = costbaseAssignmentsE0.IND_STRUCTURE_NAME
AND costbaseAssignmentsE0.X1 = 1
AND costbaseAssignmentsE0.IND_STRUCTURE_NAME = expTypesE0.IND_STRUCTURE_NAME
AND costbaseAssignmentsE0.COST_BASE = expTypesE0.COST_BASE
ORDER BY bcStructuresE0.IND_STRUCTURE_NAME
,costbaseAssignmentsE0.COST_BASE
,3