/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PO_HEADERS_ALL

SELECT (SELECT DISPLAY_NAME
	FROM PO_DOC_STYLE_LINES_TL
	WHERE STYLE_ID = poHeadersE0.STYLE_ID 
	AND DOCUMENT_SUBTYPE = poHeadersE0.TYPE_LOOKUP_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_STYLE
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = poHeadersE0.PRC_BU_ID
	) RES_PROCUREMENT_BU
,poHeadersE0.SEGMENT1 RES_AGREEMENT
,(SELECT DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES
	WHERE LOOKUP_TYPE = 'AGREEMENT_STATUS'
	AND LOOKUP_CODE = poHeadersE0.DOCUMENT_STATUS
	) RES_STATUS
,(SELECT LIST_NAME
	FROM PER_PERSON_NAMES_F
	WHERE PERSON_ID = poHeadersE0.AGENT_ID
	AND NAME_TYPE = 'GLOBAL'
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
	) RES_BUYER
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = SuppliersE0.PARTY_ID
	) RES_SUPPLIER
,SuppliersE0.SEGMENT1 RES_SUPPLIER_NUMBER
,(SELECT VENDOR_SITE_CODE
	FROM POZ_SUPPLIER_SITES_ALL_M
	WHERE VENDOR_SITE_ID = poHeadersE0.VENDOR_SITE_ID
	) RES_SUPPLIER_SITE
,(SELECT P.PARTY_NAME
	FROM POZ_SUPPLIER_CONTACTS SC
	,HZ_PARTIES P
	WHERE SC.PER_PARTY_ID = P.PARTY_ID
	AND SC.VENDOR_CONTACT_ID = poHeadersE0.VENDOR_CONTACT_ID
	) RES_SUPPLIER_CONTACT
,(SELECT DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES
	WHERE LOOKUP_TYPE = 'DOCUMENT_COMMUNICATION_METHOD'
	AND LOOKUP_CODE = poHeadersE0.SUPPLIER_NOTIF_METHOD
	) RES_COMMUNICATION_METHOD
,DECODE(poHeadersE0.SUPPLIER_NOTIF_METHOD,'EMAIL',poHeadersE0.EMAIL_ADDRESS) RES_EMAIL
,DECODE(poHeadersE0.SUPPLIER_NOTIF_METHOD,'FAX',poHeadersE0.FAX) RES_FAX
,TO_CHAR(poHeadersE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(poHeadersE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,poHeadersE0.CURRENCY_CODE RES_CURRENCY
,poHeadersE0.BLANKET_TOTAL_AMOUNT RES_AGREEMENT_AMOUNT
,poHeadersE0.AMOUNT_LIMIT RES_AMOUNT_LIMIT
,poHeadersE0.MIN_RELEASE_AMOUNT RES_MINIMUM_RELEASE_AMOUNT
,poHeadersE0.COMMENTS RES_DESCRIPTION
,(SELECT DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES
	WHERE LOOKUP_TYPE = 'ACCEPTANCE_REQUIRED'
	AND LOOKUP_CODE = poHeadersE0.ACCEPTANCE_REQUIRED_FLAG
	) RES_REQUIRED_ACKNOWLEDGMENT
,poHeadersE0.ACCEPTANCE_WITHIN_DAYS RES_ACKNOWLEDGE_WITHIN_DAYS
,(SELECT NAME 
	FROM AP_TERMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERM_ID = poHeadersE0.TERMS_ID
	) RES_PAYMENT_TERMS
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = poHeadersE0.CARRIER_ID
	) RES_SHIPPING_METHOD
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FREIGHT TERMS'
	AND LOOKUP_CODE = poHeadersE0.FREIGHT_TERMS_LOOKUP_CODE
	) RES_FREIGHT_TERMS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'FOB'
	AND LOOKUP_CODE = poHeadersE0.FOB_LOOKUP_CODE
	) RES_FOB
,DECODE(poHeadersE0.SIGNATURE_REQUIRED_FLAG,'Y','Yes','No') RES_REQUIRES_SIGNATURE
,DECODE(poHeadersE0.BUYER_MANAGED_TRANSPORT_FLAG,'Y','Yes','No') RES_BUYER_MANAGED_TRANSPORTATI
,DECODE(poHeadersE0.PAY_ON_CODE,'RECEIPT','Yes','No') RES_PAY_ON_RECEIPT
,DECODE(poHeadersE0.CONFIRMING_ORDER_FLAG,'Y','Yes','No') RES_CONFIRMING_ORDER
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'AGING_ONSET_POINT'
	AND LOOKUP_CODE = poHeadersE0.AGING_ONSET_POINT
	) RES_AGING_ONSET_POINT
,poHeadersE0.AGING_PERIOD_DAYS RES_AGING_PERIOD_DAYS
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CONSUMPTION_ADVICE_FREQUENCY'
	AND LOOKUP_CODE = poHeadersE0.CONSUMPTION_ADVICE_FREQUENCY
	) RES_CONSUMPTION_ADVICE_FREQUEN
,TO_CHAR(poHeadersE0.BILLING_CYCLE_CLOSING_DATE,'DD-Mon-YYYY') RES_BILLING_CYCLE_CLOSING_DATE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CONSUMPTION_ADVICE_SUMMARY'
	AND LOOKUP_CODE = poHeadersE0.CONSUMPTION_ADVICE_SUMMARY
	) RES_CONSUMPTION_ADVICE_SUMMARY
,DECODE(poHeadersE0.PAY_ON_USE_FLAG,'Y','Yes','No') RES_PAY_ON_USE
,DECODE(poHeadersE0.DEFAULT_CONSIGNMENT_LINE_FLAG,'Y','Yes','No') RES_DEFAULT_LINE_AS_CONSIGNMEN
,poHeadersE0.NOTE_TO_VENDOR RES_NOTE_TO_SUPPLIER
,poHeadersE0.NOTE_TO_RECEIVER RES_NOTE_TO_RECEIVER
,poHeadersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,poHeadersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,poHeadersE0.CREATED_BY RSC_CREATED_BY
,poHeadersE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,poHeadersE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PO_HEADERS_ALL poHeadersE0
,POZ_SUPPLIERS suppliersE0
WHERE poHeadersE0.VENDOR_ID = suppliersE0.VENDOR_ID(+)
AND poHeadersE0.TYPE_LOOKUP_CODE IN ('BLANKET','CONTRACT')
ORDER BY 2,poHeadersE0.SEGMENT1