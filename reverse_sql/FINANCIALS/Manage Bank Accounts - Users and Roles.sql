/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Users and Roles.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT 
Head.BANK_NAME  												RES_BANK,
Head.COUNTRY_NAME      											RES_COUNTRY,
Head.BANK_BRANCH_NAME        									RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME            								RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM             								RES_ACCOUNT_NUMBER,
decode(Head.DATA_SECURITY_FLAG,'Y','Yes','No')             	RES_SECURE_BANK_ACCOUNT_BY_USE,
(SELECT meaning
 FROM FND_LOOKUP_VALUES_VL
 WHERE LOOKUP_TYPE = 'ACCOUNT_SECURE_BY_TYPE'
 and LOOKUP_CODE = Detail.GRANTEE_TYPE ) 						RES_SECURE_BY,
Detail.USER_ROLE_NAME                    						RES_NAME,
to_char(Detail.END_DATE,'DD-Mon-YYYY')                    		RES_END_DATE,
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
(
    Select 
      CeBankAccounts.BANK_ACCOUNT_ID,
      BankBranchSimplePEO.BANK_NAME               		,
      BankBranchSimplePEO.COUNTRY_NAME            		,
      BankBranchSimplePEO.BANK_BRANCH_NAME        		,
      CeBankAccounts.BANK_ACCOUNT_NAME             		,
      CeBankAccounts.BANK_ACCOUNT_NUM                  ,
      CeBankAccounts.DATA_SECURITY_FLAG					,
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
,
(   SELECT GRANT_ID,
  BANK_ACCOUNT_ID,
  GRANTEE_TYPE,
  GRANTEE_KEY,
  START_DATE,
  END_DATE,
  LAST_UPDATE_DATE,
  LAST_UPDATED_BY,
  CREATION_DATE,
  CREATED_BY,
  LAST_UPDATE_LOGIN,
  OBJECT_VERSION_NUMBER,
  USER_ROLE_NAME
FROM CE_BANK_ACCOUNT_GRANTS BankAccountGrantEO

) Detail
WHERE Head.BANK_ACCOUNT_ID =   Detail.BANK_ACCOUNT_ID
ORDER BY RES_BANK,RES_ACCOUNT_NAME