/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT QRSLT.CONDITION_GROUP_CODE RES_TAX_CONDITION_SET_CODE
,QRSLT.CONDITION_GROUP_NAME RES_TAX_CONDITION_SET_NAME
,QRSLT.DET_FACTOR_TEMPL_CODE RES_TAX_DETERMINING_FACTOR_SET
,QRSLT.LEDGER RES_LEDGER
,QRSLT.TERRITORY_SHORT_NAME RES_COUNTRY
,DECODE(QRSLT.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,QRSLT.LEDGER_ID RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxConditionGroupsVl.CONDITION_GROUP_CODE
	,ZxConditionGroupsVl.CONDITION_GROUP_NAME
	,ZxConditionGroupsVl.DET_FACTOR_TEMPL_CODE
	,ZxConditionGroupsVl.CONDITION_GROUP_ID
	,ZxConditionGroupsVl.ENABLED_FLAG
	,ZxConditionGroupsVl.LEDGER_ID
	,ZxConditionGroupsVl.LAST_UPDATED_BY
	,ZxConditionGroupsVl.LAST_UPDATE_DATE
	,ZxConditionGroupsVl.CREATED_BY
	,ZxConditionGroupsVl.CREATION_DATE
	,CASE
			WHEN ZxConditionGroupsVl.LEDGER_ID IS NOT NULL
			THEN
				(SELECT GlLedgers.NAME
				FROM GL_LEDGERS GlLedgers
				WHERE GlLedgers.LEDGER_ID = ZxConditionGroupsVl.LEDGER_ID
				)
			ELSE NULL
		END AS LEDGER
	,TerritoryEO.TERRITORY_SHORT_NAME
	,TerritoryEO.TERRITORY_CODE
	,(SELECT ZxProcessResults.result_id
		FROM ZX_RULES_VL ZxRulesVL
		,ZX_PROCESS_RESULTS ZxProcessResults
		WHERE ZxRulesVL.tax_rule_id             = ZxProcessResults.tax_rule_id
		AND ZxProcessResults.condition_group_id = ZxConditionGroupsVl.CONDITION_GROUP_ID
		AND rownum                              = 1
		AND ZxRulesVL.never_been_enabled_flag   = 'N'
		) AS REF_IN_RESULT_ID
	,ZxConditionGroupsVl.RECORD_TYPE_CODE
	,DECODE(SUBSTR(DetFactorTemplTLEO.TEMPLATE_USAGE_CODE,1,3),'WHT','W','I') USAGE_TYPE_FLAG
	FROM ZX_CONDITION_GROUPS_VL ZxConditionGroupsVl
	,FND_TERRITORIES_VL TerritoryEO
	,ZX_DET_FACTOR_TEMPL_VL DetFactorTemplTLEO
	WHERE ZxConditionGroupsVl.COUNTRY_CODE        = TerritoryEO.TERRITORY_CODE(+)
	AND ZxConditionGroupsVl.DET_FACTOR_TEMPL_CODE = DetFactorTemplTLEO.DET_FACTOR_TEMPL_CODE(+)
	) QRSLT
WHERE QRSLT.USAGE_TYPE_FLAG = 'I'
ORDER BY "ENABLED_FLAG" DESC
,"CONDITION_GROUP_CODE"
,"DET_FACTOR_TEMPL_CODE"