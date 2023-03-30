/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Payment Documents.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT 
Head.BANK_NAME  												RES_BANK,
Head.COUNTRY_NAME      											RES_COUNTRY,
Head.BANK_BRANCH_NAME        									RES_BANK_BRANCH,
Head.BANK_ACCOUNT_NAME            								RES_ACCOUNT_NAME,
Head.BANK_ACCOUNT_NUM             								RES_ACCOUNT_NUMBER,
Detail.PAYMENT_DOCUMENT_NAME                       				RES_PAYMENT_DOCUMENT,
( SELECT meaning
  FROM FND_LOOKUP_VALUES
  WHERE LOOKUP_TYPE = 'CE_PAPER_STOCK_TYPES'
  AND LOOKUP_CODE   =  Detail.PAPER_STOCK_TYPE 
  AND language  = userenv('LANG') )             	RES_PAPER_STOCK_TYPE,
decode(Detail.ATTACHED_REMITTANCE_STUB_FLAG,'Y','Yes','No') RES_ATTACHED_REMITTANCE_STUB,
Detail.NUMBER_OF_LINES_PER_REMIT_STUB                			RES_NUMBER_OF_LINES_PER_REMITT,
DETAIL.NUMBER_OF_SETUP_DOCUMENTS                           		RES_NUMBER_OF_SETUP_DOCUMENTS,
DETAIL.FORMAT_NAME                                     			RES_FORMAT_NAME,
DETAIL.FORMAT_CODE                                              RES_FORMAT_CODE,
decode(DETAIL.MANUAL_PAYMENTS_ONLY_FLAG,'Y','Yes','No')                                RES_RESTRICT_USE_TO_MANUALLY_I,
 decode(DETAIL.STATUS,'Y','Active','N','Inactive')              RES_STATUS,
to_char(INACTIVE_DATE,'DD-Mon-YYYY')                            RES_END_DATE,
 ( select distinct name from fnd_doc_sequence_categories  aa where aa.APPLICATION_ID = 200
   AND aa.code = Detail.PAYMENT_DOC_CATEGORY          )          					RES_PAYMENT_DOCUMENT_CATEGORY,
FIRST_AVAILABLE_DOCUMENT_NUM                                  	RES_FIRST_AVAILABLE_DOCUMENT_N,
LAST_AVAILABLE_DOCUMENT_NUMBER                                  RES_LAST_AVAILABLE_DOCUMENT_NU,
LAST_ISSUED_DOCUMENT_NUMBER RES_LAST_ISSUED_DOCUMENT_NUMBE,
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
     CePaymentDocuments.PAYMENT_DOCUMENT_ID,
    CePaymentDocuments.PAYMENT_DOCUMENT_NAME,
    CePaymentDocuments.PAYMENT_INSTRUCTION_ID,
    CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID,
    CePaymentDocuments.PAPER_STOCK_TYPE,
    CePaymentDocuments.ATTACHED_REMITTANCE_STUB_FLAG,
    CePaymentDocuments.NUMBER_OF_LINES_PER_REMIT_STUB,
    CePaymentDocuments.NUMBER_OF_SETUP_DOCUMENTS,
    CePaymentDocuments.FORMAT_CODE,
    CePaymentDocuments.MANUAL_PAYMENTS_ONLY_FLAG,
    CePaymentDocuments.INACTIVE_DATE,
    CePaymentDocuments.PAYMENT_DOC_CATEGORY,
    CePaymentDocuments.FIRST_AVAILABLE_DOCUMENT_NUM,
    CePaymentDocuments.LAST_AVAILABLE_DOCUMENT_NUMBER,
    CePaymentDocuments.LAST_ISSUED_DOCUMENT_NUMBER,
    CePaymentDocuments.CREATED_BY,
    CePaymentDocuments.CREATION_DATE,
    CePaymentDocuments.LAST_UPDATED_BY,
    CePaymentDocuments.LAST_UPDATE_DATE,
    CePaymentDocuments.LAST_UPDATE_LOGIN,
    CePaymentDocuments.OBJECT_VERSION_NUMBER,
    DECODE(Inactive_date, NULL, 'Y', 'N') AS STATUS,
    (SELECT format_name
    FROM iby_formats_vl
    WHERE format_code = CePaymentDocuments.FORMAT_CODE
    )                        AS FORMAT_NAME,
    IbyFormatsVl.FORMAT_NAME AS FORMAT_NAME1,
    IbyFormatsVl.FORMAT_CODE AS FORMAT_CODE1
  FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments,
    IBY_FORMATS_VL IbyFormatsVl
  WHERE CePaymentDocuments.FORMAT_CODE            = IbyFormatsVl.FORMAT_CODE
  
  
) DETAIL
WHERE Head.BANK_ACCOUNT_ID   = detail.INTERNAL_BANK_ACCOUNT_ID