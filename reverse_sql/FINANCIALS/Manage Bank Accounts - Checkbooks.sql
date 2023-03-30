/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Checkbooks.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT 
Head.BANK_NAME  								RES_BANK,
Head.COUNTRY_NAME      							RES_COUNTRY,
Head.BANK_BRANCH_NAME        					RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME            				RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM             				RES_ACCOUNT_NUMBER,
Detail.PAYMENT_DOCUMENT_name                    RES_PAYMENT_DOCUMENT,
Detail.checkbook_name              				RES_CHECKBOOKS,
Detail.PREFIX                                   RES_PREFIX,
Detail.START_NUMBER                          	RES_START_NUMBER,
Detail.END_NUMBER                               RES_END_NUMBER,
to_char(Detail.date_received,'DD-Mon-YYYY')     RES_RECEIVED_DATE,
null                 				RES_NUMBER_OF_DOCUMENTS,
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
    SELECT CeCheckbooks.PAYMENT_DOCUMENT_ID,
      CeCheckbooks.CHECKBOOK_ID,
      CeCheckbooks.checkbook_name,
      CeCheckbooks.PREFIX,
      CeCheckbooks.START_NUMBER,
      CeCheckbooks.END_NUMBER,
      CeCheckbooks.date_received,
      xxx.internal_bank_account_id,
      xxx.PAYMENT_DOCUMENT_name,
      CeCheckbooks.LAST_UPDATED_BY  						
    ,CeCheckbooks.LAST_UPDATE_DATE  						
    ,CeCheckbooks.CREATED_BY  							
    ,CeCheckbooks.CREATION_DATE  							
    FROM CE_CHECKBOOKS CeCheckbooks ,CE_PAYMENT_DOCUMENTS xxx
    WHERE xxx.PAYMENT_DOCUMENT_ID = CeCheckbooks.PAYMENT_DOCUMENT_ID
) DETAIL
WHERE Head.BANK_ACCOUNT_ID   = detail.internal_bank_account_id