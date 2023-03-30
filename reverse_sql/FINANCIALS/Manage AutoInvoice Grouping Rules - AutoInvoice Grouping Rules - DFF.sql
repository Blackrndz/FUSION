/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Grouping%20Rules%20-%20AutoInvoice%20Grouping%20Rules%20-%20DFF.sql $:
 * $Id: Manage AutoInvoice Grouping Rules - AutoInvoice Grouping Rules - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_GROUPING_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select RaGroupingRules.NAME RES_NAME
,RaGroupingRules.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,RaGroupingRules.ATTRIBUTE1
,RaGroupingRules.ATTRIBUTE2
,RaGroupingRules.ATTRIBUTE3
,RaGroupingRules.ATTRIBUTE4
,RaGroupingRules.ATTRIBUTE5
,RaGroupingRules.ATTRIBUTE6
,RaGroupingRules.ATTRIBUTE7
,RaGroupingRules.ATTRIBUTE8
,RaGroupingRules.ATTRIBUTE9
,RaGroupingRules.ATTRIBUTE10
,RaGroupingRules.ATTRIBUTE11
,RaGroupingRules.ATTRIBUTE12
,RaGroupingRules.ATTRIBUTE13
,RaGroupingRules.ATTRIBUTE14
,RaGroupingRules.ATTRIBUTE15
,RaGroupingRules.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,RaGroupingRules.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
,RaGroupingRules.CREATED_BY  RSC_CREATED_BY
,RaGroupingRules.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM RA_GROUPING_RULES RaGroupingRules
where (RaGroupingRules.ATTRIBUTE_CATEGORY IS NOT NULL OR
RaGroupingRules.ATTRIBUTE1 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE2 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE3 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE4 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE5 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE6 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE7 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE8 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE9 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE10 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE11 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE12 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE13 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE14 IS NOT NULL OR 
RaGroupingRules.ATTRIBUTE15 IS NOT NULL)
ORDER BY RaGroupingRules.NAME