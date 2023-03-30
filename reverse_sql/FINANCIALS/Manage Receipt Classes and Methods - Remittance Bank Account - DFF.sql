/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Remittance%20Bank%20Account%20-%20DFF.sql $:
 * $Id: Manage Receipt Classes and Methods - Remittance Bank Account - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##AR_RECEIPT_METHOD_ACCOUNTS
-- DFF_ATTRIBUTES=ATTRIBUTE,GLOBAL_ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

SELECT ArReceiptClasses.NAME AS RES_NAME
,ARM.name                    AS RES_RECEIPT_METHODS_NAME
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ArReceiptMethodAccountsAll.ORG_ID
	)                             AS RES_BUSINESS_UNIT
,CEBranchE0.BANK_NAME          AS RES_BANK_NAME
,CEBranchE0.BANK_BRANCH_NAME   AS RES_BRANCH
,CEBankAccE0.BANK_ACCOUNT_NAME AS RES_ACCOUNT
,ArReceiptMethodAccountsAll.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,ArReceiptMethodAccountsAll.ATTRIBUTE1
,ArReceiptMethodAccountsAll.ATTRIBUTE2
,ArReceiptMethodAccountsAll.ATTRIBUTE3
,ArReceiptMethodAccountsAll.ATTRIBUTE4
,ArReceiptMethodAccountsAll.ATTRIBUTE5
,ArReceiptMethodAccountsAll.ATTRIBUTE6
,ArReceiptMethodAccountsAll.ATTRIBUTE7
,ArReceiptMethodAccountsAll.ATTRIBUTE8
,ArReceiptMethodAccountsAll.ATTRIBUTE9
,ArReceiptMethodAccountsAll.ATTRIBUTE10
,ArReceiptMethodAccountsAll.ATTRIBUTE11
,ArReceiptMethodAccountsAll.ATTRIBUTE12
,ArReceiptMethodAccountsAll.ATTRIBUTE13
,ArReceiptMethodAccountsAll.ATTRIBUTE14
,ArReceiptMethodAccountsAll.ATTRIBUTE15
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE1
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE2
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE3
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE4
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE5
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE6
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE7
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE8
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE9
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE10
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE11
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE12
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE13
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE14
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE15
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE16
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE17
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE18
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE19
,ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE20
,ArReceiptMethodAccountsAll.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,ArReceiptMethodAccountsAll.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,ArReceiptMethodAccountsAll.CREATED_BY RSC_CREATED_BY
,ArReceiptMethodAccountsAll.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_RECEIPT_METHOD_ACCOUNTS_ALL ArReceiptMethodAccountsAll
,FUSION.AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHODS ARM
,CE_BANK_BRANCHES_V CEBranchE0
,CE_BANK_ACCOUNTS CEBankAccE0
,ce_bank_acct_uses_all CEBankacctuseE0
WHERE(ArReceiptMethodAccountsAll.ATTRIBUTE_CATEGORY IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE1            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE2            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE3            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE4            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE5            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE6            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE7            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE8            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE9            IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE10           IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE11           IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE12           IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE13           IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE14           IS NOT NULL
OR ArReceiptMethodAccountsAll.ATTRIBUTE15           IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE1     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE2     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE3     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE4     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE5     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE6     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE7     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE8     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE9     IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE10    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE11    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE12    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE13    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE14    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE15    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE16    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE17    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE18    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE19    IS NOT NULL
OR ArReceiptMethodAccountsAll.GLOBAL_ATTRIBUTE20    IS NOT NULL)
AND ArReceiptMethodAccountsAll.RECEIPT_METHOD_ID     = ARM.RECEIPT_METHOD_ID
AND ARM.RECEIPT_CLASS_ID                             = ArReceiptClasses.RECEIPT_CLASS_ID
AND ArReceiptMethodAccountsAll.REMIT_BANK_ACCT_USE_ID = CEBankacctuseE0.BANK_ACCT_USE_ID
and CEBankacctuseE0.BANK_ACCOUNT_ID = CEBankAccE0.bank_account_id 
and CEBankAccE0.Bank_ID = CEBranchE0.Bank_Party_ID
and CEBankAccE0.Bank_Branch_ID = CEBranchE0.Branch_party_id
ORDER BY RES_NAME

/*SELECT ArReceiptClasses.NAME AS RES_NAME
, ARM.name AS RES_RECEIPT_METHODS_NAME
, DFF.FIELD_NAME AS RES_FIELD_NAME
, DFF.FIELD_VALUE AS RES_FIELD_VALUE
,NULL MAPPER 
,ArReceiptMethodAccountsAll.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,ArReceiptMethodAccountsAll.LAST_UPDATE_DATE  AS RSC_LAST_UPDATE_DATE
FROM AR_RECEIPT_METHOD_ACCOUNTS_ALL ArReceiptMethodAccountsAll
,FUSION.AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHODS ARM
, TABLE(FUSION_READONLY.##RES_PLSQL_PACKAGE_NAME##.GET_DFF(P_APPLICATION_ID => 222
														  ,P_DFF_CODE => 'AR_RECEIPT_METHOD_ACCOUNTS'
														  ,P_BASE_TABLE => 'AR_RECEIPT_METHOD_ACCOUNTS_ALL'
														  ,P_PK_COLUMN_1 => 'RECEIPT_METHOD_ID'																	  
	)) DFF
WHERE DFF.FIELD_VALUE                     IS NOT NULL
AND ArReceiptMethodAccountsAll.RECEIPT_METHOD_ID = ARM.RECEIPT_METHOD_ID
AND ARM.RECEIPT_CLASS_ID                           = ArReceiptClasses.RECEIPT_CLASS_ID
AND  ArReceiptMethodAccountsAll.RECEIPT_METHOD_ID = TO_NUMBER(DFF.COL_1)
and (ArReceiptMethodAccountsAll.last_updated_by ##LAST_UPDATED_BY_OPERATOR## (##USER_NAME_LIST##) AND ArReceiptMethodAccountsAll.last_update_date ##LAST_UPDATE_DATE_OPERATOR##  to_date('##SEEDED_DATE##'))
ORDER BY RES_NAME*/