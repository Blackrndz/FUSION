/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Asset%20Category%20-%20DFF.sql $:
* $Id: Manage Asset Categories - Asset Category - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_CATEGORIES
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT FaCategoryB.SEGMENT1 AS RES_CATEGORY1
,FaCategoryB.SEGMENT2       AS RES_CATEGORY2
,FaCategoryB.SEGMENT3       AS RES_CATEGORY3
,FaCategoryB.SEGMENT4       AS RES_CATEGORY4
,FaCategoryB.SEGMENT5       AS RES_CATEGORY5
,FaCategoryB.SEGMENT6       AS RES_CATEGORY6
,FaCategoryB.SEGMENT7       AS RES_CATEGORY7
,FaCategoryB.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,FaCategoryB.ATTRIBUTE1
,FaCategoryB.ATTRIBUTE2
,FaCategoryB.ATTRIBUTE3
,FaCategoryB.ATTRIBUTE4
,FaCategoryB.ATTRIBUTE5
,FaCategoryB.ATTRIBUTE6
,FaCategoryB.ATTRIBUTE7
,FaCategoryB.ATTRIBUTE8
,FaCategoryB.ATTRIBUTE9
,FaCategoryB.ATTRIBUTE10
,FaCategoryB.ATTRIBUTE11
,FaCategoryB.ATTRIBUTE12
,FaCategoryB.ATTRIBUTE13
,FaCategoryB.ATTRIBUTE14
,FaCategoryB.ATTRIBUTE15
,FaCategoryB.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FaCategoryB.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FaCategoryB.CREATED_BY RSC_CREATED_BY
,FaCategoryB.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CATEGORIES_B FaCategoryB
WHERE(FaCategoryB.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
OR FaCategoryB.ATTRIBUTE1                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE2                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE3                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE4                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE5                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE6                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE7                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE8                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE9                 IS NOT NULL
OR FaCategoryB.ATTRIBUTE10                IS NOT NULL
OR FaCategoryB.ATTRIBUTE11                IS NOT NULL
OR FaCategoryB.ATTRIBUTE12                IS NOT NULL
OR FaCategoryB.ATTRIBUTE13                IS NOT NULL
OR FaCategoryB.ATTRIBUTE14                IS NOT NULL
OR FaCategoryB.ATTRIBUTE15                IS NOT NULL)
ORDER BY RES_CATEGORY1