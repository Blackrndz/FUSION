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
-- DFF_LOGIC_TO_APPLY=695##RES##AR_COLLECTORS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT CollectorEO.NAME RES_COLLECTOR_NAME
/*,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'IEX_COLLECTOR_TYPE'
	AND LOOKUP_CODE   = CollectorEO.RESOURCE_TYPE
	) RES_TYPE*/
/*,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CollectorEO.SET_ID
	) RES_COLLECTOR_SET*/
,CollectorEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,CollectorEO.ATTRIBUTE1 
,CollectorEO.ATTRIBUTE2
,CollectorEO.ATTRIBUTE3
,CollectorEO.ATTRIBUTE4
,CollectorEO.ATTRIBUTE5
,CollectorEO.ATTRIBUTE6
,CollectorEO.ATTRIBUTE7
,CollectorEO.ATTRIBUTE8
,CollectorEO.ATTRIBUTE9
,CollectorEO.ATTRIBUTE10
,CollectorEO.ATTRIBUTE11
,CollectorEO.ATTRIBUTE12
,CollectorEO.ATTRIBUTE13
,CollectorEO.ATTRIBUTE14
,CollectorEO.ATTRIBUTE15
,CollectorEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CollectorEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CollectorEO.CREATED_BY RSC_CREATED_BY
,CollectorEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_COLLECTORS CollectorEO
WHERE (CollectorEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
CollectorEO.ATTRIBUTE1 IS NOT NULL OR 
CollectorEO.ATTRIBUTE2 IS NOT NULL OR 
CollectorEO.ATTRIBUTE3 IS NOT NULL OR 
CollectorEO.ATTRIBUTE4 IS NOT NULL OR 
CollectorEO.ATTRIBUTE5 IS NOT NULL OR 
CollectorEO.ATTRIBUTE6 IS NOT NULL OR 
CollectorEO.ATTRIBUTE7 IS NOT NULL OR 
CollectorEO.ATTRIBUTE8 IS NOT NULL OR 
CollectorEO.ATTRIBUTE9 IS NOT NULL OR 
CollectorEO.ATTRIBUTE10 IS NOT NULL OR 
CollectorEO.ATTRIBUTE11 IS NOT NULL OR 
CollectorEO.ATTRIBUTE12 IS NOT NULL OR 
CollectorEO.ATTRIBUTE13 IS NOT NULL OR 
CollectorEO.ATTRIBUTE14 IS NOT NULL OR 
CollectorEO.ATTRIBUTE15 IS NOT NULL)
ORDER BY CollectorEO.SET_ID
,CollectorEO.NAME