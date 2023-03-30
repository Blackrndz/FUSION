/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT DISTINCT HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzPartiesE0.PARTY_NAME RES_NAME
,HzPartySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,HzPartySitesE0.PARTY_SITE_NAME RES_SITE_NAME
,IbyExtBankAccountsE0.BANK_ACCOUNT_NUM RES_ACCOUNT_NUMBER
,CeBankBranchsE0.BANK_NAME RES_BANK_NAME
,(SELECT TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_TL
	WHERE TERRITORY_CODE = IbyIntermediaryAcctsE0.COUNTRY_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_COUNTRY
,IbyIntermediaryAcctsE0.ACCOUNT_NUMBER RES_NUMBER
,IbyIntermediaryAcctsE0.BANK_NAME RES_INTERMEDIARY_ACCOUNTS_BANK
,IbyIntermediaryAcctsE0.BRANCH_NUMBER RES_BRANCH_NUMBER
,IbyIntermediaryAcctsE0.IBAN RES_IBAN
,IbyIntermediaryAcctsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,IbyIntermediaryAcctsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,IbyIntermediaryAcctsE0.CREATED_BY  RSC_CREATED_BY
,IbyIntermediaryAcctsE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_ORGANIZATION_PROFILES HzOrganizationProfileE0
,HZ_PARTY_SITES HzPartySitesE0
,IBY_EXTERNAL_PAYEES_ALL ExtPayeesE0
,IBY_EXT_PARTY_PMT_MTHDS ExtPaymentMethodsE0
,IBY_PMT_INSTR_USES_ALL IbyPmtInstrUsesAllE0
,IBY_EXT_BANK_ACCOUNTS IbyExtBankAccountsE0
,CE_BANK_BRANCHES_V CeBankBranchsE0
,IBY_INTERMEDIARY_ACCTS IbyIntermediaryAcctsE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzOrganizationProfileE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzPartySitesE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
AND HzPartySitesE0.STATUS = 'A'
AND HzPartySitesE0.PARTY_ID = ExtPayeesE0.PAYEE_PARTY_ID
AND HzPartySitesE0.PARTY_SITE_ID = ExtPayeesE0.PARTY_SITE_ID
AND ExtPayeesE0.EXT_PAYEE_ID = ExtPaymentMethodsE0.EXT_PMT_PARTY_ID
AND ExtPaymentMethodsE0.EXT_PMT_PARTY_ID = IbyPmtInstrUsesAllE0.EXT_PMT_PARTY_ID
AND IbyPmtInstrUsesAllE0.INSTRUMENT_ID = IbyExtBankAccountsE0.EXT_BANK_ACCOUNT_ID
AND IbyExtBankAccountsE0.BANK_ID = CeBankBranchsE0.BANK_PARTY_ID(+)
AND IbyExtBankAccountsE0.BRANCH_ID = CeBankBranchsE0.BRANCH_PARTY_ID(+)
AND IbyExtBankAccountsE0.EXT_BANK_ACCOUNT_ID = IbyIntermediaryAcctsE0.BANK_ACCT_ID
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzPartySitesE0.PARTY_SITE_NUMBER