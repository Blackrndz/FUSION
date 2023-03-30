/* ****************************************************************************
 * $Revision: 61060 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-17 09:40:24 +0700 (Fri, 17 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Application%20Tax%20Options%20-%20Application%20Tax%20Options.sql $:
 * $Id: Manage Application Tax Options - Application Tax Options.sql 61060 2017-02-17 02:40:24Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT ZFPOMV.PARTY_NAME RES_CONFIGURATION_OWNER
,ZxRulesVl.TAX_RULE_CODE RES_RULE_CODE
,ZxRulesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxRulesVl.TAX RES_TAX
,detFactorsE0.DET_FACTOR_TEMPL_CODE RES_TAX_DETERMINING_FACTOR_SET
,ZxProcessResults.CONDITION_GROUP_CODE RES_TAX_CONDITION_SET_CODE
,ZxConditionGroupsVl.CONDITION_GROUP_NAME RES_TAX_CONDITION_SET_NAME
,ZxProcessResults.PRIORITY RES_TAX_CONDITION_SET_ORDER
,ZxProcessResults.PRIORITY RES_NEW_CONDITION_SET_ORDER
,DECODE(ZxProcessResults.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,ZxRulesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxRulesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxRulesVl.CREATED_BY RSC_CREATED_BY
,ZxRulesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'OU' THEN
		ZFPOMV.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		ZFPOMV.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,Null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM ZX_RULES_VL ZxRulesVl
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
,ZX_REGIMES_VL ZxRegimesVl
,ZX_PROCESS_RESULTS ZxProcessResults
,ZX_CONDITION_GROUPS_VL ZxConditionGroupsVl
,ZX_DET_FACTOR_TEMPL_VL detFactorsE0
WHERE ZxRegimesVl.TAX_REGIME_CODE         = ZxRulesVl.TAX_REGIME_CODE
AND ZxRulesVl.CONTENT_OWNER_ID            = ZFPOMV.PARTY_TAX_PROFILE_ID
AND NVL(ZxRegimesVl.REGIME_TYPE_FLAG,'I') = 'I'
AND ZxRulesVl.SERVICE_TYPE_CODE = 'DET_TAX_BOX'
AND ZxRulesVl.TAX_RULE_ID = ZxProcessResults.TAX_RULE_ID
AND ZxProcessResults.CONDITION_GROUP_ID = ZxConditionGroupsVl.CONDITION_GROUP_ID(+)
AND ZxRulesVl.DET_FACTOR_TEMPL_CODE = detFactorsE0.DET_FACTOR_TEMPL_CODE
ORDER BY ZxRulesVl.TAX_RULE_CODE
,ZxProcessResults.CONDITION_GROUP_CODE