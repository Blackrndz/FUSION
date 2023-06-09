/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Account Contact.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=CE_BANK_ACCOUNTS

SELECT BankBranchSimplePEO.BANK_NAME RES_BANK
,BankBranchSimplePEO.COUNTRY_NAME RES_COUNTRY
,BankBranchSimplePEO.BANK_BRANCH_NAME RES_BANK_BRANCH
,CeBankAccounts.BANK_ACCOUNT_NAME RES_ACCOUNT_NAME
,CeBankAccounts.BANK_ACCOUNT_NUM RES_ACCOUNT_NUMBER
,(SELECT BankStmtReconToleranceRulePE.TOLERANCE_RULE_NAME
	FROM CE_RECON_TOLERANCE_RULES BankStmtReconToleranceRulePE
	WHERE BankStmtReconToleranceRulePE.RECON_TOLERANCE_RULE_ID = CeBankAccounts.MANUAL_TOLERANCE_RULE_ID
	) RES_MANUAL_RECONCILIATION_TOLE
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = CeBankAccounts.BANK_EXCHANGE_RATE_TYPE
	) RES_BANK_EXCHANGE_RATE_TYPE
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = CeBankAccounts.GL_CUR_EXC_RATE_TYPE 
	) RES_ACCOUNTING_CONVERSION_RATE
,(SELECT meaning
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ORA_CE_AUTOREC_REVERSAL'
	AND lookup_code   = CeBankAccounts.reversal_process_code
	) RES_REVERSAL_PROCESSING_METHOD
,(SELECT BankStatementReconRuleSetPEO.RULESET_NAME
	FROM CE_RECON_RULESETS BankStatementReconRuleSetPEO
	WHERE BankStatementReconRuleSetPEO.RECON_RULESET_ID = CeBankAccounts.RECON_RULESET_ID
	) RES_AUTOMATIC_RECONCILIATION_R
,TO_CHAR(CeBankAccounts.RECON_START_DATE,'DD-Mon-YYYY') RES_RECONCILIATION_START_DATE
,(SELECT BankStatementParsingRuleSets.PARSING_RULE_SET_NAME
	FROM CE_PARSING_RULE_SETS BankStatementParsingRuleSets
	WHERE BankStatementParsingRuleSets.PARSING_RULE_SET_ID = CeBankAccounts.PARSING_RULE_SET_ID
	) RES_PARSING_RULE_SET
,CeBankAccounts.TARGET_BALANCE RES_TARGET_BALANCE
,(SELECT NAME
	FROM GL_TRANSACTION_CALENDAR
	WHERE TRANSACTION_CALENDAR_ID = CeBankAccounts.TRANSACTION_CALENDAR_ID 
	) RES_TRANSACTION_CALENDAR
,DECODE(CeBankAccounts.POOLED_FLAG,'Y','Yes','No') RES_POOLED_ACCOUNT
,CeBankAccounts.MIN_CHECK_AMOUNT RES_MINIMUM_PAYMENT
,CeBankAccounts.MAX_CHECK_AMOUNT RES_MAXIMUM_PAYMENT
,DECODE(CeBankAccounts.ZERO_AMOUNT_ALLOWED,'Y','Yes','No') RES_ALLOW_ZERO_PAYMENTS
,CeBankAccounts.MAX_OUTLAY RES_MAXIMUM_OUTLAY
,CeBankAccounts.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CeBankAccounts.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CeBankAccounts.CREATED_BY RSC_CREATED_BY
,CeBankAccounts.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,CeBankAccounts.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANK_ACCOUNTS CeBankAccounts
,XLE_ENTITY_PROFILES XleEntityProfiles
,CE_BANK_BRANCHES_SIMPLE_V BankBranchSimplePEO
,CE_RECON_RULESETS BankStatementReconRuleSetPEO
WHERE((CeBankAccounts.ACCOUNT_OWNER_ORG_ID = XleEntityProfiles.LEGAL_ENTITY_ID)
AND(CeBankAccounts.BANK_BRANCH_ID          = BankBranchSimplePEO.BRANCH_PARTY_ID)
AND(CeBankAccounts.RECON_RULESET_ID        = BankStatementReconRuleSetPEO.RECON_RULESET_ID (+))
AND NOT EXISTS
	(SELECT xtr.bank_account_id
	FROM ce_bank_accounts xtr
	WHERE NVL(AP_USE_ALLOWED_FLAG,'N') = 'N'
	AND NVL(AR_USE_ALLOWED_FLAG,'N')   = 'N'
	AND NVL(PAY_USE_ALLOWED_FLAG,'N')  = 'N'
	AND NVL(XTR_USE_ALLOWED_FLAG,'N')  = 'Y'
	AND xtr.bank_account_id            = CeBankAccounts.bank_account_id
	))
ORDER BY DECODE(cebankaccounts.end_date,NULL,'Y','N') DESC
,CeBankAccounts.BANK_ACCOUNT_NAME