/* ****************************************************************************
 * $Revision: 53935 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-03-25 16:18:48 +0700 (Fri, 25 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Statement%20Transaction%20Creation%20Rules%20-%20Manage%20Bank%20Statement%20Transaction%20Creation%20Rules.sql $:
 * $Id: Manage Bank Statement Transaction Creation Rules - Manage Bank Statement Transaction Creation Rules.sql 53935 2016-03-25 09:18:48Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=435##RES##FUN_TRX_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT TransactionTypePEO.TRX_TYPE_CODE RES_CODE
,TransactionTypePEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,TransactionTypePEO.ATTRIBUTE1 
,TransactionTypePEO.ATTRIBUTE2
,TransactionTypePEO.ATTRIBUTE3
,TransactionTypePEO.ATTRIBUTE4
,TransactionTypePEO.ATTRIBUTE5
,TransactionTypePEO.ATTRIBUTE6
,TransactionTypePEO.ATTRIBUTE7
,TransactionTypePEO.ATTRIBUTE8
,TransactionTypePEO.ATTRIBUTE9
,TransactionTypePEO.ATTRIBUTE10
,TransactionTypePEO.ATTRIBUTE11
,TransactionTypePEO.ATTRIBUTE12
,TransactionTypePEO.ATTRIBUTE13
,TransactionTypePEO.ATTRIBUTE14
,TransactionTypePEO.ATTRIBUTE15
,TransactionTypePEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TransactionTypePEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TransactionTypePEO.CREATED_BY RSC_CREATED_BY
,TransactionTypePEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_TRX_TYPES_VL TransactionTypePEO
WHERE (TransactionTypePEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
TransactionTypePEO.ATTRIBUTE1 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE2 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE3 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE4 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE5 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE6 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE7 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE8 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE9 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE10 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE11 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE12 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE13 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE14 IS NOT NULL OR 
TransactionTypePEO.ATTRIBUTE15 IS NOT NULL)
ORDER BY TransactionTypePEO.TRX_TYPE_CODE