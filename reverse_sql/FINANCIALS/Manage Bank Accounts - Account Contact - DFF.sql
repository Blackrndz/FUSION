/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Account Contact - DFF.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10024##RES##HZ_PERSON_PROFILES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.


SELECT Distinct
Head.BANK_NAME                          RES_BANK,
Head.COUNTRY_NAME             RES_COUNTRY,
Head.BANK_BRANCH_NAME         RES_BANK_BRANCH,
 Head.BANK_ACCOUNT_NAME       RES_ACCOUNT_NAME,
 Head.BANK_ACCOUNT_NUM        RES_ACCOUNT_NUMBER,
 DETAIL.PERSON_NAME                    RES_CONTACT_NAME,
 Detail.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,Detail.ATTRIBUTE1 
,Detail.ATTRIBUTE2
,Detail.ATTRIBUTE3
,Detail.ATTRIBUTE4
,Detail.ATTRIBUTE5
,Detail.ATTRIBUTE6
,Detail.ATTRIBUTE7
,Detail.ATTRIBUTE8
,Detail.ATTRIBUTE9
,Detail.ATTRIBUTE10
,Detail.ATTRIBUTE11
,Detail.ATTRIBUTE12
,Detail.ATTRIBUTE13
,Detail.ATTRIBUTE14
,Detail.ATTRIBUTE15
,Detail.ATTRIBUTE16
,Detail.ATTRIBUTE17
,Detail.ATTRIBUTE18
,Detail.ATTRIBUTE19
,Detail.ATTRIBUTE20
,Detail.ATTRIBUTE21
,Detail.ATTRIBUTE22
,Detail.ATTRIBUTE23
,Detail.ATTRIBUTE24
,Detail.ATTRIBUTE25
,Detail.ATTRIBUTE26
,Detail.ATTRIBUTE27
,Detail.ATTRIBUTE28
,Detail.ATTRIBUTE29
,Detail.ATTRIBUTE30
,Detail.ATTRIBUTE_NUMBER1 
,Detail.ATTRIBUTE_NUMBER2
,Detail.ATTRIBUTE_NUMBER3
,Detail.ATTRIBUTE_NUMBER4
,Detail.ATTRIBUTE_NUMBER5
,Detail.ATTRIBUTE_NUMBER6
,Detail.ATTRIBUTE_NUMBER7
,Detail.ATTRIBUTE_NUMBER8
,Detail.ATTRIBUTE_NUMBER9
,Detail.ATTRIBUTE_NUMBER10
,Detail.ATTRIBUTE_NUMBER11
,Detail.ATTRIBUTE_NUMBER12
,to_char(Detail.ATTRIBUTE_DATE1,'DD-Mon-YYYY')  ATTRIBUTE_DATE1
,to_char(Detail.ATTRIBUTE_DATE2,'DD-Mon-YYYY')  ATTRIBUTE_DATE2
,to_char(Detail.ATTRIBUTE_DATE3,'DD-Mon-YYYY')  ATTRIBUTE_DATE3
,to_char(Detail.ATTRIBUTE_DATE4,'DD-Mon-YYYY')  ATTRIBUTE_DATE4
,to_char(Detail.ATTRIBUTE_DATE5,'DD-Mon-YYYY')  ATTRIBUTE_DATE5
,to_char(Detail.ATTRIBUTE_DATE6,'DD-Mon-YYYY')  ATTRIBUTE_DATE6
,to_char(Detail.ATTRIBUTE_DATE7,'DD-Mon-YYYY')  ATTRIBUTE_DATE7
,to_char(Detail.ATTRIBUTE_DATE8,'DD-Mon-YYYY')  ATTRIBUTE_DATE8
,to_char(Detail.ATTRIBUTE_DATE9,'DD-Mon-YYYY')  ATTRIBUTE_DATE9
,to_char(Detail.ATTRIBUTE_DATE10,'DD-Mon-YYYY')  ATTRIBUTE_DATE10
,to_char(Detail.ATTRIBUTE_DATE11,'DD-Mon-YYYY')  ATTRIBUTE_DATE11
,to_char(Detail.ATTRIBUTE_DATE12,'DD-Mon-YYYY')  ATTRIBUTE_DATE12
,Detail.LAST_UPDATED_BY  						RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE  						RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY  								RSC_CREATED_BY
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
	  
	  PersonDEO.ATTRIBUTE_CATEGORY 
,PersonDEO.ATTRIBUTE1 
,PersonDEO.ATTRIBUTE2
,PersonDEO.ATTRIBUTE3
,PersonDEO.ATTRIBUTE4
,PersonDEO.ATTRIBUTE5
,PersonDEO.ATTRIBUTE6
,PersonDEO.ATTRIBUTE7
,PersonDEO.ATTRIBUTE8
,PersonDEO.ATTRIBUTE9
,PersonDEO.ATTRIBUTE10
,PersonDEO.ATTRIBUTE11
,PersonDEO.ATTRIBUTE12
,PersonDEO.ATTRIBUTE13
,PersonDEO.ATTRIBUTE14
,PersonDEO.ATTRIBUTE15
,PersonDEO.ATTRIBUTE16
,PersonDEO.ATTRIBUTE17
,PersonDEO.ATTRIBUTE18
,PersonDEO.ATTRIBUTE19
,PersonDEO.ATTRIBUTE20
,PersonDEO.ATTRIBUTE21
,PersonDEO.ATTRIBUTE22
,PersonDEO.ATTRIBUTE23
,PersonDEO.ATTRIBUTE24
,PersonDEO.ATTRIBUTE25
,PersonDEO.ATTRIBUTE26
,PersonDEO.ATTRIBUTE27
,PersonDEO.ATTRIBUTE28
,PersonDEO.ATTRIBUTE29
,PersonDEO.ATTRIBUTE30
,PersonDEO.ATTRIBUTE_NUMBER1 
,PersonDEO.ATTRIBUTE_NUMBER2
,PersonDEO.ATTRIBUTE_NUMBER3
,PersonDEO.ATTRIBUTE_NUMBER4
,PersonDEO.ATTRIBUTE_NUMBER5
,PersonDEO.ATTRIBUTE_NUMBER6
,PersonDEO.ATTRIBUTE_NUMBER7
,PersonDEO.ATTRIBUTE_NUMBER8
,PersonDEO.ATTRIBUTE_NUMBER9
,PersonDEO.ATTRIBUTE_NUMBER10
,PersonDEO.ATTRIBUTE_NUMBER11
,PersonDEO.ATTRIBUTE_NUMBER12
,PersonDEO.ATTRIBUTE_DATE1 
,PersonDEO.ATTRIBUTE_DATE2
,PersonDEO.ATTRIBUTE_DATE3
,PersonDEO.ATTRIBUTE_DATE4
,PersonDEO.ATTRIBUTE_DATE5
,PersonDEO.ATTRIBUTE_DATE6
,PersonDEO.ATTRIBUTE_DATE7
,PersonDEO.ATTRIBUTE_DATE8
,PersonDEO.ATTRIBUTE_DATE9
,PersonDEO.ATTRIBUTE_DATE10
,PersonDEO.ATTRIBUTE_DATE11
,PersonDEO.ATTRIBUTE_DATE12
	  
	  
      ,PersonDEO.LAST_UPDATED_BY  						
      ,PersonDEO.LAST_UPDATE_DATE  						
      ,PersonDEO.CREATED_BY  								
      ,PersonDEO.CREATION_DATE 
    from HZ_PERSON_PROFILES PersonDEO,CE_CONTACT_ASSIGNMENTS  CeContactAssignments
    WHERE PersonDEO.primary_cust_RELATIONSHIP_ID   = CeContactAssignments.RELATIONSHIP_ID
	AND (PersonDEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
PersonDEO.ATTRIBUTE1 IS NOT NULL OR 
PersonDEO.ATTRIBUTE2 IS NOT NULL OR 
PersonDEO.ATTRIBUTE3 IS NOT NULL OR 
PersonDEO.ATTRIBUTE4 IS NOT NULL OR 
PersonDEO.ATTRIBUTE5 IS NOT NULL OR 
PersonDEO.ATTRIBUTE6 IS NOT NULL OR 
PersonDEO.ATTRIBUTE7 IS NOT NULL OR 
PersonDEO.ATTRIBUTE8 IS NOT NULL OR 
PersonDEO.ATTRIBUTE9 IS NOT NULL OR 
PersonDEO.ATTRIBUTE10 IS NOT NULL OR 
PersonDEO.ATTRIBUTE11 IS NOT NULL OR 
PersonDEO.ATTRIBUTE12 IS NOT NULL OR 
PersonDEO.ATTRIBUTE13 IS NOT NULL OR 
PersonDEO.ATTRIBUTE14 IS NOT NULL OR 
PersonDEO.ATTRIBUTE15 IS NOT NULL OR 
PersonDEO.ATTRIBUTE16 IS NOT NULL OR 
PersonDEO.ATTRIBUTE17 IS NOT NULL OR 
PersonDEO.ATTRIBUTE18 IS NOT NULL OR 
PersonDEO.ATTRIBUTE19 IS NOT NULL OR 
PersonDEO.ATTRIBUTE20 IS NOT NULL OR
PersonDEO.ATTRIBUTE21 IS NOT NULL OR 
PersonDEO.ATTRIBUTE22 IS NOT NULL OR 
PersonDEO.ATTRIBUTE23 IS NOT NULL OR 
PersonDEO.ATTRIBUTE24 IS NOT NULL OR 
PersonDEO.ATTRIBUTE25 IS NOT NULL OR 
PersonDEO.ATTRIBUTE26 IS NOT NULL OR 
PersonDEO.ATTRIBUTE27 IS NOT NULL OR 
PersonDEO.ATTRIBUTE28 IS NOT NULL OR 
PersonDEO.ATTRIBUTE29 IS NOT NULL OR 
PersonDEO.ATTRIBUTE30 IS NOT NULL OR
PersonDEO.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER11 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_NUMBER12 IS NOT NULL OR
PersonDEO.ATTRIBUTE_DATE1 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE2 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE3 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE4 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE5 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE6 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE7 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE8 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE9 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE10 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE11 IS NOT NULL OR 
PersonDEO.ATTRIBUTE_DATE12 IS NOT NULL )
  
  ) DETAIL
WHERE HEAD.BANK_ACCOUNT_ID  = DETAIL.BANK_ACCOUNT_ID


