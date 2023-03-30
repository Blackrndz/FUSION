/* ****************************************************************************
 * $Revision: 53540 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:13:43 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Rate%20Types.sql $:
 * $Id: Currency Rates Manager - Rate Types.sql 53540 2016-03-15 08:13:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=101##RES##GL_DAILY_CONVERSION_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
SELECT DAILYCONVERSIONTYPEEO.USER_CONVERSION_TYPE RES_NAME
,DAILYCONVERSIONTYPEEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,DAILYCONVERSIONTYPEEO.ATTRIBUTE1
,DAILYCONVERSIONTYPEEO.ATTRIBUTE2
,DAILYCONVERSIONTYPEEO.ATTRIBUTE3
,DAILYCONVERSIONTYPEEO.ATTRIBUTE4
,DAILYCONVERSIONTYPEEO.ATTRIBUTE5
,DAILYCONVERSIONTYPEEO.ATTRIBUTE6
,DAILYCONVERSIONTYPEEO.ATTRIBUTE7
,DAILYCONVERSIONTYPEEO.ATTRIBUTE8
,DAILYCONVERSIONTYPEEO.ATTRIBUTE9
,DAILYCONVERSIONTYPEEO.ATTRIBUTE10
,DAILYCONVERSIONTYPEEO.ATTRIBUTE11
,DAILYCONVERSIONTYPEEO.ATTRIBUTE12
,DAILYCONVERSIONTYPEEO.ATTRIBUTE13
,DAILYCONVERSIONTYPEEO.ATTRIBUTE14
,DAILYCONVERSIONTYPEEO.ATTRIBUTE15
,DAILYCONVERSIONTYPEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DAILYCONVERSIONTYPEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DAILYCONVERSIONTYPEEO.CREATED_BY RSC_CREATED_BY
,DAILYCONVERSIONTYPEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,DAILYCONVERSIONTYPEEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GL_DAILY_CONVERSION_TYPES DAILYCONVERSIONTYPEEO
WHERE(DAILYCONVERSIONTYPEEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE1            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE2            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE3            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE4            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE5            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE6            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE7            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE8            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE9            IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE10           IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE11           IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE12           IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE13           IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE14           IS NOT NULL
OR DAILYCONVERSIONTYPEEO.ATTRIBUTE15           IS NOT NULL)
ORDER BY RES_NAME