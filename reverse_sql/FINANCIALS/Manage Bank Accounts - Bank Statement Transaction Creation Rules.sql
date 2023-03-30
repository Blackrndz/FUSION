/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Account Contact.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT 
Head.BANK_NAME  								RES_BANK,
Head.COUNTRY_NAME      							RES_COUNTRY,
Head.BANK_BRANCH_NAME        					RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME            				RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM             				RES_ACCOUNT_NUMBER,
Detail.SEQUENCE_NUMBER                   		RES_SEQUENCE,
Detail.rule_name       							RES_RULE,
Detail.DESCRIPTION1                            	RES_DESCRIPTION
,Detail.LAST_UPDATED_BY  						RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  						RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  							RSC_CREATED_BY
,Detail.CREATION_DATE  							RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,Head.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM
(

Select
CeBankAccounts.BANK_ACCOUNT_ID,
BankBranchSimplePEO.BANK_NAME               		,
BankBranchSimplePEO.COUNTRY_NAME            		,
BankBranchSimplePEO.BANK_BRANCH_NAME        		,
 CeBankAccounts.BANK_ACCOUNT_NAME             		,
CeBankAccounts.BANK_ACCOUNT_NUM                   ,
  CeBankAccounts.ACCOUNT_OWNER_ORG_ID


FROM CE_BANK_ACCOUNTS CeBankAccounts,
  XLE_ENTITY_PROFILES XleEntityProfiles,
  CE_BANK_BRANCHES_SIMPLE_V BankBranchSimplePEO,
  CE_RECON_RULESETS BankStatementReconRuleSetPEO
WHERE ((CeBankAccounts.ACCOUNT_OWNER_ORG_ID = XleEntityProfiles.LEGAL_ENTITY_ID)
AND (CeBankAccounts.BANK_BRANCH_ID          = BankBranchSimplePEO.BRANCH_PARTY_ID)
AND (CeBankAccounts.RECON_RULESET_ID        = BankStatementReconRuleSetPEO.RECON_RULESET_ID (+))
AND NOT EXISTS
  (SELECT xtr.bank_account_id
  FROM ce_bank_accounts xtr
  WHERE NVL(AP_USE_ALLOWED_FLAG, 'N') = 'N'
  AND NVL(AR_USE_ALLOWED_FLAG, 'N')   = 'N'
  AND NVL(PAY_USE_ALLOWED_FLAG, 'N')  = 'N'
  AND NVL(XTR_USE_ALLOWED_FLAG, 'N')  = 'Y'
  AND xtr.bank_account_id             = CeBankAccounts.bank_account_id
  ))

) Head
,(
SELECT
  CeAcctTrxCreatRules.ACCT_TRX_CREATION_RULE_ID,
  CeAcctTrxCreatRules.BANK_ACCOUNT_ID,
  CeAcctTrxCreatRules.JE_MAPPING_ID,
  CeAcctTrxCreatRules.SEQUENCE_NUMBER,
  CeAcctTrxCreatRules.LAST_UPDATE_DATE,
  CeAcctTrxCreatRules.LAST_UPDATED_BY,
  CeAcctTrxCreatRules.CREATION_DATE,
  CeAcctTrxCreatRules.CREATED_BY,
  CeAcctTrxCreatRules.LAST_UPDATE_LOGIN,
  CeAcctTrxCreatRules.OBJECT_VERSION_NUMBER,
  (SELECT rule_name
  FROM ce_je_mappings
  WHERE je_mapping_id =CeAcctTrxCreatRules.JE_MAPPING_ID
  )     AS rule_name,
  (SELECT description
  FROM ce_je_mappings
  WHERE je_mapping_id =CeAcctTrxCreatRules.JE_MAPPING_ID
  )     AS DESCRIPTION1,
  ('N') AS SEQ_NUM_UPDATED_FLAG_T
  ,CeAcctTrxCreatRules.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,CeAcctTrxCreatRules.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,CeAcctTrxCreatRules.CREATED_BY  RSC_CREATED_BY
,CeAcctTrxCreatRules.CREATION_DATE  RSC_CREATION_DATE

FROM CE_ACCT_TRX_CREAT_RULES CeAcctTrxCreatRules
)Detail
WHERE Head.BANK_ACCOUNT_ID = Detail.BANK_ACCOUNT_ID
ORDER BY Head.BANK_ACCOUNT_ID,Detail.SEQUENCE_NUMBER