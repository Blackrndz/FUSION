/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Labor%20Costing%20Rules%20-%20Labor%20Costing%20Rules%20-%20DFF.sql $:
* $Id: Manage Labor Costing Rules - Labor Costing Rules - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_COMP_RULE_SET_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT pjfCompRuleEO.COMP_RULE_SET_NAME		RES_NAME
,pjfCompRuleEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,pjfCompRuleEO.ATTRIBUTE1
,pjfCompRuleEO.ATTRIBUTE2
,pjfCompRuleEO.ATTRIBUTE3
,pjfCompRuleEO.ATTRIBUTE4
,pjfCompRuleEO.ATTRIBUTE5
,pjfCompRuleEO.ATTRIBUTE6
,pjfCompRuleEO.ATTRIBUTE7
,pjfCompRuleEO.ATTRIBUTE8
,pjfCompRuleEO.ATTRIBUTE9
,pjfCompRuleEO.ATTRIBUTE10
,pjfCompRuleEO.ATTRIBUTE11
,pjfCompRuleEO.ATTRIBUTE12
,pjfCompRuleEO.ATTRIBUTE13
,pjfCompRuleEO.ATTRIBUTE14
,pjfCompRuleEO.ATTRIBUTE15
,pjfCompRuleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfCompRuleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfCompRuleEO.CREATED_BY  RSC_CREATED_BY
,pjfCompRuleEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSCT_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_COMP_RULE_SETS pjfCompRuleEO
WHERE pjfCompRuleEO.COMP_RULE_SET_NAME IS NOT NULL 
AND (pjfCompRuleEO.ATTRIBUTE_CATEGORY IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE1    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE2    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE3    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE4    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE5    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE6    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE7    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE8    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE9    IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE10   IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE11   IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE12   IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE13   IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE14   IS NOT NULL
OR pjfCompRuleEO.ATTRIBUTE15   IS NOT NULL
)
ORDER BY pjfCompRuleEO.COMP_RULE_SET_NAME