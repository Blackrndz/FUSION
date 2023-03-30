/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Account Contact.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- FIELD_TO_APPLY_FUNCTION=RES_CASH/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_CASH_CLEARING/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_BANK_CHARGES/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_FOREIGN_EXCHANGE_GAIN/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_FOREIGN_EXCHANGE_LOSS/GET_CODE_COMBINATION
 
Select 
BankBranchSimplePEO.BANK_NAME               		RES_BANK,
BankBranchSimplePEO.COUNTRY_NAME            		RES_COUNTRY,
BankBranchSimplePEO.BANK_BRANCH_NAME        		RES_BANK_BRANCH,
 CeBankAccounts.BANK_ACCOUNT_NAME             		RES_ACCOUNT_NAME,
CeBankAccounts.BANK_ACCOUNT_NUM                   					RES_ACCOUNT_NUMBER,
BusinessUnitPEO.BU_NAME      										RES_BUSINESS_UNIT,
to_char(CeBankAcctUsesAll.END_DATE,'DD-Mon-YYYY')        			RES_END_DATE,

CeGlAccountsCcid.ASSET_CODE_COMBINATION_ID                          RES_CASH,
CeGlAccountsCcid.CASH_CLEARING_CCID                     			RES_CASH_CLEARING,
CeGlAccountsCcid.BANK_CHARGES_CCID                        			RES_BANK_CHARGES,
CeGlAccountsCcid.GAIN_CODE_COMBINATION_ID     						RES_FOREIGN_EXCHANGE_GAIN,
CeGlAccountsCcid.LOSS_CODE_COMBINATION_ID               			RES_FOREIGN_EXCHANGE_LOSS
,CeBankAcctUsesAll.LAST_UPDATED_BY  								RSC_LAST_UPDATED_BY
,CeBankAcctUsesAll.LAST_UPDATE_DATE  								RSC_LAST_UPDATE_DATE
,CeBankAcctUsesAll.CREATED_BY  										RSC_CREATED_BY
,CeBankAcctUsesAll.CREATION_DATE  									RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,CeBankAcctUsesAll.ORG_ID RSC_BUSINESS_UNIT_ID
,CeBankAccounts.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID



FROM CE_BANK_ACCOUNTS CeBankAccounts,
  XLE_ENTITY_PROFILES XleEntityProfiles,
  CE_BANK_BRANCHES_SIMPLE_V BankBranchSimplePEO,
  CE_RECON_RULESETS BankStatementReconRuleSetPEO,
  CE_BANK_ACCT_USES_ALL CeBankAcctUsesAll,
  FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO,
  CE_GL_ACCOUNTS_CCID      CeGlAccountsCcid

WHERE ((CeBankAccounts.ACCOUNT_OWNER_ORG_ID = XleEntityProfiles.LEGAL_ENTITY_ID)
AND (CeBankAccounts.BANK_BRANCH_ID          = BankBranchSimplePEO.BRANCH_PARTY_ID)
AND (CeBankAccounts.RECON_RULESET_ID        = BankStatementReconRuleSetPEO.RECON_RULESET_ID (+))
AND  CeBankAccounts.BANK_ACCOUNT_ID 		=             CeBankAcctUsesAll.BANK_ACCOUNT_ID(+)
AND CeBankAcctUsesAll.ORG_ID             	= BusinessUnitPEO.BU_ID(+)
--AND   CeBankAccounts.ASSET_CODE_COMBINATION_ID =  CeGlAccountsCcid.ASSET_CODE_COMBINATION_ID
AND CeBankAcctUsesAll.BANK_ACCT_USE_ID	   =   CeGlAccountsCcid.BANK_ACCT_USE_ID(+)
AND NOT EXISTS
  (SELECT xtr.bank_account_id
  FROM ce_bank_accounts xtr
  WHERE NVL(AP_USE_ALLOWED_FLAG, 'N') = 'N'
  AND NVL(AR_USE_ALLOWED_FLAG, 'N')   = 'N'
  AND NVL(PAY_USE_ALLOWED_FLAG, 'N')  = 'N'
  AND NVL(XTR_USE_ALLOWED_FLAG, 'N')  = 'Y'
  AND xtr.bank_account_id             = CeBankAccounts.bank_account_id
  ))

ORDER BY DECODE(cebankaccounts.end_date, NULL, 'Y', 'N') DESC,
  CeBankAccounts.BANK_ACCOUNT_NAME
