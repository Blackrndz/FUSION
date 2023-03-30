/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Accounts%20Rules%20-%20DFF.sql $:
* $Id: Manage Asset Categories - Accounts Rules - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_CATEGORY_BOOKS
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for attributes fields.

SELECT faCatsE0.SEGMENT1 AS RES_CATEGORY1
,faCatsE0.SEGMENT2 AS RES_CATEGORY2
,faCatsE0.SEGMENT3 AS RES_CATEGORY3
,faCatsE0.SEGMENT4 AS RES_CATEGORY4
,faCatsE0.SEGMENT5 AS RES_CATEGORY5
,faCatsE0.SEGMENT6 AS RES_CATEGORY6
,faCatsE0.SEGMENT7 AS RES_CATEGORY7
,CategoryBookEO.BOOK_TYPE_CODE AS RES_BOOK
,CategoryBookEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,CategoryBookEO.ATTRIBUTE1
,CategoryBookEO.ATTRIBUTE2
,CategoryBookEO.ATTRIBUTE3
,CategoryBookEO.ATTRIBUTE4
,CategoryBookEO.ATTRIBUTE5
,CategoryBookEO.ATTRIBUTE6
,CategoryBookEO.ATTRIBUTE7
,CategoryBookEO.ATTRIBUTE8
,CategoryBookEO.ATTRIBUTE9
,CategoryBookEO.ATTRIBUTE10
,CategoryBookEO.ATTRIBUTE11
,CategoryBookEO.ATTRIBUTE12
,CategoryBookEO.ATTRIBUTE13
,CategoryBookEO.ATTRIBUTE14
,CategoryBookEO.ATTRIBUTE15
,CategoryBookEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CategoryBookEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CategoryBookEO.CREATED_BY RSC_CREATED_BY
,CategoryBookEO.CREATION_DATE RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CATEGORY_BOOKS CategoryBookEO
,FA_BOOK_CONTROLS BookControlPEO
,FA_CATEGORIES_B faCatsE0
,(select RSHIP.TARGET_LEDGER_ID
	, RSHIP.PRIMARY_LEDGER_ID 
	from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
WHERE(CategoryBookEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
OR CategoryBookEO.ATTRIBUTE1                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE2                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE3                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE4                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE5                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE6                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE7                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE8                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE9                 IS NOT NULL
OR CategoryBookEO.ATTRIBUTE10                IS NOT NULL
OR CategoryBookEO.ATTRIBUTE11                IS NOT NULL
OR CategoryBookEO.ATTRIBUTE12                IS NOT NULL
OR CategoryBookEO.ATTRIBUTE13                IS NOT NULL
OR CategoryBookEO.ATTRIBUTE14                IS NOT NULL
OR CategoryBookEO.ATTRIBUTE15                IS NOT NULL)
AND CategoryBookEO.BOOK_TYPE_CODE = BookControlPEO.BOOK_TYPE_CODE
AND BookControlPEO.SET_OF_BOOKS_ID = PGL.TARGET_LEDGER_ID
AND CategoryBookEO.CATEGORY_ID = faCatsE0.CATEGORY_ID
ORDER BY RES_CATEGORY1