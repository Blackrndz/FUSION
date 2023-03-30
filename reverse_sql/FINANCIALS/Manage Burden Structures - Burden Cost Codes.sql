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
,costbaseAssignmentsE0.IND_COST_CODE RES_BURDEN_COST_CODE
,costbaseAssignmentsE0.PRECEDENCE RES_PRECEDENCE
,costbaseAssignmentsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,costbaseAssignmentsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,costbaseAssignmentsE0.CREATED_BY  RSC_CREATED_BY
,costbaseAssignmentsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COST_PLUS_STRUCTURES bcStructuresE0
,PJF_COST_BASE_COST_CODES costbaseAssignmentsE0
WHERE bcStructuresE0.IND_STRUCTURE_NAME = costbaseAssignmentsE0.IND_STRUCTURE_NAME
ORDER BY bcStructuresE0.IND_STRUCTURE_NAME
,costbaseAssignmentsE0.COST_BASE
,costbaseAssignmentsE0.IND_COST_CODE