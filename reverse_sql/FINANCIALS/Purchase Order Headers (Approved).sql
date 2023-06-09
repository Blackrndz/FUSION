/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- STRICTLY_BATCH_SEQ = RES_INTERFACE_HEADER_KEY

SELECT PoHeadersE0.PO_HEADER_ID RES_INTERFACE_HEADER_KEY
,NULL RES_ACTION
,NULL RES_BATCH_ID
,NULL RES_IMPORT_SOURCE
,'BYPASS' RES_APPROVAL_ACTION
,PoHeadersE0.SEGMENT1 RES_ORDER
,PoHeadersE0.TYPE_LOOKUP_CODE RES_DOCUMENT_TYPE_CODE
,(SELECT DISPLAY_NAME
	FROM PO_DOC_STYLE_LINES_TL
	WHERE STYLE_ID = PoHeadersE0.STYLE_ID 
	AND DOCUMENT_SUBTYPE = PoHeadersE0.TYPE_LOOKUP_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_STYLE
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = PoHeadersE0.PRC_BU_ID
	) RES_PROCUREMENT_BU
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = PoHeadersE0.REQ_BU_ID
	) RES_REQUISITIONING_BU
,(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = PoHeadersE0.SOLDTO_LE_ID
	) RES_SOLD_TO_LEGAL_ENTITY
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = PoHeadersE0.BILLTO_BU_ID
	) RES_BILL_TO_BU
,(SELECT FULL_NAME
	FROM PER_PERSON_NAMES_F
	WHERE PERSON_ID = PoHeadersE0.AGENT_ID
	AND NAME_TYPE = 'GLOBAL'
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_BUYER
,PoHeadersE0.CURRENCY_CODE RES_CURRENCY_CODE
,PoHeadersE0.RATE RES_RATE
,PoHeadersE0.RATE_TYPE RES_RATE_TYPE
,TO_CHAR(PoHeadersE0.RATE_DATE,'YYYY/MM/DD') RES_RATE_DATE
,PoHeadersE0.COMMENTS RES_DESCRIPTION
,(SELECT LOCATION_NAME
	FROM PER_LOCATION_DETAILS_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND LOCATION_ID = PoHeadersE0.BILL_TO_LOCATION_ID
	) RES_BILL_TO_LOCATION
,(SELECT LOCATION_NAME
	FROM PER_LOCATION_DETAILS_F_VL
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND LOCATION_ID = PoHeadersE0.SHIP_TO_LOCATION_ID
	) RES_SHIP_TO_LOCATION
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = SuppliersE0.PARTY_ID
	) RES_SUPPLIER
,SuppliersE0.SEGMENT1 RES_SUPPLIER_NUMBER
,(SELECT VENDOR_SITE_CODE
	FROM POZ_SUPPLIER_SITES_ALL_M
	WHERE VENDOR_SITE_ID = PoHeadersE0.VENDOR_SITE_ID
	) RES_SUPPLIER_SITE
,(SELECT ptyE0.PARTY_NAME
	FROM POZ_SUPPLIER_CONTACTS supContactsE0
	,HZ_PARTIES ptyE0
	WHERE supContactsE0.PER_PARTY_ID = ptyE0.PARTY_ID
	AND supContactsE0.VENDOR_CONTACT_ID = PoHeadersE0.VENDOR_CONTACT_ID
	) RES_SUPPLIER_CONTACT
,PoHeadersE0.VENDOR_ORDER_NUM RES_SUPPLIER_ORDER
,PoHeadersE0.FOB_LOOKUP_CODE RES_FOB
,(SELECT PARTY_NAME
	FROM HZ_PARTIES
	WHERE PARTY_ID = PoHeadersE0.CARRIER_ID
	) RES_CARRIER
,PoHeadersE0.FREIGHT_TERMS_LOOKUP_CODE RES_FREIGHT_TERMS
,PoHeadersE0.PAY_ON_CODE RES_PAY_ON_CODE
,(SELECT NAME 
	FROM AP_TERMS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERM_ID = PoHeadersE0.TERMS_ID
	) RES_PAYMENT_TERMS
,NULL RES_INITIATING_PARTY
,PoHeadersE0.CHANGE_SUMMARY RES_CHANGE_ORDER_DESCRIPTION
,PoHeadersE0.ACCEPTANCE_REQUIRED_FLAG RES_REQUIRED_ACKNOWLEDGMENT
,PoHeadersE0.ACCEPTANCE_WITHIN_DAYS RES_ACKNOWLEDGE_WITHIN_DAYS
,PoHeadersE0.SUPPLIER_NOTIF_METHOD RES_COMMUNICATION_METHOD
,PoHeadersE0.FAX RES_FAX
,PoHeadersE0.EMAIL_ADDRESS RES_E_MAIL
,PoHeadersE0.CONFIRMING_ORDER_FLAG RES_CONFIRMING_ORDER
,PoHeadersE0.NOTE_TO_VENDOR RES_NOTE_TO_SUPPLIER
,PoHeadersE0.NOTE_TO_RECEIVER RES_NOTE_TO_RECEIVER
,PoHeadersE0.DEFAULT_TAXATION_COUNTRY RES_DEFAULT_TAXATION_COUNTRY_C
,PoHeadersE0.TAX_DOCUMENT_SUBTYPE RES_TAX_DOCUMENT_SUBTYPE_CODE
,PoHeadersE0.ATTRIBUTE_CATEGORY RES_ATTRIBUTE_CATEGORY
,PoHeadersE0.ATTRIBUTE1 RES_ATTRIBUTE1
,PoHeadersE0.ATTRIBUTE2 RES_ATTRIBUTE2
,PoHeadersE0.ATTRIBUTE3 RES_ATTRIBUTE3
,PoHeadersE0.ATTRIBUTE4 RES_ATTRIBUTE4
,PoHeadersE0.ATTRIBUTE5 RES_ATTRIBUTE5
,PoHeadersE0.ATTRIBUTE6 RES_ATTRIBUTE6
,PoHeadersE0.ATTRIBUTE7 RES_ATTRIBUTE7
,PoHeadersE0.ATTRIBUTE8 RES_ATTRIBUTE8
,PoHeadersE0.ATTRIBUTE9 RES_ATTRIBUTE9
,PoHeadersE0.ATTRIBUTE10 RES_ATTRIBUTE10
,PoHeadersE0.ATTRIBUTE11 RES_ATTRIBUTE11
,PoHeadersE0.ATTRIBUTE12 RES_ATTRIBUTE12
,PoHeadersE0.ATTRIBUTE13 RES_ATTRIBUTE13
,PoHeadersE0.ATTRIBUTE14 RES_ATTRIBUTE14
,PoHeadersE0.ATTRIBUTE15 RES_ATTRIBUTE15
,PoHeadersE0.ATTRIBUTE16 RES_ATTRIBUTE16
,PoHeadersE0.ATTRIBUTE17 RES_ATTRIBUTE17
,PoHeadersE0.ATTRIBUTE18 RES_ATTRIBUTE18
,PoHeadersE0.ATTRIBUTE19 RES_ATTRIBUTE19
,PoHeadersE0.ATTRIBUTE20 RES_ATTRIBUTE20
,PoHeadersE0.ATTRIBUTE_DATE1 RES_ATTRIBUTE_DATE1
,PoHeadersE0.ATTRIBUTE_DATE2 RES_ATTRIBUTE_DATE2
,PoHeadersE0.ATTRIBUTE_DATE3 RES_ATTRIBUTE_DATE3
,PoHeadersE0.ATTRIBUTE_DATE4 RES_ATTRIBUTE_DATE4
,PoHeadersE0.ATTRIBUTE_DATE5 RES_ATTRIBUTE_DATE5
,PoHeadersE0.ATTRIBUTE_DATE6 RES_ATTRIBUTE_DATE6
,PoHeadersE0.ATTRIBUTE_DATE7 RES_ATTRIBUTE_DATE7
,PoHeadersE0.ATTRIBUTE_DATE8 RES_ATTRIBUTE_DATE8
,PoHeadersE0.ATTRIBUTE_DATE9 RES_ATTRIBUTE_DATE9
,PoHeadersE0.ATTRIBUTE_DATE10 RES_ATTRIBUTE_DATE10
,PoHeadersE0.ATTRIBUTE_NUMBER1 RES_ATTRIBUTE_NUMBER1
,PoHeadersE0.ATTRIBUTE_NUMBER2 RES_ATTRIBUTE_NUMBER2
,PoHeadersE0.ATTRIBUTE_NUMBER3 RES_ATTRIBUTE_NUMBER3
,PoHeadersE0.ATTRIBUTE_NUMBER4 RES_ATTRIBUTE_NUMBER4
,PoHeadersE0.ATTRIBUTE_NUMBER5 RES_ATTRIBUTE_NUMBER5
,PoHeadersE0.ATTRIBUTE_NUMBER6 RES_ATTRIBUTE_NUMBER6
,PoHeadersE0.ATTRIBUTE_NUMBER7 RES_ATTRIBUTE_NUMBER7
,PoHeadersE0.ATTRIBUTE_NUMBER8 RES_ATTRIBUTE_NUMBER8
,PoHeadersE0.ATTRIBUTE_NUMBER9 RES_ATTRIBUTE_NUMBER9
,PoHeadersE0.ATTRIBUTE_NUMBER10 RES_ATTRIBUTE_NUMBER10
,PoHeadersE0.ATTRIBUTE_TIMESTAMP1 RES_ATTRIBUTE_TIMESTAMP1
,PoHeadersE0.ATTRIBUTE_TIMESTAMP2 RES_ATTRIBUTE_TIMESTAMP2
,PoHeadersE0.ATTRIBUTE_TIMESTAMP3 RES_ATTRIBUTE_TIMESTAMP3
,PoHeadersE0.ATTRIBUTE_TIMESTAMP4 RES_ATTRIBUTE_TIMESTAMP4
,PoHeadersE0.ATTRIBUTE_TIMESTAMP5 RES_ATTRIBUTE_TIMESTAMP5
,PoHeadersE0.ATTRIBUTE_TIMESTAMP6 RES_ATTRIBUTE_TIMESTAMP6
,PoHeadersE0.ATTRIBUTE_TIMESTAMP7 RES_ATTRIBUTE_TIMESTAMP7
,PoHeadersE0.ATTRIBUTE_TIMESTAMP8 RES_ATTRIBUTE_TIMESTAMP8
,PoHeadersE0.ATTRIBUTE_TIMESTAMP9 RES_ATTRIBUTE_TIMESTAMP9
,PoHeadersE0.ATTRIBUTE_TIMESTAMP10 RES_ATTRIBUTE_TIMESTAMP10
,(SELECT emailsE0.EMAIL_ADDRESS
	FROM PER_EMAIL_ADDRESSES emailsE0
	,PER_ALL_PEOPLE_F peoplesE0
	WHERE SYSDATE BETWEEN peoplesE0.EFFECTIVE_START_DATE AND peoplesE0.EFFECTIVE_END_DATE
	AND peoplesE0.PERSON_ID = PoHeadersE0.AGENT_ID
	AND peoplesE0.PRIMARY_EMAIL_ID = emailsE0.EMAIL_ADDRESS_ID
	) RES_BUYER_E_MAIL
,PoHeadersE0.MODE_OF_TRANSPORT RES_MODE_OF_TRANSPORT
,PoHeadersE0.SERVICE_LEVEL RES_SERVICE_LEVEL
,(SELECT REGISTRATION_NUMBER
	FROM ZX_REGISTRATIONS
	WHERE REGISTRATION_ID = PoHeadersE0.FIRST_PTY_REG_ID
	) RES_FIRST_PARTY_TAX_REGISTRATI
,(SELECT REGISTRATION_NUMBER
	FROM ZX_REGISTRATIONS
	WHERE REGISTRATION_ID = PoHeadersE0.THIRD_PTY_REG_ID
	) RES_THIRD_PARTY_TAX_REGISTRATI
,PoHeadersE0.BUYER_MANAGED_TRANSPORT_FLAG RES_BUYER_MANAGED_TRANSPORTATI
,PoHeadersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PoHeadersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PoHeadersE0.CREATED_BY RSC_CREATED_BY
,PoHeadersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,PoHeadersE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_HEADERS_ALL PoHeadersE0
,POZ_SUPPLIERS SuppliersE0
WHERE PoHeadersE0.VENDOR_ID = SuppliersE0.VENDOR_ID(+)
AND EXISTS (SELECT 1 
	FROM PO_LINES_ALL 
	WHERE PO_HEADER_ID = PoHeadersE0.PO_HEADER_ID 
	AND LINE_STATUS = 'OPEN' )
AND NVL(PoHeadersE0.APPROVED_FLAG,'N') = 'Y'
AND PoHeadersE0.TYPE_LOOKUP_CODE = 'STANDARD' --Only PO
AND PoHeadersE0.DOCUMENT_STATUS = 'OPEN' --PO Header status