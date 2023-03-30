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
-- DFF_LOGIC_TO_APPLY=140##RES##FA_BONUS_RULES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT BonusRuleEO.bonus_rule AS RES_NAME
,(SELECT SetIdSetPE.SET_NAME
	FROM FND_SETID_SETS_VL SetIdSetPE
	WHERE SetIdSetPE.SET_ID = BonusRuleEO.SET_ID
	) AS RES_REFERENCE_DATA_SET
,BonusRuleEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,BonusRuleEO.ATTRIBUTE1
,BonusRuleEO.ATTRIBUTE2
,BonusRuleEO.ATTRIBUTE3
,BonusRuleEO.ATTRIBUTE4
,BonusRuleEO.ATTRIBUTE5
,BonusRuleEO.ATTRIBUTE6
,BonusRuleEO.ATTRIBUTE7
,BonusRuleEO.ATTRIBUTE8
,BonusRuleEO.ATTRIBUTE9
,BonusRuleEO.ATTRIBUTE10
,BonusRuleEO.ATTRIBUTE11
,BonusRuleEO.ATTRIBUTE12
,BonusRuleEO.ATTRIBUTE13
,BonusRuleEO.ATTRIBUTE14
,BonusRuleEO.ATTRIBUTE15
,BonusRuleEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BonusRuleEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BonusRuleEO.CREATED_BY RSC_CREATED_BY
,BonusRuleEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_BONUS_RULES BonusRuleEO
WHERE((1                                 = 1))
AND(BonusRuleEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
OR BonusRuleEO.ATTRIBUTE1               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE2               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE3               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE4               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE5               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE6               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE7               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE8               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE9               IS NOT NULL
OR BonusRuleEO.ATTRIBUTE10              IS NOT NULL
OR BonusRuleEO.ATTRIBUTE11              IS NOT NULL
OR BonusRuleEO.ATTRIBUTE12              IS NOT NULL
OR BonusRuleEO.ATTRIBUTE13              IS NOT NULL
OR BonusRuleEO.ATTRIBUTE14              IS NOT NULL
OR BonusRuleEO.ATTRIBUTE15              IS NOT NULL)
ORDER BY BonusRuleEO.bonus_rule