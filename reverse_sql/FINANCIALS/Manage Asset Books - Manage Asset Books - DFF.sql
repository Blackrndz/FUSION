/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_BOOK_CONTROLS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT BookControlEO.BOOK_TYPE_CODE RES_NAME
,BookControlEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,BookControlEO.ATTRIBUTE1
,BookControlEO.ATTRIBUTE2
,BookControlEO.ATTRIBUTE3
,BookControlEO.ATTRIBUTE4
,BookControlEO.ATTRIBUTE5
,BookControlEO.ATTRIBUTE6
,BookControlEO.ATTRIBUTE7
,BookControlEO.ATTRIBUTE8
,BookControlEO.ATTRIBUTE9
,BookControlEO.ATTRIBUTE10
,BookControlEO.ATTRIBUTE11
,BookControlEO.ATTRIBUTE12
,BookControlEO.ATTRIBUTE13
,BookControlEO.ATTRIBUTE14
,BookControlEO.ATTRIBUTE15
,BookControlEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BookControlEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BookControlEO.CREATED_BY RSC_CREATED_BY
,BookControlEO.CREATION_DATE RSC_CREATION_DATE
,PGL.PRIMARY_LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_BOOK_CONTROLS BookControlEO
,(select RSHIP.TARGET_LEDGER_ID
	,RSHIP.PRIMARY_LEDGER_ID 
	from GL_LEDGER_RELATIONSHIPS RSHIP
	WHERE (RSHIP.RELATIONSHIP_TYPE_CODE <> 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'SECONDARY')
	OR (RSHIP.RELATIONSHIP_TYPE_CODE = 'NONE'
	AND RSHIP.TARGET_LEDGER_CATEGORY_CODE = 'PRIMARY')) PGL
WHERE(BOOKCONTROLEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE1                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE2                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE3                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE4                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE5                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE6                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE7                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE8                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE9                 IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE10                IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE11                IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE12                IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE13                IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE14                IS NOT NULL
OR BOOKCONTROLEO.ATTRIBUTE15                IS NOT NULL)
AND BOOKCONTROLEO.SET_OF_BOOKS_ID = PGL.TARGET_LEDGER_ID
ORDER BY (CASE
	WHEN BOOKCONTROLEO.BOOK_CLASS = 'CORPORATE' THEN
		1
	ELSE
		2
	END)
,BOOKCONTROLEO.BOOK_TYPE_CODE