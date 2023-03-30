/* ****************************************************************************
 * $Revision: 53799 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-23 09:32:49 +0700 (Wed, 23 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fiscal%20Years%20-%20Fiscal%20Years%20Details.sql $:
 * $Id: Manage Fiscal Years - Fiscal Years Details.sql 53799 2016-03-23 02:32:49Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
  
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=140##RES##FA_FISCAL_YEAR
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select FiscalYearEO.FISCAL_YEAR_NAME RES_NAME
,FiscalYearEO.FISCAL_YEAR RES_FISCAL_YEAR
,FiscalYearEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,FiscalYearEO.ATTRIBUTE1 
,FiscalYearEO.ATTRIBUTE2
,FiscalYearEO.ATTRIBUTE3
,FiscalYearEO.ATTRIBUTE4
,FiscalYearEO.ATTRIBUTE5
,FiscalYearEO.ATTRIBUTE6
,FiscalYearEO.ATTRIBUTE7
,FiscalYearEO.ATTRIBUTE8
,FiscalYearEO.ATTRIBUTE9
,FiscalYearEO.ATTRIBUTE10
,FiscalYearEO.ATTRIBUTE11
,FiscalYearEO.ATTRIBUTE12
,FiscalYearEO.ATTRIBUTE13
,FiscalYearEO.ATTRIBUTE14
,FiscalYearEO.ATTRIBUTE15
,FiscalYearEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,FiscalYearEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,FiscalYearEO.CREATED_BY  RSC_CREATED_BY
,FiscalYearEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_FISCAL_YEAR_TYPES_VL FISCALYEARTY
	,FA_FISCAL_YEAR FISCALYEAREO
where FISCALYEARTY.FISCAL_YEAR_NAME = FISCALYEAREO.FISCAL_YEAR_NAME
AND (FiscalYearEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL OR
FiscalYearEO.ATTRIBUTE1 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE2 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE3 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE4 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE5 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE6 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE7 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE8 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE9 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE10 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE11 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE12 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE13 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE14 IS NOT NULL OR 
FiscalYearEO.ATTRIBUTE15 IS NOT NULL)
ORDER BY FiscalYearEO.FISCAL_YEAR_NAME
,FiscalYearEO.FISCAL_YEAR 