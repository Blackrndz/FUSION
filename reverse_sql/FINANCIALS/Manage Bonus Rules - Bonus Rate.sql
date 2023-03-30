/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
SELECT BonusRuleEO.bonus_rule AS RES_NAME,
  (SELECT SetIdSetPE.SET_NAME
  FROM FND_SETID_SETS_VL SetIdSetPE
  WHERE SetIdSetPE.SET_ID = BonusRuleEO.SET_ID
  )                                  AS RES_REFERENCE_DATA_SET,
  BonusRateEO.start_year             AS RES_FROM_YEAR,
  BonusRateEO.end_year               AS RES_TO_YEAR,
  (BonusRateEO.bonus_rate * 100)     AS RES_RATE_PERCENT,
  bonusrateeo.deprn_factor           AS RES_DEPRECIATION_FACTOR,
  bonusrateeo.alternate_deprn_factor AS RES_ALTERNATE_DEPRECIATION_FAC  
  ,bonusrateeo.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,bonusrateeo.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,bonusrateeo.CREATED_BY  RSC_CREATED_BY
  ,bonusrateeo.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_BONUS_RULES BonusRuleEO,
  FA_BONUS_RATES BonusRateEO
WHERE ((1                     =1))
AND BonusRuleEO.bonus_rule_id = BonusRateEO.bonus_rule_id
ORDER BY BonusRuleEO.bonus_rule