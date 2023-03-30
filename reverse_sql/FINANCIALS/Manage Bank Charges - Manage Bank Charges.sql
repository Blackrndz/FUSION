/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Charges%20-%20Manage%20Bank%20Charges.sql $:
* $Id: Manage Bank Charges - Manage Bank Charges.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DECODE(NVL(BankChargeHeaderEO.LEGAL_ENTITY_ID, - 99), - 99,(SELECT displayed_field
	FROM ap_lookup_codes
	WHERE lookup_type = 'LITERAL'
	AND lookup_code   = BankChargeHeaderEO.LEGAL_ENTITY_ID
	),LegalEntityPEO.NAME)                      AS RES_LEGAL_ENTITY
,BankChargeHeaderEO.CURRENCY_CODE            AS RES_CURRENCY
,FndLookupSPPEO.MEANING                      AS RES_SETTLEMENT_PRIORITY
,PayablesLookupTBankPEO.DISPLAYED_FIELD      AS RES_BANK_OPTION_TRANSFERRING
,PayablesLookupRBankPEO.DISPLAYED_FIELD      AS RES_BANK_OPTION_RECEIVING
,BankChargeHeaderEO.TRANSFERRING_BANK_NAME   AS RES_BANK_NAME_TRANSFERRING
,BankChargeHeaderEO.RECEIVING_BANK_NAME      AS RES_BANK_NAME_RECEIVING
,BankBranchSimpleTBankPEO.BANK_NUMBER        AS RES_BANK_NUMBER_TRANSFERRING
,BankBranchSimpleRBankPEO.BANK_NUMBER        AS RES_BANK_NUMBER_RECEIVING
,PayablesLookupTBranchPEO.DISPLAYED_FIELD    AS RES_BRANCH_OPTION_TRANSFERRING
,PayablesLookupRBranchPEO.DISPLAYED_FIELD    AS RES_BRANCH_OPTION_RECEIVING
,BankBranchSimpleTBranchPEO.BANK_BRANCH_NAME AS RES_BRANCH_NAME_TRANSFERRING
,BankBranchSimpleRBranchPEO.BANK_BRANCH_NAME AS RES_BRANCH_NAME_RECEIVING
,BankBranchSimpleTBranchPEO.BRANCH_NUMBER    AS RES_BRANCH_NUMBER_TRANSFERRING
,BankBranchSimpleRBranchPEO.BRANCH_NUMBER    AS RES_BRANCH_NUMBER_RECEIVING
,BankChargeHeaderEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BankChargeHeaderEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BankChargeHeaderEO.CREATED_BY RSC_CREATED_BY
,BankChargeHeaderEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,BankChargeHeaderEO.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_BANK_CHARGES BankChargeHeaderEO
,FND_LOOKUP_VALUES FndLookupSPPEO
,AP_LOOKUP_CODES PayablesLookupTBankPEO
,AP_LOOKUP_CODES PayablesLookupTBranchPEO
,AP_LOOKUP_CODES PayablesLookupRBankPEO
,AP_LOOKUP_CODES PayablesLookupRBranchPEO
,CE_ALL_BANKS_V BankBranchSimpleTBankPEO
,CE_BANK_BRANCHES_SIMPLE_V BankBranchSimpleTBranchPEO
,CE_ALL_BANKS_V BankBranchSimpleRBankPEO
,CE_BANK_BRANCHES_SIMPLE_V BankBranchSimpleRBranchPEO
,XLE_ENTITY_PROFILES LegalEntityPEO
WHERE FndLookupSPPEO.LOOKUP_TYPE                   = 'IBY_SETTLEMENT_PRIORITY'
AND FndLookupSPPEO.LANGUAGE                        = userenv('LANG')
AND BankChargeHeaderEO.SETTLEMENT_PRIORITY         = FndLookupSPPEO.LOOKUP_CODE
AND PayablesLookupTBankPEO.LOOKUP_TYPE             = 'BANK_CHARGE_BANK'
AND BankChargeHeaderEO.TRANSFERRING_BANK           = PayablesLookupTBankPEO.LOOKUP_CODE
AND PayablesLookupTBranchPEO.LOOKUP_TYPE           = 'BANK_CHARGE_BRANCH'
AND BankChargeHeaderEO.TRANSFERRING_BRANCH         = PayablesLookupTBranchPEO.LOOKUP_CODE
AND PayablesLookupRBankPEO.LOOKUP_TYPE             = 'BANK_CHARGE_BANK'
AND BankChargeHeaderEO.RECEIVING_BANK              = PayablesLookupRBankPEO.LOOKUP_CODE
AND PayablesLookupRBranchPEO.LOOKUP_TYPE           = 'BANK_CHARGE_BRANCH'
AND BankChargeHeaderEO.RECEIVING_BRANCH            = PayablesLookupRBranchPEO.LOOKUP_CODE
AND BankBranchSimpleTBankPEO.BANK_PARTY_ID (+)     = BankChargeHeaderEO.TRANSFERRING_BANK_ID
AND BankBranchSimpleTBranchPEO.BRANCH_PARTY_ID (+) = BankChargeHeaderEO.TRANSFERRING_BANK_BRANCH_ID
AND BankBranchSimpleRBankPEO.BANK_PARTY_ID (+)     = BankChargeHeaderEO.RECEIVING_BANK_ID
AND BankBranchSimpleRBranchPEO.BRANCH_PARTY_ID (+) = BankChargeHeaderEO.RECEIVING_BANK_BRANCH_ID
AND LegalEntityPEO.LEGAL_ENTITY_ID (+)             = BankChargeHeaderEO.LEGAL_ENTITY_ID
ORDER BY RES_LEGAL_ENTITY
