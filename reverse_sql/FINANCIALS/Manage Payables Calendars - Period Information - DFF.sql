/* ****************************************************************************
 * $Revision: 79000 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-07-14 10:18:43 +0700 (Thu, 14 Jul 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payables%20Calendars%20-%20Period%20Information%20-%20DFF.sql $:
 * $Id: Manage Payables Calendars - Period Information - DFF.sql 79000 2022-07-14 03:18:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=200##RES##AP_OTHER_PERIODS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select ApOtherPeriods.CALENDAR_NAME RES_NAME
,(SELECT meaning
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'MODULE'
	AND LOOKUP_CODE   = FLEXFIELDDATAEO.CALENDAR_TYPE
	) RES_CALENDAR_TYPE
,ApOtherPeriods.ENTERED_PERIOD_NAME RES_PERIOD_NAME_PREFIX
,ApOtherPeriods.PERIOD_YEAR RES_YEAR
,ApOtherPeriods.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ApOtherPeriods.ATTRIBUTE1 
,ApOtherPeriods.ATTRIBUTE2
,ApOtherPeriods.ATTRIBUTE3
,ApOtherPeriods.ATTRIBUTE4
,ApOtherPeriods.ATTRIBUTE5
,ApOtherPeriods.ATTRIBUTE6
,ApOtherPeriods.ATTRIBUTE7
,ApOtherPeriods.ATTRIBUTE8
,ApOtherPeriods.ATTRIBUTE9
,ApOtherPeriods.ATTRIBUTE10
,ApOtherPeriods.ATTRIBUTE11
,ApOtherPeriods.ATTRIBUTE12
,ApOtherPeriods.ATTRIBUTE13
,ApOtherPeriods.ATTRIBUTE14
,ApOtherPeriods.ATTRIBUTE15
,ApOtherPeriods.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ApOtherPeriods.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ApOtherPeriods.CREATED_BY  RSC_CREATED_BY
,ApOtherPeriods.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
from AP_OTHER_PERIODS APOTHERPERIODS
,AP_OTHER_PERIOD_TYPES FLEXFIELDDATAEO
WHERE (ApOtherPeriods.ATTRIBUTE_CATEGORY IS NOT NULL OR
ApOtherPeriods.ATTRIBUTE1 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE2 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE3 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE4 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE5 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE6 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE7 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE8 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE9 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE10 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE11 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE12 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE13 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE14 IS NOT NULL OR 
ApOtherPeriods.ATTRIBUTE15 IS NOT NULL) 
and APOTHERPERIODS.CALENDAR_NAME = FLEXFIELDDATAEO.CALENDAR_NAME
AND APOTHERPERIODS.CALENDAR_TYPE = FLEXFIELDDATAEO.CALENDAR_TYPE	
order by ApOtherPeriods.PERIOD_YEAR
,ApOtherPeriods.PERIOD_NUM 