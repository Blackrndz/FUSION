/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10037##RES##PJF_IND_COST_CODE_DESC_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
 
SELECT bcCodesE0.IND_COST_CODE RES_BURDEN_COST_CODE
,bcCodesE0.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,bcCodesE0.ATTRIBUTE1
,bcCodesE0.ATTRIBUTE2
,bcCodesE0.ATTRIBUTE3
,bcCodesE0.ATTRIBUTE4
,bcCodesE0.ATTRIBUTE5
,bcCodesE0.ATTRIBUTE6
,bcCodesE0.ATTRIBUTE7
,bcCodesE0.ATTRIBUTE8
,bcCodesE0.ATTRIBUTE9
,bcCodesE0.ATTRIBUTE10
,bcCodesE0.ATTRIBUTE11
,bcCodesE0.ATTRIBUTE12
,bcCodesE0.ATTRIBUTE13
,bcCodesE0.ATTRIBUTE14
,bcCodesE0.ATTRIBUTE15
,bcCodesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,bcCodesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,bcCodesE0.CREATED_BY  RSC_CREATED_BY
,bcCodesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_IND_COST_CODES bcCodesE0
WHERE (bcCodesE0.ATTRIBUTE_CATEGORY IS NOT NULL
OR bcCodesE0.ATTRIBUTE1 IS NOT NULL
OR bcCodesE0.ATTRIBUTE2 IS NOT NULL
OR bcCodesE0.ATTRIBUTE3 IS NOT NULL
OR bcCodesE0.ATTRIBUTE4 IS NOT NULL
OR bcCodesE0.ATTRIBUTE5 IS NOT NULL
OR bcCodesE0.ATTRIBUTE6 IS NOT NULL
OR bcCodesE0.ATTRIBUTE7 IS NOT NULL
OR bcCodesE0.ATTRIBUTE8 IS NOT NULL
OR bcCodesE0.ATTRIBUTE9 IS NOT NULL
OR bcCodesE0.ATTRIBUTE10 IS NOT NULL
OR bcCodesE0.ATTRIBUTE11 IS NOT NULL
OR bcCodesE0.ATTRIBUTE12 IS NOT NULL
OR bcCodesE0.ATTRIBUTE13 IS NOT NULL
OR bcCodesE0.ATTRIBUTE14 IS NOT NULL
OR bcCodesE0.ATTRIBUTE15 IS NOT NULL)
ORDER BY bcCodesE0.IND_COST_CODE