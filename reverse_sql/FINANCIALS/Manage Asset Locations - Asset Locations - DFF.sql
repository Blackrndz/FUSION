/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Locations%20-%20Asset%20Locations%20-%20DFF.sql $:
 * $Id: Manage Asset Locations - Asset Locations - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_LOCATIONS
-- DFF_ATTRIBUTES=ATTRIBUTE,SEGMENT_ATTRIBUTE

-- syntax: APPLICATION_ID##RES##KFF_CODE
-- KFF_LOGIC_TO_APPLY=140##RES##LOC#
-- KFF_PREFIX_ALIAS=RES_LOCATION
-- KFF_COLUMN_NAME=SEGMENT

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields. 

SELECT LocationEO.SEGMENT1                           AS RES_LOCATION1
,LocationEO.SEGMENT2                                 AS RES_LOCATION2
,LocationEO.SEGMENT3                                 AS RES_LOCATION3
,LocationEO.SEGMENT4                                 AS RES_LOCATION4
,LocationEO.SEGMENT5                                 AS RES_LOCATION5
,LocationEO.SEGMENT6                                 AS RES_LOCATION6
,LocationEO.SEGMENT7                                 AS RES_LOCATION7
,LocationEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,LocationEO.ATTRIBUTE1
,LocationEO.ATTRIBUTE2
,LocationEO.ATTRIBUTE3
,LocationEO.ATTRIBUTE4
,LocationEO.ATTRIBUTE5
,LocationEO.ATTRIBUTE6
,LocationEO.ATTRIBUTE7
,LocationEO.ATTRIBUTE8
,LocationEO.ATTRIBUTE9
,LocationEO.ATTRIBUTE10
,LocationEO.ATTRIBUTE11
,LocationEO.ATTRIBUTE12
,LocationEO.ATTRIBUTE13
,LocationEO.ATTRIBUTE14
,LocationEO.ATTRIBUTE15
,LocationEO.STRUCTURE_INSTANCE_NUMBER RSC_EXTRA_COLUMN1
,LocationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LocationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LocationEO.CREATED_BY  RSC_CREATED_BY
,LocationEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_LOCATIONS LocationEO
WHERE LocationEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL OR
LocationEO.ATTRIBUTE1 IS NOT NULL OR 
LocationEO.ATTRIBUTE2 IS NOT NULL OR 
LocationEO.ATTRIBUTE3 IS NOT NULL OR 
LocationEO.ATTRIBUTE4 IS NOT NULL OR 
LocationEO.ATTRIBUTE5 IS NOT NULL OR 
LocationEO.ATTRIBUTE6 IS NOT NULL OR 
LocationEO.ATTRIBUTE7 IS NOT NULL OR 
LocationEO.ATTRIBUTE8 IS NOT NULL OR 
LocationEO.ATTRIBUTE9 IS NOT NULL OR 
LocationEO.ATTRIBUTE10 IS NOT NULL OR
LocationEO.ATTRIBUTE11 IS NOT NULL OR 
LocationEO.ATTRIBUTE12 IS NOT NULL OR 
LocationEO.ATTRIBUTE13 IS NOT NULL OR 
LocationEO.ATTRIBUTE14 IS NOT NULL OR 
LocationEO.ATTRIBUTE15 IS NOT NULL  
ORDER BY RES_LOCATION1