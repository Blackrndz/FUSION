/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Common%20Lookups%20-%20Lookup%20Codes%20-%20DFF.sql $:
 * $Id: Manage Common Lookups - Lookup Codes - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_LOOKUP_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SELECT FndLookupType.LOOKUP_TYPE RES_LOOKUP_TYPE
,fndlookups.LOOKUP_CODE RES_LOOKUP_CODE
,fndlookups.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,fndlookups.ATTRIBUTE1
,fndlookups.ATTRIBUTE2
,fndlookups.ATTRIBUTE3
,fndlookups.ATTRIBUTE4
,fndlookups.ATTRIBUTE5
,fndlookups.ATTRIBUTE6
,fndlookups.ATTRIBUTE7
,fndlookups.ATTRIBUTE8
,fndlookups.ATTRIBUTE9
,fndlookups.ATTRIBUTE10
,fndlookups.ATTRIBUTE11
,fndlookups.ATTRIBUTE12
,fndlookups.ATTRIBUTE13
,fndlookups.ATTRIBUTE14
,fndlookups.ATTRIBUTE15
,fndlookups.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndlookups.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndlookups.CREATED_BY RSC_CREATED_BY
,fndlookups.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES_VL fndlookups
,FND_LOOKUP_TYPES_VL FndLookupType
WHERE(fndlookups.ATTRIBUTE_CATEGORY IS NOT NULL
OR fndlookups.ATTRIBUTE1            IS NOT NULL
OR fndlookups.ATTRIBUTE2            IS NOT NULL
OR fndlookups.ATTRIBUTE3            IS NOT NULL
OR fndlookups.ATTRIBUTE4            IS NOT NULL
OR fndlookups.ATTRIBUTE5            IS NOT NULL
OR fndlookups.ATTRIBUTE6            IS NOT NULL
OR fndlookups.ATTRIBUTE7            IS NOT NULL
OR fndlookups.ATTRIBUTE8            IS NOT NULL
OR fndlookups.ATTRIBUTE9            IS NOT NULL
OR fndlookups.ATTRIBUTE10           IS NOT NULL
OR fndlookups.ATTRIBUTE11           IS NOT NULL
OR fndlookups.ATTRIBUTE12           IS NOT NULL
OR fndlookups.ATTRIBUTE13           IS NOT NULL
OR fndlookups.ATTRIBUTE14           IS NOT NULL
OR fndlookups.ATTRIBUTE15           IS NOT NULL)
AND fndlookups.VIEW_APPLICATION_ID = '3'
AND fndlookups.SET_ID = 0
AND FndLookupType.LOOKUP_TYPE = fndlookups.LOOKUP_TYPE
ORDER BY RES_LOOKUP_TYPE
,fndlookups.DISPLAY_SEQUENCE