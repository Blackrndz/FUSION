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
,(SELECT ABC_CLASS_NAME
	FROM INV_ABC_CLASSES
	WHERE ABC_CLASS_ID = CCClassesE0.ABC_CLASS_ID
	) RES_ABC_CLASS
,CCClassesE0.NUM_COUNTS_PER_YEAR RES_COUNTS_PER_YEAR
,CCClassesE0.COST_TOLERANCE_POSITIVE RES_ADJUSTMENT_VALUE_TOLERANCE
,CCClassesE0.COST_TOLERANCE_NEGATIVE RES_ADJUSTMENT_VALUE_TOLERAN_0
,CCClassesE0.APPROVAL_TOLERANCE_POSITIVE RES_QUANTITY_VARIANCE_PERCENTA
,CCClassesE0.APPROVAL_TOLERANCE_NEGATIVE RES_QUANTITY_VARIANCE_PERCEN_1
,CCClassesE0.HIT_MISS_TOLERANCE_POSITIVE RES_HIT_AND_MISS_PERCENTAGE_PO
,CCClassesE0.HIT_MISS_TOLERANCE_NEGATIVE RES_HIT_AND_MISS_PERCENTAGE_NE
,CCClassesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CCClassesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CCClassesE0.CREATED_BY  RSC_CREATED_BY
,CCClassesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,CycleCountHE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM INV_CYCLE_COUNT_HEADERS CycleCountHE0
,INV_CYCLE_COUNT_CLASSES CCClassesE0
WHERE CycleCountHE0.CYCLE_COUNT_HEADER_ID = CCClassesE0.CYCLE_COUNT_HEADER_ID
AND CycleCountHE0.ORGANIZATION_ID = CCClassesE0.ORGANIZATION_ID
ORDER BY 1,2,3