/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Options%20-%20Manage%20Payment%20Options.sql $:
 * $Id: Manage Payment Options - Manage Payment Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT
	(SELECT bu_name
	FROM Fusion.fun_bu_usages_v
	WHERE module_key     = 'PAYABLES_PAYMENT_BF'
	AND BUSINESS_UNIT_ID = ApSystemParametersAll.ORG_ID
	) RES_BUSINESS_UNIT
,DECODE(ApSystemParametersAll.POST_DATED_PAYMENTS_FLAG,'Y','Yes','No') RES_PAYMENT_ACCOUNTING_AND_OVE
,DECODE(ApSystemParametersAll.ALLOW_SUPPLIER_BANK_OVERRIDE,'Y','Yes','No') RES_PAYMENT_ACCOUNTING_AND_O_0
,DECODE(ApSystemParametersAll.PAY_DOC_CATEGORY_OVERRIDE,'Y','Yes','No') RES_PAYMENT_ACCOUNTING_AND_O_1
,DECODE(ApSystemParametersAll.ALLOW_PYMT_THIRD_PARTY_OVRD,'Y','Yes','No') RES_PAYMENT_ACCOUNTING_AND_O_2
,(SELECT PayablesLookupPEO.DISPLAYED_FIELD
	FROM Fusion.AP_LOOKUP_CODES PayablesLookupPEO
	WHERE PayablesLookupPEO.LOOKUP_TYPE = 'ACCT_PAYMENT_OPTIONS'
	AND lookup_code                     = ApSystemParametersAll.WHEN_TO_ACCOUNT_PMT
	) RES_PAYMENT_ACCOUNTING_AND_O_3
,(SELECT DECODE(MAKE_RATE_MANDATORY_PMT_FLAG,'Y','Yes','No')
	FROM Fusion.FINANCIALS_SYSTEM_PARAMS_ALL
	WHERE org_id = ApSystemParametersAll.ORG_ID
	) RES_CURRENCY_CONVERSION_REQUIR
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = (SELECT DEFAULT_PMT_EXCHANGE_RATE_TYPE
		FROM Fusion.FINANCIALS_SYSTEM_PARAMS_ALL
		WHERE org_id = ApSystemParametersAll.ORG_ID)
	) RES_CURRENCY_CONVERSION_CONVER
,(SELECT PayablesLookupPEO.DISPLAYED_FIELD
	FROM Fusion.AP_LOOKUP_CODES PayablesLookupPEO
	WHERE PayablesLookupPEO.LOOKUP_TYPE = 'AP_BANK_CHARGE_DEDUCTION_TYPE'
	AND PayablesLookupPEO.LOOKUP_CODE   = NVL(ApSystemParametersAll.BANK_CHARGE_DEDUCTION_TYPE,'X')
	) RES_BANK_CHARGES_BANK_CHARGE_D
,ApSystemParametersAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ApSystemParametersAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ApSystemParametersAll.CREATED_BY  RSC_CREATED_BY
,ApSystemParametersAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,ApSystemParametersAll.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Fusion.AP_SYSTEM_PARAMETERS_ALL ApSystemParametersAll