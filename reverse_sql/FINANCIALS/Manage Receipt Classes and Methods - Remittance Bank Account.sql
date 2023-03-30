/* ****************************************************************************
 * $Revision: 79860 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-12-21 12:27:38 +0700 (Wed, 21 Dec 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account.sql 79860 2022-12-21 05:27:38Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ArReceiptClasses.NAME AS RES_NAME
,ARM.name AS RES_RECEIPT_METHODS_NAME
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = remitBankAllsE0.ORG_ID
	) AS RES_BUSINESS_UNIT
,CEBranchE0.BANK_NAME AS RES_BANK_NAME
,CEBranchE0.COUNTRY_NAME AS RES_BANK_COUNTRY
,CEBranchE0.BANK_BRANCH_NAME AS RES_BRANCH
,CEBankAccE0.BANK_ACCOUNT_NAME AS RES_ACCOUNT
,NVL((SELECT meaning
	FROM ar_lookups
	WHERE lookup_type = 'YES/NO'
	AND lookup_code   = remitBankAllsE0.PRIMARY_FLAG
	),'No') AS RES_PRIMARY
,NVL((SELECT meaning
	FROM ar_lookups
	WHERE lookup_type = 'YES/NO'
	AND lookup_code   = remitBankAllsE0.OVERRIDE_REMIT_ACCOUNT_FLAG
	),'No') AS RES_OVERRIDE_BANK
,CEBankAccE0.currency_code AS RES_CURRENCY
,remitBankAllsE0.MIN_RECEIPT_AMOUNT AS RES_MINIMUM_RECEIPT_AMOUNT
,remitBankAllsE0.CLEARING_DAYS AS RES_CLEARING_DAYS
,remitBankAllsE0.RISK_ELIMINATION_DAYS AS RES_RISK_ELIMINATION_DAYS
,TO_CHAR(remitBankAllsE0.START_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_START_DATE
,TO_CHAR(remitBankAllsE0.END_DATE,'DD-Mon-YYYY') AS RES_EFFECTIVE_END_DATE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.BR_REMITTANCE_CCID)
	,COMBINATION_ID => remitBankAllsE0.BR_REMITTANCE_CCID) AS RES_REMITTED_BILLS_RECEIVABLE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.BR_FACTOR_CCID)
	,COMBINATION_ID => remitBankAllsE0.BR_FACTOR_CCID) AS RES_FACTORED_BILLS_RECEIVABLE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.BR_COLLECTION_DAYS)
	,COMBINATION_ID => remitBankAllsE0.BR_COLLECTION_DAYS) AS RES_COLLECTION_DAYS
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.CASH_CCID)
	,COMBINATION_ID => remitBankAllsE0.CASH_CCID) AS RES_CASH
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.RECEIPT_CLEARING_CCID)
	,COMBINATION_ID => remitBankAllsE0.RECEIPT_CLEARING_CCID) AS RES_RECEIPT_CONFIRMATION
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.REMITTANCE_CCID)
	,COMBINATION_ID => remitBankAllsE0.REMITTANCE_CCID) AS RES_REMITTANCE
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.FACTOR_CCID)
	,COMBINATION_ID => remitBankAllsE0.FACTOR_CCID) AS RES_FACTORING
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.SHORT_TERM_DEBT_CCID)
	,COMBINATION_ID => remitBankAllsE0.SHORT_TERM_DEBT_CCID) AS	RES_SHORT_TERM_DEBT
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.UNAPPLIED_CCID)
	,COMBINATION_ID => remitBankAllsE0.UNAPPLIED_CCID) AS RES_UNAPPLIED_RECEIPTS
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.UNIDENTIFIED_CCID)
	,COMBINATION_ID => remitBankAllsE0.UNIDENTIFIED_CCID) AS RES_UNIDENTIFIED_RECEIPTS
,FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL'
	,KEY_FLEX_CODE => 'GL#'
	,STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID 
		FROM GL_CODE_COMBINATIONS 
		WHERE CODE_COMBINATION_ID = remitBankAllsE0.ON_ACCOUNT_CCID)
	,COMBINATION_ID => remitBankAllsE0.ON_ACCOUNT_CCID) AS RES_ON_ACCOUNT_RECEIPTS
,(SELECT name
	FROM AR_RECEIVABLES_TRX_ALL
	WHERE RECEIVABLES_TRX_ID = remitBankAllsE0.UNEDISC_RECEIVABLES_TRX_ID
	AND ORG_ID = remitBankAllsE0.ORG_ID
	) AS RES_UNEARNED_DISCOUNTS
,(SELECT name
	FROM AR_RECEIVABLES_TRX_ALL
	WHERE RECEIVABLES_TRX_ID = remitBankAllsE0.EDISC_RECEIVABLES_TRX_ID
	AND ORG_ID = remitBankAllsE0.ORG_ID
	) AS RES_EARNED_DISCOUNTS
,remitBankAllsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,remitBankAllsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,remitBankAllsE0.CREATED_BY  RSC_CREATED_BY
,remitBankAllsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,remitBankAllsE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_RECEIPT_METHOD_ACCOUNTS_ALL remitBankAllsE0
,AR_RECEIPT_METHODS ARM
,AR_RECEIPT_CLASSES ArReceiptClasses
,ce_bank_branches_v CEBranchE0
,ce_bank_accounts CEBankAccE0
,ce_bank_acct_uses_all CEBankacctuseE0
WHERE remitBankAllsE0.RECEIPT_METHOD_ID = ARM.RECEIPT_METHOD_ID
AND ARM.RECEIPT_CLASS_ID = ArReceiptClasses.RECEIPT_CLASS_ID
AND remitBankAllsE0.REMIT_BANK_ACCT_USE_ID = CEBankacctuseE0.BANK_ACCT_USE_ID
and CEBankacctuseE0.BANK_ACCOUNT_ID = CEBankAccE0.bank_account_id 
and CEBankAccE0.Bank_ID = CEBranchE0.Bank_Party_ID
and CEBankAccE0.Bank_Branch_ID = CEBranchE0.Branch_party_id
ORDER BY RES_NAME
,RES_RECEIPT_METHODS_NAME
,RES_BANK_NAME