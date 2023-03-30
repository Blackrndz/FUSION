/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Grouping%20Rules%20-%20Transaction%20Classes%20-%20DFF.sql $:
* $Id: Manage AutoInvoice Grouping Rules - Transaction Classes - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_GROUPING_TRX_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select DISTINCT RaGroupingRules.NAME RES_NAME
  , (
        SELECT meaning
        FROM AR_LOOKUPS ArLookupEO
        WHERE ArLookupEO.LOOKUP_TYPE   = 'GROUPING_TRX_TYPE'
            AND ArLookupEO.LOOKUP_CODE = detail.class)    RES_TRANSACTION_CLASS
,Detail.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,Detail.ATTRIBUTE1
,Detail.ATTRIBUTE2
,Detail.ATTRIBUTE3
,Detail.ATTRIBUTE4
,Detail.ATTRIBUTE5
,Detail.ATTRIBUTE6
,Detail.ATTRIBUTE7
,Detail.ATTRIBUTE8
,Detail.ATTRIBUTE9
,Detail.ATTRIBUTE10
,Detail.ATTRIBUTE11
,Detail.ATTRIBUTE12
,Detail.ATTRIBUTE13
,Detail.ATTRIBUTE14
,Detail.ATTRIBUTE15
,Detail.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  RSC_CREATED_BY
,Detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM RA_GROUPING_RULES RaGroupingRules
  , RA_GROUPING_TRX_TYPES Detail
where (Detail.ATTRIBUTE_CATEGORY IS NOT NULL OR
Detail.ATTRIBUTE1 IS NOT NULL OR 
Detail.ATTRIBUTE2 IS NOT NULL OR 
Detail.ATTRIBUTE3 IS NOT NULL OR 
Detail.ATTRIBUTE4 IS NOT NULL OR 
Detail.ATTRIBUTE5 IS NOT NULL OR 
Detail.ATTRIBUTE6 IS NOT NULL OR 
Detail.ATTRIBUTE7 IS NOT NULL OR 
Detail.ATTRIBUTE8 IS NOT NULL OR 
Detail.ATTRIBUTE9 IS NOT NULL OR 
Detail.ATTRIBUTE10 IS NOT NULL OR 
Detail.ATTRIBUTE11 IS NOT NULL OR 
Detail.ATTRIBUTE12 IS NOT NULL OR 
Detail.ATTRIBUTE13 IS NOT NULL OR 
Detail.ATTRIBUTE14 IS NOT NULL OR 
Detail.ATTRIBUTE15 IS NOT NULL
) and RaGroupingRules.grouping_rule_id = detail.grouping_rule_id
ORDER BY RaGroupingRules.NAME