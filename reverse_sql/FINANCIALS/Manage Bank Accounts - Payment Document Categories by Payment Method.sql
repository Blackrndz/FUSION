/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Payment Document Categories by Payment Method.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT 
Head.BANK_NAME  								RES_BANK,
Head.COUNTRY_NAME      							RES_COUNTRY,
Head.BANK_BRANCH_NAME        					RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME            				RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM             				RES_ACCOUNT_NUMBER,
Detail.BU_NAME                       RES_BUSINESS_UNIT,
(select  IbyPaymentMethodsVl.PAYMENT_METHOD_NAME FROM IBY_PAYMENT_METHODS_VL IbyPaymentMethodsVl 
 where IbyPaymentMethodsVl.PAYMENT_METHOD_CODE   =Detail.PAYMENT_METHOD_CODE)                       RES_PAYMENT_METHOD,
( select name from fnd_doc_sequence_categories  aa 
 where aa.code = Detail.PAYMENT_DOC_CATEGORY )                     RES_PAYMENT_DOCUMENT_CATEGORY,
Detail.LAST_UPDATED_BY  						RSC_LAST_UPDATED_BY,
Detail.LAST_UPDATE_DATE  						RSC_LAST_UPDATE_DATE,
Detail.CREATED_BY  								RSC_CREATED_BY,
Detail.CREATION_DATE  							RSC_CREATION_DATE
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
,
(
   SELECT 
      CeBankAcctUsesAll.BANK_ACCOUNT_ID,  
      BusinessUnitPEO.BU_NAME   ,
      CeApPmDocCategories.AP_PM_DOC_CATEGORY_ID,
      CeApPmDocCategories.BANK_ACCT_USE_ID,
      CeApPmDocCategories.PAYMENT_METHOD_CODE,
      CeApPmDocCategories.PAYMENT_DOC_CATEGORY,
      CeApPmDocCategories.LAST_UPDATE_DATE,
      CeApPmDocCategories.LAST_UPDATED_BY,
      CeApPmDocCategories.CREATION_DATE,
      CeApPmDocCategories.CREATED_BY
    FROM CE_AP_PM_DOC_CATEGORIES CeApPmDocCategories , CE_BANK_ACCT_USES_ALL  CeBankAcctUsesAll
         ,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
    WHERE CeApPmDocCategories. BANK_ACCT_USE_ID  = CeBankAcctUsesAll.BANK_ACCT_USE_ID(+) 
    AND   CeBankAcctUsesAll.ORG_ID             	= BusinessUnitPEO.BU_ID(+)
) DETAIL
WHERE Head.BANK_ACCOUNT_ID   = detail.BANK_ACCOUNT_ID
ORDER BY RES_BANK,RES_ACCOUNT_NAME,Detail.BU_NAME 