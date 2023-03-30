/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
  , IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  												 RES_CODE 
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_PI_REGISTER'
            AND FORMAT_CODE    = PM.PI_REGISTER_FORMAT ) RES_PAYMENT_FILE_REGISTER_FORM
  , DECODE(PM.AUTOMATIC_PI_REG_SUBMIT,'Y','Yes','No')    RES_PAYMENT_FILE_REGISTER_AUTO
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_POS_PAY'
            AND FORMAT_CODE    = PM.POSITIVE_PAY_FORMAT_CODE ) RES_POSITIVE_PAY_FORMAT
  , PM.POSITIVE_PAY_FILE_PREFIX                                RES_FILE_PREFIX
  , PM.POSITIVE_PAY_FILE_EXTENSION                             RES_FILE_EXTENSION
  , PM.POSITIVE_PAY_FILE_DIRECTORY                             RES_FILE_DIRECTORY
  , DECODE(PM.POSITIVE_PAY_DELIVERY_FLAG,'Y','Yes','No')       RES_AUTOMATICALLY_TRANSMIT_FIL
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_SRA'
            AND FORMAT_CODE    = ST.REMITTANCE_ADVICE_FORMAT_CODE ) RES_SEPARATE_REMITTANCE_ADVICE
  , DECODE(ST.AUTOMATIC_SRA_SUBMIT_FLAG,'Y','Yes','No')             RES_SEPARATE_REMITTANCE_ADVI_0
  , DECODE(ST.ALLOW_MULTIPLE_COPY_FLAG,'Y','Yes','No')              RES_ALLOW_MULTIPLE_COPIES_FOR_
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE lookup_type   = 'IBY_REMIT_ADVICE_CONDITIONS'
            AND lookup_code = (DECODE(document_count_limit, NULL, DECODE(payment_details_length_limit, NULL, 'ALL_PAYMENTS', 'PAYMENT_DETAIL_LENGTH'), 'NUMBER_OF_DOCUMENTS')) ) RES_CONDITION
  , ST.DOCUMENT_COUNT_LIMIT                                                                                                                                                      RES_TOTAL_NUMBER_OF_DOCUMENTS
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE LOOKUP_TYPE   = 'IBY_DELIVERY_METHODS'
            AND lookup_code = ST.REMIT_ADVICE_DELIVERY_METHOD ) RES_DELIVERY_METHOD
  , DECODE(ST.Sra_override_payee_flag,'Y','Yes','No')           RES_OVERRIDE_PAYEE_DELIVERY_ME
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE lookup_type   = 'IBY_CENTRAL_BANK_REPORT_OPTION'
            AND lookup_code = PM.DECLARATION_OPTION ) RES_REPORTING_OPTION
  , (
        SELECT DISTINCT GlDailyConversionTypes.USER_CONVERSION_TYPE
        FROM GL_DAILY_CONVERSION_TYPES GlDailyConversionTypes
        WHERE GlDailyConversionTypes.CONVERSION_TYPE = PM.DECLARATION_CURR_FX_RATE_TYPE ) RES_CONVERSION_RATE_TYPE
  , (
        SELECT DISTINCT(currency_code
                ||' - '
                ||name)
        FROM FND_CURRENCIES_TL
        WHERE currency_code = PM.DECLARATION_CURRENCY_CODE 
		and language = userenv('LANG')  ) RES_THRESHOLD_AMOUNT
  , PM.DECLARATION_threshold_amount                          RES_AMOUNT
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_REG_RPT'
            AND FORMAT_CODE    = PM.DECLARATION_REPORT_FORMAT_CODE )    RES_FORMAT
  , PM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , PM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , PM.CREATED_BY  RSC_CREATED_BY
  , PM.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
  , '' RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
, IBY_SYS_PMT_PROFILES_B PM
, IBY_REMIT_ADVICE_SETUP ST
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE   = PM.SYSTEM_PROFILE_CODE(+)
AND IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = ST.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

UNION

SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
  , IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  												 RES_CODE 
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_PI_REGISTER'
            AND FORMAT_CODE    = PM.PI_REGISTER_FORMAT ) RES_PAYMENT_FILE_REGISTER_FORM
  , DECODE(PM.AUTOMATIC_PI_REG_SUBMIT,'Y','Yes','No')    RES_PAYMENT_FILE_REGISTER_AUTO
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_POS_PAY'
            AND FORMAT_CODE    = PM.POSITIVE_PAY_FORMAT_CODE ) RES_POSITIVE_PAY_FORMAT
  , PM.POSITIVE_PAY_FILE_PREFIX                                RES_FILE_PREFIX
  , PM.POSITIVE_PAY_FILE_EXTENSION                             RES_FILE_EXTENSION
  , PM.POSITIVE_PAY_FILE_DIRECTORY                             RES_FILE_DIRECTORY
  , DECODE(PM.POSITIVE_PAY_DELIVERY_FLAG,'Y','Yes','No')       RES_AUTOMATICALLY_TRANSMIT_FIL
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_SRA'
            AND FORMAT_CODE    = ST.REMITTANCE_ADVICE_FORMAT_CODE ) RES_SEPARATE_REMITTANCE_ADVICE
  , DECODE(ST.AUTOMATIC_SRA_SUBMIT_FLAG,'Y','Yes','No')             RES_SEPARATE_REMITTANCE_ADVI_0
  , DECODE(ST.ALLOW_MULTIPLE_COPY_FLAG,'Y','Yes','No')              RES_ALLOW_MULTIPLE_COPIES_FOR_
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE lookup_type   = 'IBY_REMIT_ADVICE_CONDITIONS'
            AND lookup_code = (DECODE(document_count_limit, NULL, DECODE(payment_details_length_limit, NULL, 'ALL_PAYMENTS', 'PAYMENT_DETAIL_LENGTH'), 'NUMBER_OF_DOCUMENTS')) ) RES_CONDITION
  , ST.DOCUMENT_COUNT_LIMIT                                                                                                                                                      RES_TOTAL_NUMBER_OF_DOCUMENTS
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE LOOKUP_TYPE   = 'IBY_DELIVERY_METHODS'
            AND lookup_code = ST.REMIT_ADVICE_DELIVERY_METHOD ) RES_DELIVERY_METHOD
  , DECODE(ST.Sra_override_payee_flag,'Y','Yes','No')           RES_OVERRIDE_PAYEE_DELIVERY_ME
  , (
        SELECT MEANING
        FROM FND_LOOKUPS
        WHERE lookup_type   = 'IBY_CENTRAL_BANK_REPORT_OPTION'
            AND lookup_code = PM.DECLARATION_OPTION ) RES_REPORTING_OPTION
  , (
        SELECT DISTINCT GlDailyConversionTypes.USER_CONVERSION_TYPE
        FROM GL_DAILY_CONVERSION_TYPES GlDailyConversionTypes
        WHERE GlDailyConversionTypes.CONVERSION_TYPE = PM.DECLARATION_CURR_FX_RATE_TYPE ) RES_CONVERSION_RATE_TYPE
  , (
        SELECT DISTINCT(currency_code
                ||' - '
                ||name)
        FROM FND_CURRENCIES_TL
        WHERE currency_code = PM.DECLARATION_CURRENCY_CODE 
		and language = userenv('LANG')  ) RES_THRESHOLD_AMOUNT
  , PM.DECLARATION_threshold_amount                          RES_AMOUNT
  , (
        SELECT format_name
        FROM IBY_FORMATS_VL
        WHERE format_type_code = 'IBY_FD_REG_RPT'
            AND FORMAT_CODE    = PM.DECLARATION_REPORT_FORMAT_CODE )    RES_FORMAT
  , PM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , PM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , PM.CREATED_BY  RSC_CREATED_BY
  , PM.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
  , TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
, IBY_SYS_PMT_PROFILES_B PM
, IBY_REMIT_ADVICE_SETUP ST
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE   = PM.SYSTEM_PROFILE_CODE(+)
AND IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = ST.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

--ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME