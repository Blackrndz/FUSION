/* ****************************************************************************
 * $Revision: 79249 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-24 11:21:56 +0700 (Wed, 24 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payables%20Calendars%20-%20Payables%20Calendar%20-%20DFF.sql $:
 * $Id: Manage Payables Calendars - Payables Calendar - DFF.sql 79249 2022-08-24 04:21:56Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=200##RES##AP_OTHER_PERIOD_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select ApOtherPeriodTypes.CALENDAR_NAME RES_NAME
,(SELECT meaning
	FROM Fusion.FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'MODULE'
	AND LOOKUP_CODE   = APOTHERPERIODTYPES.CALENDAR_TYPE
	AND LANGUAGE = USERENV('LANG')
	) RES_CALENDAR_TYPE
,APOTHERPERIODTYPES.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,APOTHERPERIODTYPES.ATTRIBUTE1 
,APOTHERPERIODTYPES.ATTRIBUTE2
,APOTHERPERIODTYPES.ATTRIBUTE3
,APOTHERPERIODTYPES.ATTRIBUTE4
,APOTHERPERIODTYPES.ATTRIBUTE5
,APOTHERPERIODTYPES.ATTRIBUTE6
,APOTHERPERIODTYPES.ATTRIBUTE7
,APOTHERPERIODTYPES.ATTRIBUTE8
,APOTHERPERIODTYPES.ATTRIBUTE9
,APOTHERPERIODTYPES.ATTRIBUTE10
,APOTHERPERIODTYPES.ATTRIBUTE11
,APOTHERPERIODTYPES.ATTRIBUTE12
,APOTHERPERIODTYPES.ATTRIBUTE13
,APOTHERPERIODTYPES.ATTRIBUTE14
,APOTHERPERIODTYPES.ATTRIBUTE15
,APOTHERPERIODTYPES.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,APOTHERPERIODTYPES.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,APOTHERPERIODTYPES.CREATED_BY  RSC_CREATED_BY
,APOTHERPERIODTYPES.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

from AP_OTHER_PERIOD_TYPES APOTHERPERIODTYPES
WHERE 
APOTHERPERIODTYPES.ATTRIBUTE_CATEGORY IS NOT NULL OR
APOTHERPERIODTYPES.ATTRIBUTE1 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE2 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE3 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE4 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE5 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE6 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE7 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE8 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE9 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE10 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE11 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE12 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE13 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE14 IS NOT NULL OR 
APOTHERPERIODTYPES.ATTRIBUTE15 IS NOT NULL
order by RES_NAME

/*
SELECT ApOtherPeriodTypes.CALENDAR_NAME RES_NAME
, DFF.FIELD_NAME RES_FIELD_NAME
, DFF.FIELD_VALUE RES_FIELD_VALUE
,NULL MAPPER 
,APOTHERPERIODTYPES.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,APOTHERPERIODTYPES.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
FROM FUSION.AP_OTHER_PERIOD_TYPES APOTHERPERIODTYPES
, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
																			  ,P_DFF_CODE => 'AP_OTHER_PERIOD_TYPES'
																			  ,P_BASE_TABLE => 'AP_OTHER_PERIOD_TYPES'
																			  ,P_PK_COLUMN_1 => 'CALENDAR_NAME'																	  
	)) DFF
WHERE DFF.FIELD_VALUE                     IS NOT NULL
AND  APOTHERPERIODTYPES.CALENDAR_NAME = DFF.COL_1
and (APOTHERPERIODTYPES.last_updated_by ##LAST_UPDATED_BY_OPERATOR## (##USER_NAME_LIST##) AND APOTHERPERIODTYPES.last_update_date ##LAST_UPDATE_DATE_OPERATOR##  to_date('##SEEDED_DATE##'))
ORDER BY APOTHERPERIODTYPES.CALENDAR_NAME 
*/