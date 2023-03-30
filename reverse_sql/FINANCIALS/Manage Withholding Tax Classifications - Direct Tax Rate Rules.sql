/* ****************************************************************************
 * $Revision: 55079 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-05-10 11:46:06 +0700 (Tue, 10 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Public%20Unique%20Identifier%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Public Unique Identifier Profile Options - Profile Options.sql 55079 2016-05-10 04:46:06Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

Select ZxRulesVl.TAX_RULE_CODE RES_TAX_CLASSIFICATION_CODE
,ZFPOMV.PARTY_NAME  RES_BUSINESS_UNIT
,Zxprocessresults.Rate_Result RES_TAX_RATE_CODE
,Zxprocessresults.Status_Result RES_TAX_STATUS_CODE
,ZxRulesVl.TAX RES_TAX
,Zxrulesvl.Tax_Regime_Code RES_TAX_REGIME_CODE
,Zxprocessresults.LAST_UPDATED_BY RSC_LAST_UPDATED_BY 
,Zxprocessresults.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Zxprocessresults.CREATED_BY RSC_CREATED_BY
,Zxprocessresults.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,(CASE 
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'OU' THEN	
		ZFPOMV.BU_ID
	ELSE
		NULL
	END) RSC_BUSINESS_UNIT_ID
,(CASE 
	WHEN ZFPOMV.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN	
		ZFPOMV.LEGAL_ENTITY_ID
	ELSE
		NULL
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,Null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_RULES_VL ZxRulesVl
,ZX_PROCESS_RESULTS ZxProcessResults
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
WHERE ZxRulesVl.SERVICE_TYPE_CODE               = 'DET_DIRECT_RATE_STCC'
AND ZxRulesVl.TAX_RULE_ID               = ZxProcessResults.TAX_RULE_ID
AND ZxProcessResults.Condition_group_code = ZxRulesVl.tax_rule_code
AND Zxrulesvl.Content_Owner_Id = ZFPOMV.Party_Tax_Profile_Id(+)
AND ZFPOMV.BU_ID <> 1
order by ZxRulesVl.TAX_RULE_CODE