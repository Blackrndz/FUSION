/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_EXP_TYPES_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT expTypesE0.EXPENDITURE_TYPE_NAME RES_EXPENDITURE_TYPE
,expTypesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,expTypesE0.ATTRIBUTE1
,expTypesE0.ATTRIBUTE2
,expTypesE0.ATTRIBUTE3
,expTypesE0.ATTRIBUTE4
,expTypesE0.ATTRIBUTE5
,expTypesE0.ATTRIBUTE6
,expTypesE0.ATTRIBUTE7
,expTypesE0.ATTRIBUTE8
,expTypesE0.ATTRIBUTE9
,expTypesE0.ATTRIBUTE10
,expTypesE0.ATTRIBUTE11
,expTypesE0.ATTRIBUTE12
,expTypesE0.ATTRIBUTE13
,expTypesE0.ATTRIBUTE14
,expTypesE0.ATTRIBUTE15
,expTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,expTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,expTypesE0.CREATED_BY RSC_CREATED_BY
,expTypesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_TYPES_VL expTypesE0
WHERE (expTypesE0.ATTRIBUTE_CATEGORY IS NOT NULL OR
expTypesE0.ATTRIBUTE1 IS NOT NULL OR 
expTypesE0.ATTRIBUTE2 IS NOT NULL OR 
expTypesE0.ATTRIBUTE3 IS NOT NULL OR 
expTypesE0.ATTRIBUTE4 IS NOT NULL OR 
expTypesE0.ATTRIBUTE5 IS NOT NULL OR 
expTypesE0.ATTRIBUTE6 IS NOT NULL OR 
expTypesE0.ATTRIBUTE7 IS NOT NULL OR 
expTypesE0.ATTRIBUTE8 IS NOT NULL OR 
expTypesE0.ATTRIBUTE9 IS NOT NULL OR 
expTypesE0.ATTRIBUTE10 IS NOT NULL OR 
expTypesE0.ATTRIBUTE11 IS NOT NULL OR 
expTypesE0.ATTRIBUTE12 IS NOT NULL OR 
expTypesE0.ATTRIBUTE13 IS NOT NULL OR 
expTypesE0.ATTRIBUTE14 IS NOT NULL OR 
expTypesE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY expTypesE0.EXPENDITURE_TYPE_NAME