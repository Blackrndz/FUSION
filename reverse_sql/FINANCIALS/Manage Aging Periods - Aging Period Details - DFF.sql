/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Aging%20Periods%20-%20Aging%20Period%20Details%20-%20DFF.sql $:
 * $Id: Manage Aging Periods - Aging Period Details - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=200##RES##AP_AGING_PERIOD_LINES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select APAGINGPERIODS.PERIOD_NAME RES_NAME
,ApAgingPeriodLines.PERIOD_SEQUENCE_NUM RES_COLUMN_ORDER
,ApAgingPeriodLines.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ApAgingPeriodLines.ATTRIBUTE1 
,ApAgingPeriodLines.ATTRIBUTE2
,ApAgingPeriodLines.ATTRIBUTE3
,ApAgingPeriodLines.ATTRIBUTE4
,ApAgingPeriodLines.ATTRIBUTE5
,ApAgingPeriodLines.ATTRIBUTE6
,ApAgingPeriodLines.ATTRIBUTE7
,ApAgingPeriodLines.ATTRIBUTE8
,ApAgingPeriodLines.ATTRIBUTE9
,ApAgingPeriodLines.ATTRIBUTE10
,ApAgingPeriodLines.ATTRIBUTE11
,ApAgingPeriodLines.ATTRIBUTE12
,ApAgingPeriodLines.ATTRIBUTE13
,ApAgingPeriodLines.ATTRIBUTE14
,ApAgingPeriodLines.ATTRIBUTE15
,ApAgingPeriodLines.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ApAgingPeriodLines.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ApAgingPeriodLines.CREATED_BY  RSC_CREATED_BY
,ApAgingPeriodLines.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

from AP_AGING_PERIODS APAGINGPERIODS 
,AP_AGING_PERIOD_LINES APAGINGPERIODLINES
WHERE 
(ApAgingPeriodLines.ATTRIBUTE_CATEGORY IS NOT NULL OR
ApAgingPeriodLines.ATTRIBUTE1 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE2 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE3 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE4 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE5 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE6 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE7 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE8 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE9 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE10 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE11 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE12 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE13 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE14 IS NOT NULL OR 
ApAgingPeriodLines.ATTRIBUTE15 IS NOT NULL)
and APAGINGPERIODS.AGING_PERIOD_ID =	APAGINGPERIODLINES.AGING_PERIOD_ID 
order by RES_NAME