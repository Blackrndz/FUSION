/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME          		RES_NAME 
, IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  RES_CODE 
,  decode(pm.applicable_value_to ,'','All','Specify')       			RES_CURRENCIES_OPTION
, ( select distinct(currency_code||' - '||name) from  FND_CURRENCIES_TL where currency_code = PM.applicable_value_to and language = userenv('LANG')     )      			RES_CURRENCIES
, PM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, PM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, PM.CREATED_BY  RSC_CREATED_BY
, PM.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, '' RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL    IbySysPmtProfilesVl,
     IBY_APPLICABLE_PMT_PROFS   PM
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE         = PM.SYSTEM_PROFILE_CODE(+)
AND  pm.applicable_type_code  = 'CURRENCY_CODE'
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

UNION 

SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME          		RES_NAME 
, IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  RES_CODE 
,  decode(pm.applicable_value_to ,'','All','Specify')       			RES_CURRENCIES_OPTION
, ( select distinct(currency_code||' - '||name) from  FND_CURRENCIES_TL where currency_code = PM.applicable_value_to and language = userenv('LANG')     )      			RES_CURRENCIES
, PM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, PM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, PM.CREATED_BY  RSC_CREATED_BY
, PM.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL    IbySysPmtProfilesVl,
     IBY_APPLICABLE_PMT_PROFS   PM
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE         = PM.SYSTEM_PROFILE_CODE(+)
AND  pm.applicable_type_code  = 'CURRENCY_CODE'
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
--ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME 
