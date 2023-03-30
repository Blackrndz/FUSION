/* ****************************************************************************
 * $Revision: 54055 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-03-29 17:10:48 +0700 (Tue, 29 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Resource%20Role%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Resource Role Lookups - Lookup Codes.sql 54055 2016-03-29 10:10:48Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=0##RES##FND_LOOKUP_VALUES_B
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select LookupValueTranslationEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LookupValueTranslationEO.LOOKUP_CODE RES_LOOKUP_CODE
,LookupValueTranslationEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,LookupValueTranslationEO.ATTRIBUTE1 
,LookupValueTranslationEO.ATTRIBUTE2
,LookupValueTranslationEO.ATTRIBUTE3
,LookupValueTranslationEO.ATTRIBUTE4
,LookupValueTranslationEO.ATTRIBUTE5
,LookupValueTranslationEO.ATTRIBUTE6
,LookupValueTranslationEO.ATTRIBUTE7
,LookupValueTranslationEO.ATTRIBUTE8
,LookupValueTranslationEO.ATTRIBUTE9
,LookupValueTranslationEO.ATTRIBUTE10
,LookupValueTranslationEO.ATTRIBUTE11
,LookupValueTranslationEO.ATTRIBUTE12
,LookupValueTranslationEO.ATTRIBUTE13
,LookupValueTranslationEO.ATTRIBUTE14
,LookupValueTranslationEO.ATTRIBUTE15
,LookupValueTranslationEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,LookupValueTranslationEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,LookupValueTranslationEO.CREATED_BY  RSC_CREATED_BY
,LookupValueTranslationEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.FND_LOOKUP_VALUES_VL  LookupValueTranslationEO
WHERE LOOKUP_TYPE= 'JTF_RS_ROLE_TYPE'
AND (LookupValueTranslationEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
LookupValueTranslationEO.ATTRIBUTE1 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE2 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE3 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE4 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE5 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE6 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE7 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE8 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE9 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE10 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE11 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE12 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE13 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE14 IS NOT NULL OR 
LookupValueTranslationEO.ATTRIBUTE15 IS NOT NULL)
ORDER BY LookupValueTranslationEO.LOOKUP_TYPE 
,LookupValueTranslationEO.DISPLAY_SEQUENCE