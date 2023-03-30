/* ****************************************************************************
 * $Revision: 79134 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-08-03 15:04:25 +0700 (Wed, 03 Aug 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Process%20Profiles%20-%20Payment%20File.sql $:
 * $Id: Manage Payment Process Profiles - Payment File.sql 79134 2022-08-03 08:04:25Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
  , IBYSYSPMTPROFILESVL.SYSTEM_PROFILE_CODE  RES_CODE   
  , (   SELECT DISTINCT FORMAT_NAME
        FROM IBY_FORMATS_VL
        WHERE FORMAT_CODE = PM.PAY_FILE_LETTER_FORMAT_CODE ) RES_PAYMENT_FILE_ACCOMPANYING_
  , PM.OUTBOUND_PMT_FILE_DIRECTORY                           RES_OUTBOUND_PAYMENT_FILE_DIRE
  , PM.OUTBOUND_PMT_FILE_PREFIX                              RES_OUTBOUND_PAYMENT_FILE_PREF
  , PM.OUTBOUND_PMT_FILE_EXTENSION                           RES_OUTBOUND_PAYMENT_FILE_EXTE
  , DECODE(Rul.GROUP_BY_ORGANIZATION,'Y','Yes','No')         RES_BUSINESS_UNIT
  , DECODE(RUL.GROUP_BY_LEGAL_ENTITY,'Y','Yes','No')         RES_FIRST_PARTY_LEGAL_ENTITY
  , (case
		when IBYSYSPMTPROFILESVL.PROCESSING_TYPE = 'ELECTRONIC' then
			  DECODE(RUL.GROUP_BY_PAYMENT_CURRENCY,'Y','Yes','No')  
		else
			null	
     end) RES_PAYMENT_CURRENCY     
  , DECODE(Rul.GROUP_BY_PAYMENT_DATE ,'Y','Yes','No')        RES_PAYMENT_DATE
  , DECODE(Rul.GROUP_BY_PAYMENT_FUNCTION ,'Y','Yes','No')    RES_PAYMENT_FUNCTION
  , DECODE(Rul.GROUP_BY_PAYMENT_REASON ,'Y','Yes','No')      RES_PAYMENT_REASON 
  , (case
		when IBYSYSPMTPROFILESVL.PROCESSING_TYPE = 'ELECTRONIC' then
			  DECODE(RUL.GROUP_BY_INTERNAL_BANK_ACCOUNT,'Y','Yes','No')  
		else
			null	
     end) RES_DISBURSEMENT_BANK_ACCOUNT      
  , DECODE(Rul.GROUP_BY_PAY_SERVICE_REQUEST ,'Y','Yes','No') RES_PAYMENT_PROCESS_REQUEST
  , DECODE(Rul.GROUP_BY_BILL_PAYABLE,'Y','Yes','No')         RES_BILLS_PAYABLE
  , DECODE(Rul.GROUP_BY_RFC,'Y','Yes','No')                  RES_RFC_IDENTIFIER
  , DECODE(PM.batch_booking_flag,'Y','Yes','No')             RES_BATCH_BOOKING
  , (
        SELECT DISTINCT meaning
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'SERVICE_LEVEL'
            AND payment_code                  = PM.service_level_code ) RES_SERVICE_LEVEL
  /*, (SELECT DISTINCT trim(TerritoryPEO.Territory_Short_Name
                ||' '
                ||PaymentCodeEO.MEANING)
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
          , FND_TERRITORIES_VL TerritoryPEO
        WHERE PaymentCodeEO.TERRITORY_CODE = TerritoryPEO.TERRITORY_CODE(+)
		AND PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL*/
  ,(SELECT DISTINCT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL_NAME
  ,(SELECT DISTINCT PaymentCodeEO.PAYMENT_CODE 
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL_CODE
  , (
        SELECT DISTINCT(currency_code
                ||' - '
                ||name)
        FROM FND_CURRENCIES_TL
        WHERE currency_code = rul.max_amount_per_instr_curr_code
		AND LANGUAGE = USERENV('LANG')
		) RES_CURRENCY
  , rul.max_amount_per_instr_value                                 RES_CURRENCY_AMOUNT
  , rul.max_payments_per_instruction                               RES_NUMBER_OF_PAYMENTS
  , (
        SELECT GlDailyConversionTypes.USER_CONVERSION_TYPE
        FROM GL_DAILY_CONVERSION_TYPES GlDailyConversionTypes
        WHERE GlDailyConversionTypes.CONVERSION_TYPE = rul.max_amount_fx_rate_type ) RES_CONVERSION_RATE_TYPE
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_1 ) RES_FIRST_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_1 ) RES_FIRST_SORT_ORDER
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_2 ) RES_SECOND_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_2 ) RES_SECOND_SORT_ORDER
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_3 ) RES_THIRD_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_3 ) RES_THIRD_SORT_ORDER
  , (
        SELECT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'BANK_INSTRUCTION'
            AND PaymentCodeEO.PAYMENT_CODE    = PM.BANK_INSTRUCTION1_CODE ) RES_BANK_INSTRUCTION_1
  , (
        SELECT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'BANK_INSTRUCTION'
            AND PaymentCodeEO.PAYMENT_CODE    = PM.BANK_INSTRUCTION2_CODE )    RES_BANK_INSTRUCTION_2
  , PM.BANK_INSTRUCTION_DETAILS                                                RES_BANK_INSTRUCTION_DETAILS
  , PM.PAYMENT_TEXT_MESSAGE1                                                   RES_PAYMENT_TEXT_MESSAGE_1
  , PM.PAYMENT_TEXT_MESSAGE2                                                   RES_PAYMENT_TEXT_MESSAGE_2
  , IbySysPmtProfilesVl.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , IbySysPmtProfilesVl.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , IbySysPmtProfilesVl.CREATED_BY  RSC_CREATED_BY
  , IbySysPmtProfilesVl.CREATION_DATE  RSC_CREATION_DATE
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
, IBY_INSTR_CREATION_RULES Rul
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE   = PM.SYSTEM_PROFILE_CODE(+)
AND IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = Rul.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

UNION

SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
  , IBYSYSPMTPROFILESVL.SYSTEM_PROFILE_CODE  RES_CODE   
  , (   SELECT DISTINCT FORMAT_NAME
        FROM IBY_FORMATS_VL
        WHERE FORMAT_CODE = PM.PAY_FILE_LETTER_FORMAT_CODE ) RES_PAYMENT_FILE_ACCOMPANYING_
  , PM.OUTBOUND_PMT_FILE_DIRECTORY                           RES_OUTBOUND_PAYMENT_FILE_DIRE
  , PM.OUTBOUND_PMT_FILE_PREFIX                              RES_OUTBOUND_PAYMENT_FILE_PREF
  , PM.OUTBOUND_PMT_FILE_EXTENSION                           RES_OUTBOUND_PAYMENT_FILE_EXTE
  , DECODE(Rul.GROUP_BY_ORGANIZATION,'Y','Yes','No')         RES_BUSINESS_UNIT
  , DECODE(RUL.GROUP_BY_LEGAL_ENTITY,'Y','Yes','No')         RES_FIRST_PARTY_LEGAL_ENTITY
  , (case
		when IBYSYSPMTPROFILESVL.PROCESSING_TYPE = 'ELECTRONIC' then
			  DECODE(RUL.GROUP_BY_PAYMENT_CURRENCY,'Y','Yes','No')  
		else
			null	
     end) RES_PAYMENT_CURRENCY     
  , DECODE(Rul.GROUP_BY_PAYMENT_DATE ,'Y','Yes','No')        RES_PAYMENT_DATE
  , DECODE(Rul.GROUP_BY_PAYMENT_FUNCTION ,'Y','Yes','No')    RES_PAYMENT_FUNCTION
  , DECODE(Rul.GROUP_BY_PAYMENT_REASON ,'Y','Yes','No')      RES_PAYMENT_REASON 
  , (case
		when IBYSYSPMTPROFILESVL.PROCESSING_TYPE = 'ELECTRONIC' then
			  DECODE(RUL.GROUP_BY_INTERNAL_BANK_ACCOUNT,'Y','Yes','No')  
		else
			null	
     end) RES_DISBURSEMENT_BANK_ACCOUNT      
  , DECODE(Rul.GROUP_BY_PAY_SERVICE_REQUEST ,'Y','Yes','No') RES_PAYMENT_PROCESS_REQUEST
  , DECODE(Rul.GROUP_BY_BILL_PAYABLE,'Y','Yes','No')         RES_BILLS_PAYABLE
  , DECODE(Rul.GROUP_BY_RFC,'Y','Yes','No')                  RES_RFC_IDENTIFIER
  , DECODE(PM.batch_booking_flag,'Y','Yes','No')             RES_BATCH_BOOKING
  , (
        SELECT DISTINCT meaning
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'SERVICE_LEVEL'
            AND payment_code                  = PM.service_level_code ) RES_SERVICE_LEVEL
  /*, (SELECT DISTINCT trim(TerritoryPEO.Territory_Short_Name
                ||' '
                ||PaymentCodeEO.MEANING)
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
          , FND_TERRITORIES_VL TerritoryPEO
        WHERE PaymentCodeEO.TERRITORY_CODE = TerritoryPEO.TERRITORY_CODE(+)
		AND PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL*/
  ,(SELECT DISTINCT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL_NAME
  ,(SELECT DISTINCT PaymentCodeEO.PAYMENT_CODE 
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'DELIVERY_CHANNEL'
        AND payment_code = pm.delivery_channel_code 
	) RES_DELIVERY_CHANNEL_CODE
  , (
        SELECT DISTINCT(currency_code
                ||' - '
                ||name)
        FROM FND_CURRENCIES_TL
        WHERE currency_code = rul.max_amount_per_instr_curr_code
		AND LANGUAGE = USERENV('LANG')
		) RES_CURRENCY
  , rul.max_amount_per_instr_value                                 RES_CURRENCY_AMOUNT
  , rul.max_payments_per_instruction                               RES_NUMBER_OF_PAYMENTS
  , (
        SELECT GlDailyConversionTypes.USER_CONVERSION_TYPE
        FROM GL_DAILY_CONVERSION_TYPES GlDailyConversionTypes
        WHERE GlDailyConversionTypes.CONVERSION_TYPE = rul.max_amount_fx_rate_type ) RES_CONVERSION_RATE_TYPE
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_1 ) RES_FIRST_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_1 ) RES_FIRST_SORT_ORDER
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_2 ) RES_SECOND_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_2 ) RES_SECOND_SORT_ORDER
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_OPTIONS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_option_3 ) RES_THIRD_SORT
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.LOOKUP_TYPE   = 'IBY_PAYMENT_SORT_ORDERS'
            AND LookupPEO.LOOKUP_CODE = rul.sort_order_3 ) RES_THIRD_SORT_ORDER
  , (
        SELECT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'BANK_INSTRUCTION'
            AND PaymentCodeEO.PAYMENT_CODE    = PM.BANK_INSTRUCTION1_CODE ) RES_BANK_INSTRUCTION_1
  , (
        SELECT PaymentCodeEO.MEANING
        FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
        WHERE PaymentCodeEO.PAYMENT_CODE_TYPE = 'BANK_INSTRUCTION'
            AND PaymentCodeEO.PAYMENT_CODE    = PM.BANK_INSTRUCTION2_CODE )    RES_BANK_INSTRUCTION_2
  , PM.BANK_INSTRUCTION_DETAILS                                                RES_BANK_INSTRUCTION_DETAILS
  , PM.PAYMENT_TEXT_MESSAGE1                                                   RES_PAYMENT_TEXT_MESSAGE_1
  , PM.PAYMENT_TEXT_MESSAGE2                                                   RES_PAYMENT_TEXT_MESSAGE_2
  , IbySysPmtProfilesVl.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , IbySysPmtProfilesVl.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , IbySysPmtProfilesVl.CREATED_BY  RSC_CREATED_BY
  , IbySysPmtProfilesVl.CREATION_DATE  RSC_CREATION_DATE
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
, IBY_INSTR_CREATION_RULES Rul
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE   = PM.SYSTEM_PROFILE_CODE(+)
AND IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = Rul.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
--ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME