/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT ORGANIZATION_CODE 
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = CycleCountHE0.ORGANIZATION_ID
	) RES_ORGANIZATION
,CycleCountHE0.CYCLE_COUNT_HEADER_NAME RES_COUNT_NAME
,CCSubInvE0.SUBINVENTORY RES_SUBINVENTORY
,'Yes' RES_INCLUDE_IN_COUNT
,CCSubInvE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CCSubInvE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CCSubInvE0.CREATED_BY  RSC_CREATED_BY
,CCSubInvE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,CycleCountHE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM INV_CYCLE_COUNT_HEADERS CycleCountHE0
,INV_CC_SUBINVENTORIES CCSubInvE0
WHERE CycleCountHE0.CYCLE_COUNT_HEADER_ID = CCSubInvE0.CYCLE_COUNT_HEADER_ID
AND CycleCountHE0.ORGANIZATION_ID = CCSubInvE0.ORGANIZATION_ID
ORDER BY 1,2,3