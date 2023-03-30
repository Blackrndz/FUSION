/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Aging%20Periods%20-%20Aging%20Period%20-%20DFF.sql $:
 * $Id: Manage Aging Periods - Aging Period - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=200##RES##AP_AGING_PERIODS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select ApAgingPeriods.PERIOD_NAME RES_NAME
,APAGINGPERIODS.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,APAGINGPERIODS.ATTRIBUTE1 
,APAGINGPERIODS.ATTRIBUTE2
,APAGINGPERIODS.ATTRIBUTE3
,APAGINGPERIODS.ATTRIBUTE4
,APAGINGPERIODS.ATTRIBUTE5
,APAGINGPERIODS.ATTRIBUTE6
,APAGINGPERIODS.ATTRIBUTE7
,APAGINGPERIODS.ATTRIBUTE8
,APAGINGPERIODS.ATTRIBUTE9
,APAGINGPERIODS.ATTRIBUTE10
,APAGINGPERIODS.ATTRIBUTE11
,APAGINGPERIODS.ATTRIBUTE12
,APAGINGPERIODS.ATTRIBUTE13
,APAGINGPERIODS.ATTRIBUTE14
,APAGINGPERIODS.ATTRIBUTE15
,APAGINGPERIODS.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,APAGINGPERIODS.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,APAGINGPERIODS.CREATED_BY  RSC_CREATED_BY
,APAGINGPERIODS.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

from AP_AGING_PERIODS APAGINGPERIODS 
WHERE 
APAGINGPERIODS.ATTRIBUTE_CATEGORY IS NOT NULL OR
APAGINGPERIODS.ATTRIBUTE1 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE2 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE3 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE4 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE5 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE6 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE7 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE8 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE9 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE10 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE11 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE12 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE13 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE14 IS NOT NULL OR 
APAGINGPERIODS.ATTRIBUTE15 IS NOT NULL
order by RES_NAME