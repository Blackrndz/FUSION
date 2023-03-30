/* ****************************************************************************
 * $Revision: 61060 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-17 09:40:24 +0700 (Fri, 17 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Application%20Tax%20Options%20-%20Application%20Tax%20Options.sql $:
 * $Id: Manage Application Tax Options - Application Tax Options.sql 61060 2017-02-17 02:40:24Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT DECODE(ZxRulesVl.SERVICE_TYPE_CODE,'DET_APPLICABLE_TAXES','Tax Applicability Rules','DET_PLACE_OF_SUPPLY',
	'Place of Supply Rules','DET_DIRECT_RATE','Direct Tax Rate Rules','DET_RECOVERY_RATE','Recovery Rate Rules',
	'DET_TAXABLE_BASIS','Taxable Basis Rules','CALCULATE_TAX_AMOUNTS','Tax Calculation Rules','DET_TAX_RATE',
	'Tax Rate Rules','DET_TAX_REGISTRATION','Tax Registration Rules','DET_TAX_STATUS','Tax Status Rules',
	'DET_DIRECT_RATE_ENF_ACCT','Account-Based Direct Tax Rate Rules','DET_DIRECT_RATE_STCC',
	'Tax Classification-Based Direct Tax Rate Rules') RES_TAX_RULE_TYPE
,ZxRulesVl.TAX_RULE_CODE RES_RULE_CODE
,ZxRulesVl.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxRulesVl.TAX RES_TAX
,ZxRulesVl.DET_FACTOR_TEMPL_CODE RES_TAX_DETERMINING_FACTOR_SET
,ZxProcessResults.CONDITION_GROUP_CODE RES_TAX_CONDITION_SET_CODE
,ZxReportingTypesVl.REPORTING_TYPE_CODE RES_TAX_REPORTING_TYPE_CODE
,ZxReportingTypesVl.REPORTING_TYPE_NAME RES_TAX_REPORTING_TYPE_NAME
,(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_REPORTING_DATA'
	AND LOOKUP_CODE = ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE
	) RES_DATA_TYPE
,ZxReportingCodesVl.REPORTING_CODE_CHAR_VALUE RES_TAX_REPORTING_CODE
,DECODE(ZxReportingTypesVl.LEGAL_MESSAGE_FLAG,'Y',null,ZxReportingCodesVl.Reporting_Code_Name) RES_DESCRIPTION
,TO_CHAR(TaxReportingCodeAssociationE1.EFFECTIVE_FROM, 'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(TaxReportingCodeAssociationE1.EFFECTIVE_TO, 'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,TaxReportingCodeAssociationE1.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TaxReportingCodeAssociationE1.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TaxReportingCodeAssociationE1.CREATED_BY RSC_CREATED_BY
,TaxReportingCodeAssociationE1.CREATION_DATE RSC_CREATION_DATE
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
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_RULES_VL ZxRulesVl
,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
,ZX_REGIMES_VL ZxRegimesVl
,ZX_PROCESS_RESULTS ZxProcessResults
,ZX_REPORT_CODES_ASSOC TaxReportingCodeAssociationE1
,ZX_REPORTING_TYPES_VL ZxReportingTypesVl
,ZX_REPORTING_CODES_VL ZxReportingCodesVl
WHERE ZxRegimesVl.TAX_REGIME_CODE         = ZxRulesVl.TAX_REGIME_CODE
AND ZxRulesVl.CONTENT_OWNER_ID            = ZFPOMV.PARTY_TAX_PROFILE_ID
AND NVL(ZxRegimesVl.REGIME_TYPE_FLAG,'I') = 'I'
AND ZxRulesVl.SERVICE_TYPE_CODE NOT      IN('DET_DIRECT_RATE_ENF_ACCT','DET_DIRECT_RATE_STCC','DET_TAX_BOX')
AND ZxRulesVl.TAX_RULE_ID                 = ZxProcessResults.TAX_RULE_ID
AND ZxProcessResults.RESULT_ID = TaxReportingCodeAssociationE1.ENTITY_ID
AND TaxReportingCodeAssociationE1.REPORTING_TYPE_ID = ZxReportingTypesVl.REPORTING_TYPE_ID
AND TaxReportingCodeAssociationE1.REPORTING_CODE_ID = ZxReportingCodesVl.REPORTING_CODE_ID
AND ZxReportingTypesVl.LEGAL_MESSAGE_FLAG = 'N'
ORDER BY ZxRulesVl.SERVICE_TYPE_CODE,2,3