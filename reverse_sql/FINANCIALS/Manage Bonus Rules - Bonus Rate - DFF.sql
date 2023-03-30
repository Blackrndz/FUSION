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
-- DFF_LOGIC_TO_APPLY=140##RES##FA_BONUS_RATES
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT BonusRuleEO.bonus_rule RES_NAME
,(SELECT SetIdSetPE.SET_NAME
	FROM FND_SETID_SETS_VL SetIdSetPE
	WHERE SetIdSetPE.SET_ID = BonusRuleEO.SET_ID
	) RES_REFERENCE_DATA_SET
,BonusRateEO.start_year RES_FROM_YEAR
,BonusRateEO.ATTRIBUTE_CATEGORY_CODE RES_CONTEXT_CODE
,BonusRateEO.ATTRIBUTE1
,BonusRateEO.ATTRIBUTE2
,BonusRateEO.ATTRIBUTE3
,BonusRateEO.ATTRIBUTE4
,BonusRateEO.ATTRIBUTE5
,BonusRateEO.ATTRIBUTE6
,BonusRateEO.ATTRIBUTE7
,BonusRateEO.ATTRIBUTE8
,BonusRateEO.ATTRIBUTE9
,BonusRateEO.ATTRIBUTE10
,BonusRateEO.ATTRIBUTE11
,BonusRateEO.ATTRIBUTE12
,BonusRateEO.ATTRIBUTE13
,BonusRateEO.ATTRIBUTE14
,BonusRateEO.ATTRIBUTE15
,bonusrateeo.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,bonusrateeo.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,bonusrateeo.CREATED_BY RSC_CREATED_BY
,bonusrateeo.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_BONUS_RULES BonusRuleEO
,FA_BONUS_RATES BonusRateEO
WHERE BonusRuleEO.bonus_rule_id = BonusRateEO.bonus_rule_id
AND(BonusRateEO.ATTRIBUTE_CATEGORY_CODE IS NOT NULL
OR BonusRateEO.ATTRIBUTE1               IS NOT NULL
OR BonusRateEO.ATTRIBUTE2               IS NOT NULL
OR BonusRateEO.ATTRIBUTE3               IS NOT NULL
OR BonusRateEO.ATTRIBUTE4               IS NOT NULL
OR BonusRateEO.ATTRIBUTE5               IS NOT NULL
OR BonusRateEO.ATTRIBUTE6               IS NOT NULL
OR BonusRateEO.ATTRIBUTE7               IS NOT NULL
OR BonusRateEO.ATTRIBUTE8               IS NOT NULL
OR BonusRateEO.ATTRIBUTE9               IS NOT NULL
OR BonusRateEO.ATTRIBUTE10              IS NOT NULL
OR BonusRateEO.ATTRIBUTE11              IS NOT NULL
OR BonusRateEO.ATTRIBUTE12              IS NOT NULL
OR BonusRateEO.ATTRIBUTE13              IS NOT NULL
OR BonusRateEO.ATTRIBUTE14              IS NOT NULL
OR BonusRateEO.ATTRIBUTE15              IS NOT NULL)
ORDER BY BonusRuleEO.bonus_rule