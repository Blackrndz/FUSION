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
,DECODE(CycleCountHE0.AUTOSCHEDULE_ENABLED_FLAG,1,'Yes','No') RES_AUTOMATICALLY_SCHEDULE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_CC_SCHED_TIME'
	AND LOOKUP_CODE = CycleCountHE0.SCHEDULE_INTERVAL_TIME
	) RES_FREQUENCY
,(SELECT SCHEDULE_NAME
	FROM ZMM_SR_SCHEDULES_TL
	WHERE SCHEDULE_ID = CycleCountHE0.WORKDAY_SCHEDULE
	AND LANGUAGE = USERENV('LANG')
	) RES_WORKDAY_SCHEDULE
,TO_CHAR(CycleCountHE0.HEADER_LAST_SCHEDULE_DATE,'DD-Mon-YYYY') RES_LAST_SCHEDULED_DATE
,TO_CHAR(CycleCountHE0.HEADER_NEXT_SCHEDULE_DATE,'DD-Mon-YYYY') RES_NEXT_SCHEDULED_DATE
,DECODE(CycleCountHE0.APPROVAL_REQUIRED,1,'Yes','No') RES_APPROVAL_REQUIRED
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_APPROVAL_REQ'
	AND LOOKUP_CODE = CycleCountHE0.APPROVAL_OPTION_CODE
	) RES_APPROVAL_TYPE
,CycleCountHE0.APPROVAL_TOLERANCE_POSITIVE RES_POSITIVE_QUANTITY_TOLERANC
,CycleCountHE0.APPROVAL_TOLERANCE_NEGATIVE RES_NEGATIVE_QUANTITY_TOLERANC
,CycleCountHE0.COST_TOLERANCE_POSITIVE RES_POSITIVE_ADJUSTMENT_VALUE_
,CycleCountHE0.COST_TOLERANCE_NEGATIVE RES_NEGATIVE_ADJUSTMENT_VALUE_
,CycleCountHE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CycleCountHE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CycleCountHE0.CREATED_BY  RSC_CREATED_BY
,CycleCountHE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,CycleCountHE0.ORGANIZATION_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM INV_CYCLE_COUNT_HEADERS CycleCountHE0
ORDER BY 1,2