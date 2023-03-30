/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Account Contact.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT Distinct
Head.BANK_NAME                          						RES_BANK,
Head.COUNTRY_NAME             									RES_COUNTRY,
Head.BANK_BRANCH_NAME         									RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME       									RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM        									RES_ACCOUNT_NUMBER,
DETAIL.PERSON_NAME                    							RES_CONTACT_NAME,
( select aa.meaning from FND_LOOKUP_VALUES_VL aa
  where aa.lookup_type = 'CONTACT_TITLE'
  and  aa.lookup_code = Detail.person_pre_name_adjunct )      	RES_PREFIX,
DETAIL.person_first_name             							RES_FIRST_NAME,
DETAIL.person_middle_name         								RES_MIDDLE_NAME,
DETAIL.person_last_name               							RES_LAST_NAME,
DETAIL.COMMENTS                      							RES_COMMENTS ,
Detail.LAST_UPDATED_BY  										RSC_LAST_UPDATED_BY,
Detail.LAST_UPDATE_DATE  										RSC_LAST_UPDATE_DATE,
Detail.CREATED_BY  												RSC_CREATED_BY,
Detail.CREATION_DATE  											RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,Head.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
 
 
FROM

( SELECT
  CeBankAccounts.BANK_ACCOUNT_ID,
  CeBankAccounts.BANK_BRANCH_ID,
  CeBankAccounts.BANK_ID,
  CeBankAccounts.BANK_ACCOUNT_NAME,
  CeBankAccounts.BANK_ACCOUNT_NUM,
  CeBankAccounts.CURRENCY_CODE,
  CeBankAccounts.ACCOUNT_OWNER_PARTY_ID,
  CeBankAccounts.ACCOUNT_OWNER_ORG_ID,
  CeBankAccounts.BANK_ACCOUNT_TYPE,
  CeBankAccounts.DESCRIPTION,
  CeBankAccounts.IBAN_NUMBER,
  CeBankAccounts.CHECK_DIGITS,
  CeBankAccounts.SECONDARY_ACCOUNT_REFERENCE,
  CeBankAccounts.ACCOUNT_SUFFIX,
  CeBankAccounts.AP_USE_ALLOWED_FLAG,
  CeBankAccounts.PAY_USE_ALLOWED_FLAG,
  CeBankAccounts.AR_USE_ALLOWED_FLAG,
  CeBankAccounts.XTR_USE_ALLOWED_FLAG,
  CeBankAccounts.BANK_ACCOUNT_NAME_ALT,
  CeBankAccounts.ACCOUNT_HOLDER_NAME,
  CeBankAccounts.ACCOUNT_HOLDER_NAME_ALT,
  CeBankAccounts.EFT_USER_NUM,
  CeBankAccounts.START_DATE,
  CeBankAccounts.END_DATE,
  CeBankAccounts.MULTI_CURRENCY_ALLOWED_FLAG,
  CeBankAccounts.ASSET_CODE_COMBINATION_ID,
  CeBankAccounts.BANK_CHARGES_CCID,
  CeBankAccounts.AGENCY_LOCATION_CODE,
  CeBankAccounts.CASH_CLEARING_CCID,
  CeBankAccounts.NETTING_ACCT_FLAG,
  CeBankAccounts.MANUAL_TOLERANCE_RULE_ID,
  CeBankAccounts.RECON_DIFFERENCE_CCID,
  CeBankAccounts.BANK_EXCHANGE_RATE_TYPE,
  CeBankAccounts.GL_CUR_EXC_RATE_TYPE,
  CeBankAccounts.RECON_RULESET_ID,
  CeBankAccounts.RECON_START_DATE,
  CeBankAccounts.PARSING_RULE_SET_ID,
  CeBankAccounts.DATA_SECURITY_FLAG,
  CeBankAccounts.POOLED_FLAG,
  CeBankAccounts.MIN_CHECK_AMOUNT,
  CeBankAccounts.MAX_CHECK_AMOUNT,
  CeBankAccounts.ZERO_AMOUNT_ALLOWED,
  CeBankAccounts.MAX_OUTLAY,
  BankBranchSimplePEO.BANK_NAME,
  BankBranchSimplePEO.BANK_BRANCH_NAME,
  CeBankAccounts.MASKED_ACCOUNT_NUM,
  CeBankAccounts.MASKED_IBAN,
  CeBankAccounts.LAST_UPDATE_DATE,
  CeBankAccounts.LAST_UPDATED_BY,
  CeBankAccounts.LAST_UPDATE_LOGIN,
  CeBankAccounts.CREATION_DATE,
  CeBankAccounts.CREATED_BY,
  CeBankAccounts.REQUEST_ID,
  CeBankAccounts.PROGRAM_APPLICATION_ID,
  CeBankAccounts.PROGRAM_ID,
  CeBankAccounts.PROGRAM_UPDATE_DATE,
  CeBankAccounts.EFT_REQUESTER_IDENTIFIER,
  CeBankAccounts.SHORT_ACCOUNT_NAME,
  CeBankAccounts.ACCOUNT_CLASSIFICATION,
  CeBankAccounts.OBJECT_VERSION_NUMBER,
  CeBankAccounts.FX_CHARGE_CCID,
  CeBankAccounts.BANK_ACCOUNT_NUM_ELECTRONIC,
  CeBankAccounts.RECON_FOREIGN_BANK_XRATE_TYPE,
  CeBankAccounts.RECON_FOR_BANK_XRATE_DATE_TYPE,
  XleEntityProfiles.NAME,
  XleEntityProfiles.LEGAL_ENTITY_ID,
  XleEntityProfiles.OBJECT_VERSION_NUMBER AS OBJECT_VERSION_NUMBER1,
  XleEntityProfiles.PARTY_ID,
  CeBankAccounts.BANK_ACCOUNT_NAME     AS BANK_ACCOUNT_NAME1,
  CeBankAccounts.BANK_ACCOUNT_NUM      AS BANK_ACCOUNT_NUM1,
  CeBankAccounts.MASKED_ACCOUNT_NUM    AS MASKED_ACCOUNT_NUM1,
  CeBankAccounts.CURRENCY_CODE         AS CURRENCY_CODE1,
  XleEntityProfiles.NAME               AS NAME1,
  BankBranchSimplePEO.BANK_NAME        AS BANK_NAME1,
  BankBranchSimplePEO.BANK_BRANCH_NAME AS BANK_BRANCH_NAME1,
  CeBankAccounts.BANK_ACCOUNT_NAME_ALT AS BANK_ACCOUNT_NAME_ALT1,
  BankBranchSimplePEO.BANK_HOME_COUNTRY,
  BankBranchSimplePEO.COUNTRY_NAME,
  BankBranchSimplePEO.BANK_PARTY_ID,
  BankBranchSimplePEO.BRANCH_PARTY_ID,
  (SELECT le.CHART_OF_ACCOUNTS_ID
  FROM GL_LEDGER_LE_V le
  WHERE le.legal_entity_id = CeBankAccounts.ACCOUNT_OWNER_ORG_ID
  AND le.ledger_id         = le.primary_ledger_id
  AND rownum               =1
  ) AS STRUCTURE_ID,
  BankBranchSimplePEO.ROW_ID,
  BankBranchSimplePEO.PK_ID,
  BankBranchSimplePEO.BANK_NUMBER,
  BankBranchSimplePEO.BRANCH_NUMBER,
  BankBranchSimplePEO.BANK_BRANCH_NAME            AS BANK_BRANCH_NAME2,
  XleEntityProfiles.NAME                          AS NAME2,
  DECODE(cebankaccounts.end_date, NULL, 'Y', 'N') AS ACTIVE_FLAG_T,
  BankStatementReconRuleSetPEO.RULESET_NAME,
  BankStatementReconRuleSetPEO.RECON_RULESET_ID                                     AS RECON_RULESET_ID1,
  CE_BANK_AND_ACCOUNT_UTIL.GET_MASKED_BANK_ACCT_NUM(CeBankAccounts.BANK_ACCOUNT_ID) AS MASKED_ACCOUNT_NUM_T,
  CE_BANK_AND_ACCOUNT_UTIL.GET_MASKED_IBAN(CeBankAccounts.BANK_ACCOUNT_ID)          AS MASKED_IBAN_T
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

ORDER BY DECODE(cebankaccounts.end_date, NULL, 'Y', 'N') DESC,
  CeBankAccounts.BANK_ACCOUNT_NAME
  ) HEAD
  ,(
  
  select 
      PersonDEO.primary_customer_id,
      PersonDEO.PERSON_NAME,
      PersonDEO.person_pre_name_adjunct     ,
      PersonDEO.person_first_name           ,
      PersonDEO.person_middle_name         ,
      PersonDEO.person_last_name           ,
      PersonDEO.COMMENTS                     ,
      PersonDEO.primary_cust_RELATIONSHIP_ID ,
      CeContactAssignments.BANK_ACCOUNT_ID,
      PersonDEO.LAST_UPDATED_BY  						,
      PersonDEO.LAST_UPDATE_DATE  						,
      PersonDEO.CREATED_BY  								,
      PersonDEO.CREATION_DATE 
    from HZ_PERSON_PROFILES PersonDEO,CE_CONTACT_ASSIGNMENTS  CeContactAssignments
    WHERE PersonDEO.primary_cust_RELATIONSHIP_ID   = CeContactAssignments.RELATIONSHIP_ID
  
  ) DETAIL
WHERE HEAD.BANK_ACCOUNT_ID  = DETAIL.BANK_ACCOUNT_ID


