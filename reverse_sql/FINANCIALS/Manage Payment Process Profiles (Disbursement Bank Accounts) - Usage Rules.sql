/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
,IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE RES_CODE
,DECODE(pm.applicable_value_to,'','All','Specify') RES_DISBURSEMENT_BANK_ACCOUNTS
,BankDetail.BANK_ACCOUNT_NAME RES_DISBURSEMENT_BANK_ACCOUN_0
,BankDetail.BANK_NAME RES_DISBURSEMENT_BANK_NAME
,BankDetail.BANK_BRANCH_NAME RES_DISBURSEMENT_BANK_BRANCH
,PM.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PM.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PM.CREATED_BY RSC_CREATED_BY
,PM.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
, (CASE 
	WHEN PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID IS NULL THEN
		TO_CHAR(BankDetail.ACCOUNT_OWNER_ORG_ID)
	ELSE
		CASE	
			WHEN BankDetail.ACCOUNT_OWNER_ORG_ID IS NULL THEN
				NULL
			ELSE
				CASE
					WHEN PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID = BankDetail.ACCOUNT_OWNER_ORG_ID THEN
						TO_CHAR(BankDetail.ACCOUNT_OWNER_ORG_ID)
					ELSE
						'-1'
					END
			END
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,IBY_APPLICABLE_PMT_PROFS PM
,(SELECT BankE0.BANK_NAME
	,BankBranchE0.BANK_BRANCH_NAME
	,BankAccE0.BANK_ACCOUNT_NAME
	,BankAccE0.ACCOUNT_OWNER_ORG_ID
	,BankAccE0.BANK_ACCOUNT_ID
	FROM CE_BANKS_V BankE0
	,CE_BANK_BRANCHES_V BankBranchE0
	,CE_BANK_ACCOUNTS BankAccE0
	WHERE BankE0.BANK_PARTY_ID       = BankBranchE0.BANK_PARTY_ID
	AND BankBranchE0.BANK_PARTY_ID   = BankAccE0.BANK_ID
	AND BankBranchE0.BRANCH_PARTY_ID = BankAccE0.BANK_BRANCH_ID
	) BankDetail
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_NAME||' '||CeBankAccounts.BANK_ACCOUNT_NAME DEFAULT_PAYMENT_DOCUMENT
	,CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = PM.SYSTEM_PROFILE_CODE(+)
AND Pm.Applicable_Type_Code                   = 'INTERNAL_BANK_ACCOUNT'
AND Pm.Applicable_Value_To                    = BankDetail.BANK_ACCOUNT_ID(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME 