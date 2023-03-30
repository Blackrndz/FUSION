/* ****************************************************************************
 * $Revision: 55079 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-05-10 11:46:06 +0700 (Tue, 10 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Public%20Unique%20Identifier%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Public Unique Identifier Profile Options - Profile Options.sql 55079 2016-05-10 04:46:06Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

Select DISTINCT ZxRulesVl.TAX_RULE_CODE RES_TAX_CLASSIFICATION_CODE
,ZFPOMV.PARTY_NAME RES_BUSINESS_UNIT
,ZxFormulaDetails.COMPOUNDING_TAX RES_COMPOUNDING_TAX
,ZxFormulaDetails.COMPOUNDING_TAX_REGIME_CODE RES_COMPOUNDING_TAX_REGIME_COD
,ZxFormulaDetails.COMPOUNDING_PRECEDENCE RES_COMPOUNDING_PRECEDENCE
,ZxFormulaDetails.LAST_UPDATED_BY RSC_LAST_UPDATED_BY 
,ZxFormulaDetails.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxFormulaDetails.CREATED_BY RSC_CREATED_BY
,ZxFormulaDetails.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
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
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_RULES_VL ZxRulesVl
,ZX_FORMULA_VL ZxFormulaVl
,ZX_FORMULA_DETAILS ZxFormulaDetails
,ZX_TAXES_VL TAX
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
WHERE ZxRulesVl.SERVICE_TYPE_CODE               = 'DET_DIRECT_RATE_STCC'
AND ZxFormulaVl.FORMULA_ID = ZxFormulaDetails.FORMULA_ID
AND ZxRulesVl.TAX_RULE_CODE = ZxFormulaVl.FORMULA_CODE
AND ZxFormulaDetails.COMPOUNDING_TAX = TAX.TAX
AND TAX.Content_Owner_Id = Zfpomv.Party_Tax_Profile_Id(+)
ORDER BY ZxRulesVl.TAX_RULE_CODE