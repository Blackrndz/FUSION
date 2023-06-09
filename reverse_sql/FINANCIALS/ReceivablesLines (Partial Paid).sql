/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Specify%20Supplier%20Numbering%20-%20Specify%20Supplier%20Numbering.sql $:
 * $Id: Specify Supplier Numbering - Specify Supplier Numbering.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT * FROM
(SELECT BU.SHORT_CODE RES_BUSINESS_UNIT_IDENTIFIER
,BU.BU_NAME RES_BUSINESS_UNIT_NAME
,(SELECT NAME
	FROM RA_BATCH_SOURCES_ALL
	WHERE BATCH_SOURCE_SEQ_ID = RA_H.BATCH_SOURCE_SEQ_ID
	) RES_TRANSACTION_BATCH_SOURCE_N
,(SELECT NAME 
	FROM RA_CUST_TRX_TYPES_ALL
	WHERE CUST_TRX_TYPE_SEQ_ID = RA_H.CUST_TRX_TYPE_SEQ_ID
	) RES_TRANSACTION_TYPE_NAME
,(SELECT NAME
	FROM RA_TERMS_TL
	WHERE TERM_ID = RA_H.TERM_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_PAYMENT_TERMS
,TO_CHAR(RA_H.TRX_DATE,'YYYY/MM/DD') RES_TRANSACTION_DATE
,TO_CHAR(ArPaymentSchedulsAllE0.GL_DATE,'YYYY/MM/DD') RES_ACCOUNTING_DATE
,RA_H.TRX_NUMBER RES_TRANSACTION_NUMBER
,NULL RES_ORIGINAL_SYSTEM_BILL_TO_CU -- Original System Bill-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_BILL_TO__0 -- Original System Bill-to Customer Address Reference
,NULL RES_ORIGINAL_SYSTEM_BILL_TO__1 -- Original System Bill-to Customer Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO_CU -- Original System Ship-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__2 -- Original System Ship-to Customer Address Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__3 -- Original System Ship-to Customer Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__4 -- Original System Ship-to Customer Account Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__5 -- Original System Ship-to Customer Account Address Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__6 -- Original System Ship-to Customer Account Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SOLD_TO_CU -- Original System Sold-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_SOLD_TO__7 -- Original System Sold-to Customer Account Reference
,RAC_BILL.ACCOUNT_NUMBER RES_BILL_TO_CUSTOMER_ACCOUNT_N
,RAA_BILL_PS.PARTY_SITE_NUMBER RES_BILL_TO_CUSTOMER_SITE_NUMB 
,(SELECT HzOrgContactsE0.CONTACT_NUMBER
	FROM HZ_CUST_ACCOUNT_ROLES RACO_BILL
	,HZ_ORG_CONTACTS HzOrgContactsE0
	WHERE RA_H.BILL_TO_CONTACT_ID = RACO_BILL.CUST_ACCOUNT_ROLE_ID
	AND RACO_BILL.RELATIONSHIP_ID = HzOrgContactsE0.PARTY_RELATIONSHIP_ID
	) RES_BILL_TO_CONTACT_PARTY_NUMB 
,RAC_SHIP.ACCOUNT_NUMBER RES_SHIP_TO_CUSTOMER_ACCOUNT_N 
,(SELECT RAA_SHIP_PS.PARTY_SITE_NUMBER
	FROM HZ_CUST_SITE_USES_ALL SU_SHIP
	,HZ_CUST_ACCT_SITES_ALL RAA_SHIP
	,HZ_PARTY_SITES RAA_SHIP_PS
	WHERE RA_H.SHIP_TO_SITE_USE_ID = SU_SHIP.SITE_USE_ID
	AND SU_SHIP.CUST_ACCT_SITE_ID = RAA_SHIP.CUST_ACCT_SITE_ID
	AND RAA_SHIP.PARTY_SITE_ID = RAA_SHIP_PS.PARTY_SITE_ID
	) RES_SHIP_TO_CUSTOMER_SITE_NUMB
,(SELECT HzOrgContactsE0.CONTACT_NUMBER
	FROM HZ_CUST_ACCOUNT_ROLES RACO_BILL
	,HZ_ORG_CONTACTS HzOrgContactsE0
	WHERE RA_H.SHIP_TO_CONTACT_ID = RACO_BILL.CUST_ACCOUNT_ROLE_ID
	AND RACO_BILL.RELATIONSHIP_ID = HzOrgContactsE0.PARTY_RELATIONSHIP_ID
	) RES_SHIP_TO_CONTACT_PARTY_NUMB 
,RAC_SOLD.ACCOUNT_NUMBER RES_SOLD_TO_CUSTOMER_ACCOUNT_N 
,RA_L.LINE_TYPE RES_TRANSACTION_LINE_TYPE
,RA_L.DESCRIPTION RES_TRANSACTION_LINE_DESCRIPTI
,RA_H.INVOICE_CURRENCY_CODE RES_CURRENCY_CODE
,(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = RA_H.EXCHANGE_RATE_TYPE
	) RES_CURRENCY_CONVERSION_TYPE
,TO_CHAR(RA_H.EXCHANGE_DATE,'DD-Mon-YYYY') RES_CURRENCY_CONVERSION_DATE
,ROUND(RA_H.EXCHANGE_RATE,5) RES_CURRENCY_CONVERSION_RATE
--,RA_L.UNIT_SELLING_PRICE RES_TRANSACTION_LINE_AMOUNT
,RA_L.EXTENDED_AMOUNT RES_TRANSACTION_LINE_AMOUNT
,RA_L.QUANTITY_ORDERED RES_TRANSACTION_LINE_QUANTITY
,RA_L.QUANTITY_INVOICED RES_CUSTOMER_ORDERED_QUANTITY
,RA_L.UNIT_SELLING_PRICE RES_UNIT_SELLING_PRICE
,RA_L.UNIT_STANDARD_PRICE RES_UNIT_STANDARD_PRICE
,RA_L.INTERFACE_LINE_CONTEXT RES_LINE_TRANSACTIONS_FLEXFIEL
,NVL(RA_L.INTERFACE_LINE_ATTRIBUTE1,RA_H.TRX_NUMBER) RES_LINE_TRANSACTIONS_FLEXFI_8
,NVL(RA_L.INTERFACE_LINE_ATTRIBUTE2,RA_L.LINE_NUMBER) RES_LINE_TRANSACTIONS_FLEXFI_9
,RA_L.INTERFACE_LINE_ATTRIBUTE3 RES_LINE_TRANSACTIONS_FLEXF_10
,RA_L.INTERFACE_LINE_ATTRIBUTE4 RES_LINE_TRANSACTIONS_FLEXF_11
,RA_L.INTERFACE_LINE_ATTRIBUTE5 RES_LINE_TRANSACTIONS_FLEXF_12
,RA_L.INTERFACE_LINE_ATTRIBUTE6 RES_LINE_TRANSACTIONS_FLEXF_13
,RA_L.INTERFACE_LINE_ATTRIBUTE7 RES_LINE_TRANSACTIONS_FLEXF_14
,RA_L.INTERFACE_LINE_ATTRIBUTE8 RES_LINE_TRANSACTIONS_FLEXF_15
,RA_L.INTERFACE_LINE_ATTRIBUTE9 RES_LINE_TRANSACTIONS_FLEXF_16
,RA_L.CUSTOMER_TRX_ID RES_LINE_TRANSACTIONS_FLEXF_17
,RA_L.CUSTOMER_TRX_LINE_ID RES_LINE_TRANSACTIONS_FLEXF_18
,RA_L.INTERFACE_LINE_ATTRIBUTE12 RES_LINE_TRANSACTIONS_FLEXF_19
,RA_L.INTERFACE_LINE_ATTRIBUTE13 RES_LINE_TRANSACTIONS_FLEXF_20
,RA_L.INTERFACE_LINE_ATTRIBUTE14 RES_LINE_TRANSACTIONS_FLEXF_21
,RA_L.INTERFACE_LINE_ATTRIBUTE15 RES_LINE_TRANSACTIONS_FLEXF_22
,(SELECT SalesE0.SALESREP_NUMBER
	FROM JTF_RS_SALESREPS SalesE0
	WHERE SalesE0.RESOURCE_SALESREP_ID = RA_H.PRIMARY_RESOURCE_SALESREP_ID
	) RES_PRIMARY_SALESPERSON_NUMBER
,RA_L.TAX_CLASSIFICATION_CODE RES_TAX_CLASSIFICATION_CODE
,(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = RA_H.LEGAL_ENTITY_ID
	) RES_LEGAL_ENTITY_IDENTIFIER
,NULL RES_ACCOUNTED_AMOUNT_IN_LEDGER
,RA_L.SALES_ORDER RES_SALES_ORDER_NUMBER
,TO_CHAR(RA_L.SALES_ORDER_DATE,'YYYY/MM/DD') RES_SALES_ORDER_DATE
,TO_CHAR(RA_H.SHIP_DATE_ACTUAL,'YYYY/MM/DD') RES_ACTUAL_SHIP_DATE
,(SELECT ORGANIZATION_CODE  
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = RA_L.WAREHOUSE_ID
	) RES_WAREHOUSE_CODE --TRANSLATE
,RA_L.UOM_CODE RES_UNIT_OF_MEASURE_CODE
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = RA_L.UOM_CODE
	) RES_UNIT_OF_MEASURE_NAME
,(SELECT NAME 
	 FROM RA_RULES
	 WHERE RULE_ID = RA_H.INVOICING_RULE_ID
	 ) RES_INVOICING_RULE_NAME
,(SELECT NAME
	FROM RA_RULES
	WHERE RULE_ID = RA_L.ACCOUNTING_RULE_ID
	) RES_REVENUE_SCHEDULING_RULE_NA
,RA_L.ACCOUNTING_RULE_DURATION RES_NUMBER_OF_REVENUE_PERIODS
,TO_CHAR(RA_L.RULE_START_DATE,'YYYY/MM/DD') RES_REVENUE_SCHEDULING_RULE_ST
,TO_CHAR(RA_L.RULE_END_DATE,'YYYY/MM/DD') RES_REVENUE_SCHEDULING_RULE_EN
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'CREDIT_MEMO_REASON'
	AND LOOKUP_CODE = RA_L.REASON_CODE
	) RES_REASON_CODE_MEANING
,RA_L.LAST_PERIOD_TO_CREDIT RES_LAST_PERIOD_TO_CREDIT
,RA_L.TRX_BUSINESS_CATEGORY RES_TRANSACTION_BUSINESS_CATEG
,RA_L.PRODUCT_FISC_CLASSIFICATION RES_PRODUCT_FISCAL_CLASSIFICAT
,RA_L.PRODUCT_CATEGORY RES_PRODUCT_CATEGORY_CODE
,RA_L.PRODUCT_TYPE RES_PRODUCT_TYPE
,RA_L.LINE_INTENDED_USE RES_LINE_INTENDED_USE_CODE 
,RA_L.ASSESSABLE_VALUE RES_ASSESSABLE_VALUE
,RA_H.DOCUMENT_SUB_TYPE RES_DOCUMENT_SUB_TYPE
,RA_H.DEFAULT_TAXATION_COUNTRY RES_DEFAULT_TAXATION_COUNTRY
,RA_L.USER_DEFINED_FISC_CLASS RES_USER_DEFINED_FISCAL_CLASSI
,RA_L.TAX_INVOICE_NUMBER RES_TAX_INVOICE_NUMBER
,TO_CHAR(RA_L.TAX_INVOICE_DATE,'YYYY/MM/DD') RES_TAX_INVOICE_DATE
,NULL RES_TAX_REGIME_CODE
,NULL RES_TAX
,NULL RES_TAX_STATUS_CODE
,NULL RES_TAX_RATE_CODE
,NULL RES_TAX_JURISDICTION_CODE
,(SELECT REGISTRATION_NUMBER
	FROM ZX_REGISTRATIONS
	WHERE REGISTRATION_ID = RA_H.FIRST_PTY_REG_ID
	) RES_FIRST_PARTY_REGISTRATION_N
,(SELECT REGISTRATION_NUMBER
	FROM ZX_REGISTRATIONS
	WHERE REGISTRATION_ID = RA_H.THIRD_PTY_REG_ID
	) RES_THIRD_PARTY_REGISTRATION_N
,RA_L.FINAL_DISCHARGE_LOCATION_ID RES_FINAL_DISCHARGE_LOCATION --Translate
,(SELECT SUM(EXTENDED_AMOUNT)
	FROM RA_CUSTOMER_TRX_LINES_ALL
	WHERE LINE_TYPE = 'TAX'
	AND LINK_TO_CUST_TRX_LINE_ID = RA_L.CUSTOMER_TRX_LINE_ID
	) RES_TAXABLE_AMOUNT
,DECODE(RA_L.EXTENDED_AMOUNT,NULL,'N','Y') RES_TAXABLE_FLAG
--,RA_L.TAXABLE_AMOUNT RES_TAXABLE_AMOUNT
--,RA_L.TAXABLE_FLAG RES_TAXABLE_FLAG
,RA_L.TAX_EXEMPT_FLAG RES_TAX_EXEMPTION_FLAG
,RA_L.TAX_EXEMPT_REASON_CODE RES_TAX_EXEMPTION_REASON_CODE
,NULL RES_TAX_EXEMPTION_REASON_CODE_ -- Translate
,RA_L.TAX_EXEMPT_NUMBER RES_TAX_EXEMPTION_CERTIFICATE_
,RA_L.AMOUNT_INCLUDES_TAX_FLAG RES_LINE_AMOUNT_INCLUDES_TAX_F
,RA_L.TAX_PRECEDENCE RES_TAX_PRECEDENCE
,NULL RES_CREDIT_METHOD_TO_BE_USED_F
,NULL RES_CREDIT_METHOD_TO_BE_USE_23
,RA_L.REASON_CODE RES_REASON_CODE
,RA_L.TAX_RATE RES_TAX_RATE
,RA_H.FOB_POINT RES_FOB_POINT
,NULL RES_CARRIER
,NULL RES_SHIPPING_REFERENCE
,RA_L.SALES_ORDER_LINE RES_SALES_ORDER_LINE_NUMBER
,RA_L.SALES_ORDER_SOURCE RES_SALES_ORDER_SOURCE
,RA_L.SALES_ORDER_REVISION RES_SALES_ORDER_REVISION_NUMBE
,RA_H.PURCHASE_ORDER RES_PURCHASE_ORDER_NUMBER
,RA_H.PURCHASE_ORDER_REVISION RES_PURCHASE_ORDER_REVISION_NU
,TO_CHAR(RA_H.PURCHASE_ORDER_DATE,'YYYY/MM/DD') RES_PURCHASE_ORDER_DATE
,(SELECT AGREEMENT_NAME 
	FROM ZCA_AGREEMENT
	WHERE AGREEMENT_ID = RA_H.AGREEMENT_ID
	) RES_AGREEMENT_NAME
,NULL RES_MEMO_LINE_NAME
,RA_H.DOC_SEQUENCE_VALUE RES_DOCUMENT_NUMBER
,NULL RES_ORIGINAL_SYSTEM_BATCH_NAME
,RA_LINKTO.ATTRIBUTE_CATEGORY RES_LINK_TO_TRANSACTIONS_FLEXF
,RA_LINKTO.ATTRIBUTE1 RES_LINK_TO_TRANSACTIONS_FL_24
,RA_LINKTO.ATTRIBUTE2 RES_LINK_TO_TRANSACTIONS_FL_25
,RA_LINKTO.ATTRIBUTE3 RES_LINK_TO_TRANSACTIONS_FL_26
,RA_LINKTO.ATTRIBUTE4 RES_LINK_TO_TRANSACTIONS_FL_27
,RA_LINKTO.ATTRIBUTE5 RES_LINK_TO_TRANSACTIONS_FL_28
,RA_LINKTO.ATTRIBUTE6 RES_LINK_TO_TRANSACTIONS_FL_29
,RA_LINKTO.ATTRIBUTE7 RES_LINK_TO_TRANSACTIONS_FL_30
,RA_LINKTO.ATTRIBUTE8 RES_LINK_TO_TRANSACTIONS_FL_31
,RA_LINKTO.ATTRIBUTE9 RES_LINK_TO_TRANSACTIONS_FL_32
,RA_LINKTO.ATTRIBUTE10 RES_LINK_TO_TRANSACTIONS_FL_33
,RA_LINKTO.ATTRIBUTE11 RES_LINK_TO_TRANSACTIONS_FL_34
,RA_LINKTO.ATTRIBUTE12 RES_LINK_TO_TRANSACTIONS_FL_35
,RA_LINKTO.ATTRIBUTE13 RES_LINK_TO_TRANSACTIONS_FL_36
,RA_LINKTO.ATTRIBUTE14 RES_LINK_TO_TRANSACTIONS_FL_37
,RA_LINKTO.ATTRIBUTE15 RES_LINK_TO_TRANSACTIONS_FL_38
,NULL RES_REFERENCE_TRANSACTIONS_FLE
,NULL RES_REFERENCE_TRANSACTIONS__39
,NULL RES_REFERENCE_TRANSACTIONS__40
,NULL RES_REFERENCE_TRANSACTIONS__41
,NULL RES_REFERENCE_TRANSACTIONS__42
,NULL RES_REFERENCE_TRANSACTIONS__43
,NULL RES_REFERENCE_TRANSACTIONS__44
,NULL RES_REFERENCE_TRANSACTIONS__45
,NULL RES_REFERENCE_TRANSACTIONS__46
,NULL RES_REFERENCE_TRANSACTIONS__47
,NULL RES_REFERENCE_TRANSACTIONS__48
,NULL RES_REFERENCE_TRANSACTIONS__49
,NULL RES_REFERENCE_TRANSACTIONS__50
,NULL RES_REFERENCE_TRANSACTIONS__51
,NULL RES_REFERENCE_TRANSACTIONS__52
,NULL RES_REFERENCE_TRANSACTIONS__53
,RA_L.LINK_TO_PARENTLINE_CONTEXT RES_LINK_TO_PARENT_LINE_CONTEX
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE1 RES_LINK_TO_PARENT_LINE_SEGMEN
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE2 RES_LINK_TO_PARENT_LINE_SEG_54
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE3 RES_LINK_TO_PARENT_LINE_SEG_55
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE4 RES_LINK_TO_PARENT_LINE_SEG_56
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE5 RES_LINK_TO_PARENT_LINE_SEG_57
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE6 RES_LINK_TO_PARENT_LINE_SEG_58
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE7 RES_LINK_TO_PARENT_LINE_SEG_59
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE8 RES_LINK_TO_PARENT_LINE_SEG_60
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE9 RES_LINK_TO_PARENT_LINE_SEG_61
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE10 RES_LINK_TO_PARENT_LINE_SEG_62
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE11 RES_LINK_TO_PARENT_LINE_SEG_63
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE12 RES_LINK_TO_PARENT_LINE_SEG_64
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE13 RES_LINK_TO_PARENT_LINE_SEG_65
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE14 RES_LINK_TO_PARENT_LINE_SEG_66
,RA_L.LINK_TO_PARENTLINE_ATTRIBUTE15 RES_LINK_TO_PARENT_LINE_SEG_67
,(SELECT NAME
	FROM AR_RECEIPT_METHODS
	WHERE RECEIPT_METHOD_ID = RA_H.RECEIPT_METHOD_ID
	) RES_RECEIPT_METHOD_NAME
,RA_H.PRINTING_OPTION RES_PRINTING_OPTION
,NULL RES_RELATED_BATCH_SOURCE_NAME
,NULL RES_RELATED_TRANSACTION_NUMBER
,ITEM01.ITEM_NUMBER RES_INVENTORY_ITEM_NUMBER
,NULL RES_INVENTORY_ITEM_SEGMENT_2
,NULL RES_INVENTORY_ITEM_SEGMENT_3
,NULL RES_INVENTORY_ITEM_SEGMENT_4
,NULL RES_INVENTORY_ITEM_SEGMENT_5
,NULL RES_INVENTORY_ITEM_SEGMENT_6
,NULL RES_INVENTORY_ITEM_SEGMENT_7
,NULL RES_INVENTORY_ITEM_SEGMENT_8
,NULL RES_INVENTORY_ITEM_SEGMENT_9
,NULL RES_INVENTORY_ITEM_SEGMENT_10
,NULL RES_INVENTORY_ITEM_SEGMENT_11
,NULL RES_INVENTORY_ITEM_SEGMENT_12
,NULL RES_INVENTORY_ITEM_SEGMENT_13
,NULL RES_INVENTORY_ITEM_SEGMENT_14
,NULL RES_INVENTORY_ITEM_SEGMENT_15
,NULL RES_INVENTORY_ITEM_SEGMENT_16
,NULL RES_INVENTORY_ITEM_SEGMENT_17
,NULL RES_INVENTORY_ITEM_SEGMENT_18
,NULL RES_INVENTORY_ITEM_SEGMENT_19
,NULL RES_INVENTORY_ITEM_SEGMENT_20
,(SELECT BANK_ACCOUNT_NAME 
	FROM IBY_EXT_BANK_ACCOUNTS
	WHERE EXT_BANK_ACCOUNT_ID = RA_H.CUSTOMER_BANK_ACCOUNT_ID
	) RES_BILL_TO_CUSTOMER_BANK_ACCO
,NULL RES_RESET_TRANSACTION_DATE_FLA
,NULL RES_PAYMENT_SERVER_ORDER_NUMBE
,NULL RES_LAST_TRANSACTION_ON_DEBIT_
,RA_H.APPROVAL_CODE RES_APPROVAL_CODE
,RA_H.ADDRESS_VERIFICATION_CODE RES_ADDRESS_VERIFICATION_CODE
,RA_L.TRANSLATED_DESCRIPTION RES_TRANSACTION_LINE_TRANSLATE
,NULL RES_CONSOLIDATED_BILLING_NUMBE
,NULL RES_PROMISED_COMMITMENT_AMOUNT
,(SELECT SET_NAME 
	FROM FND_SETID_SETS
	WHERE SET_ID = RA_L.PAYMENT_SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_PAYMENT_SET_IDENTIFIER
,NULL RES_ORIGINAL_ACCOUNTING_DATE
,RA_L.INVOICED_LINE_ACCTG_LEVEL RES_INVOICED_LINE_ACCOUNTING_L
,RA_L.OVERRIDE_AUTO_ACCOUNTING_FLAG RES_OVERRIDE_AUTOACCOUNTING_FL
,RA_L.HISTORICAL_FLAG RES_HISTORICAL_FLAG
,RA_L.DEFERRAL_EXCLUSION_FLAG RES_DEFERRAL_EXCLUSION_FLAG
,RA_H.PAYMENT_ATTRIBUTES RES_PAYMENT_ATTRIBUTES
,TO_CHAR(RA_H.BILLING_DATE,'YYYY/MM/DD') RES_INVOICE_BILLING_DATE
,RA_L.ATTRIBUTE_CATEGORY RES_INVOICE_LINES_FLEXFIELD_CO
,RA_L.ATTRIBUTE1 RES_INVOICE_LINES_FLEXFIELD_SE
,RA_L.ATTRIBUTE2 RES_INVOICE_LINES_FLEXFIELD_68
,RA_L.ATTRIBUTE3 RES_INVOICE_LINES_FLEXFIELD_69
,RA_L.ATTRIBUTE4 RES_INVOICE_LINES_FLEXFIELD_70
,RA_L.ATTRIBUTE5 RES_INVOICE_LINES_FLEXFIELD_71
,RA_L.ATTRIBUTE6 RES_INVOICE_LINES_FLEXFIELD_72
,RA_L.ATTRIBUTE7 RES_INVOICE_LINES_FLEXFIELD_73
,RA_L.ATTRIBUTE8 RES_INVOICE_LINES_FLEXFIELD_74
,RA_L.ATTRIBUTE9 RES_INVOICE_LINES_FLEXFIELD_75
,RA_L.ATTRIBUTE10 RES_INVOICE_LINES_FLEXFIELD_76
,RA_L.ATTRIBUTE11 RES_INVOICE_LINES_FLEXFIELD_77
,RA_L.ATTRIBUTE12 RES_INVOICE_LINES_FLEXFIELD_78
,RA_L.ATTRIBUTE13 RES_INVOICE_LINES_FLEXFIELD_79
,RA_L.ATTRIBUTE14 RES_INVOICE_LINES_FLEXFIELD_80
,RA_L.ATTRIBUTE15 RES_INVOICE_LINES_FLEXFIELD_81
,RA_H.ATTRIBUTE_CATEGORY RES_INVOICE_TRANSACTIONS_FLEXF
,RA_H.ATTRIBUTE1 RES_INVOICE_TRANSACTIONS_FL_82
,RA_H.ATTRIBUTE2 RES_INVOICE_TRANSACTIONS_FL_83
,RA_H.ATTRIBUTE3 RES_INVOICE_TRANSACTIONS_FL_84
,RA_H.ATTRIBUTE4 RES_INVOICE_TRANSACTIONS_FL_85
,RA_H.ATTRIBUTE5 RES_INVOICE_TRANSACTIONS_FL_86
,RA_H.ATTRIBUTE6 RES_INVOICE_TRANSACTIONS_FL_87
,RA_H.ATTRIBUTE7 RES_INVOICE_TRANSACTIONS_FL_88
,RA_H.ATTRIBUTE8 RES_INVOICE_TRANSACTIONS_FL_89
,RA_H.ATTRIBUTE9 RES_INVOICE_TRANSACTIONS_FL_90
,RA_H.ATTRIBUTE10 RES_INVOICE_TRANSACTIONS_FL_91
,RA_H.ATTRIBUTE11 RES_INVOICE_TRANSACTIONS_FL_92
,RA_H.ATTRIBUTE12 RES_INVOICE_TRANSACTIONS_FL_93
,RA_H.ATTRIBUTE13 RES_INVOICE_TRANSACTIONS_FL_94
,RA_H.ATTRIBUTE14 RES_INVOICE_TRANSACTIONS_FL_95
,RA_H.ATTRIBUTE15 RES_INVOICE_TRANSACTIONS_FL_96
,NULL RES_RECEIVABLES_TRANSACTION_RE
,NULL RES_RECEIVABLES_TRANSACTION_97
,NULL RES_RECEIVABLES_TRANSACTION_98
,NULL RES_RECEIVABLES_TRANSACTION_99
,NULL RES_RECEIVABLES_TRANSACTIO_100
,NULL RES_RECEIVABLES_TRANSACTIO_101
,NULL RES_RECEIVABLES_TRANSACTIO_102
,NULL RES_RECEIVABLES_TRANSACTIO_103
,NULL RES_RECEIVABLES_TRANSACTIO_104
,NULL RES_RECEIVABLES_TRANSACTIO_105
,NULL RES_RECEIVABLES_TRANSACTIO_106
,NULL RES_RECEIVABLES_TRANSACTIO_107
,NULL RES_RECEIVABLES_TRANSACTIO_108
,NULL RES_RECEIVABLES_TRANSACTIO_109
,NULL RES_RECEIVABLES_TRANSACTIO_110
,NULL RES_RECEIVABLES_TRANSACTIO_111
,NULL RES_RECEIVABLES_TRANSACTIO_112
,NULL RES_RECEIVABLES_TRANSACTIO_113
,NULL RES_RECEIVABLES_TRANSACTIO_114
,NULL RES_RECEIVABLES_TRANSACTIO_115
,NULL RES_RECEIVABLES_TRANSACTIO_116
,NULL RES_RECEIVABLES_TRANSACTIO_117
,NULL RES_RECEIVABLES_TRANSACTIO_118
,NULL RES_RECEIVABLES_TRANSACTIO_119
,NULL RES_RECEIVABLES_TRANSACTIO_120
,NULL RES_RECEIVABLES_TRANSACTIO_121
,NULL RES_RECEIVABLES_TRANSACTIO_122
,NULL RES_RECEIVABLES_TRANSACTIO_123
,NULL RES_RECEIVABLES_TRANSACTIO_124
,NULL RES_RECEIVABLES_TRANSACTIO_125
,NULL RES_RECEIVABLES_TRANSACTIO_126
,RA_L.GLOBAL_ATTRIBUTE_CATEGORY RES_LINE_GLOBAL_DESCRIPTIVE_FL
,RA_L.GLOBAL_ATTRIBUTE1 RES_LINE_GLOBAL_DESCRIPTIV_127
,RA_L.GLOBAL_ATTRIBUTE2 RES_LINE_GLOBAL_DESCRIPTIV_128
,RA_L.GLOBAL_ATTRIBUTE3 RES_LINE_GLOBAL_DESCRIPTIV_129
,RA_L.GLOBAL_ATTRIBUTE4 RES_LINE_GLOBAL_DESCRIPTIV_130
,RA_L.GLOBAL_ATTRIBUTE5 RES_LINE_GLOBAL_DESCRIPTIV_131
,RA_L.GLOBAL_ATTRIBUTE6 RES_LINE_GLOBAL_DESCRIPTIV_132
,RA_L.GLOBAL_ATTRIBUTE7 RES_LINE_GLOBAL_DESCRIPTIV_133
,RA_L.GLOBAL_ATTRIBUTE8 RES_LINE_GLOBAL_DESCRIPTIV_134
,RA_L.GLOBAL_ATTRIBUTE9 RES_LINE_GLOBAL_DESCRIPTIV_135
,RA_L.GLOBAL_ATTRIBUTE10 RES_LINE_GLOBAL_DESCRIPTIV_136
,RA_L.GLOBAL_ATTRIBUTE11 RES_LINE_GLOBAL_DESCRIPTIV_137
,RA_L.GLOBAL_ATTRIBUTE12 RES_LINE_GLOBAL_DESCRIPTIV_138
,RA_L.GLOBAL_ATTRIBUTE13 RES_LINE_GLOBAL_DESCRIPTIV_139
,RA_L.GLOBAL_ATTRIBUTE14 RES_LINE_GLOBAL_DESCRIPTIV_140
,RA_L.GLOBAL_ATTRIBUTE15 RES_LINE_GLOBAL_DESCRIPTIV_141
,RA_L.GLOBAL_ATTRIBUTE16 RES_LINE_GLOBAL_DESCRIPTIV_142
,RA_L.GLOBAL_ATTRIBUTE17 RES_LINE_GLOBAL_DESCRIPTIV_143
,RA_L.GLOBAL_ATTRIBUTE18 RES_LINE_GLOBAL_DESCRIPTIV_144
,RA_L.GLOBAL_ATTRIBUTE19 RES_LINE_GLOBAL_DESCRIPTIV_145
,RA_L.GLOBAL_ATTRIBUTE20 RES_LINE_GLOBAL_DESCRIPTIV_146
,RA_H.COMMENTS RES_COMMENTS
,NULL RES_NOTES_FROM_SOURCE
,NULL RES_ENFORCE_CHRONOLOGICAL_DOCU
,RA_L.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,RA_L.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,RA_L.CREATED_BY RSC_CREATED_BY
,RA_L.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,RA_L.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM RA_CUSTOMER_TRX_ALL RA_H
,RA_CUSTOMER_TRX_LINES_ALL RA_L
,FUN_ALL_BUSINESS_UNITS_V BU
,RA_CUSTOMER_TRX_LINES_ALL RA_LINKTO
,EGP_SYSTEM_ITEMS_B ITEM01
,HZ_CUST_ACCOUNTS RAC_BILL
,HZ_CUST_SITE_USES_ALL SU_BILL
,HZ_CUST_ACCT_SITES_ALL RAA_BILL
,HZ_PARTY_SITES RAA_BILL_PS
,HZ_CUST_ACCOUNTS RAC_SHIP
,HZ_CUST_ACCOUNTS RAC_SOLD
,AR_PAYMENT_SCHEDULES_ALL ArPaymentSchedulsAllE0
/*,(SELECT RA_L_T.LINK_TO_CUST_TRX_LINE_ID
	,RA_L_T.EXTENDED_AMOUNT
	,TaxLinesE0.TAX_REGIME_CODE 
	,TaxLinesE0.TAX 
	,TaxLinesE0.TAX_STATUS_CODE 
	,TaxLinesE0.TAX_RATE_CODE 
	,TaxLinesE0.TAX_JURISDICTION_CODE 
	FROM RA_CUSTOMER_TRX_LINES_ALL RA_L_T
	,ZX_LINES TaxLinesE0
	WHERE RA_L_T.LINE_TYPE = 'TAX'
	AND RA_L_T.TAX_LINE_ID = TaxLinesE0.TAX_LINE_ID
	) RA_T*/
WHERE RA_H.CUSTOMER_TRX_ID = RA_L.CUSTOMER_TRX_ID
AND RA_L.LINK_TO_CUST_TRX_LINE_ID = RA_LINKTO.CUSTOMER_TRX_LINE_ID(+)
AND RA_L.INVENTORY_ITEM_ID = ITEM01.INVENTORY_ITEM_ID(+)
AND RA_L.ORG_ID = ITEM01.ORGANIZATION_ID(+)
AND RA_H.ORG_ID = BU.BU_ID
AND RA_H.BILL_TO_CUSTOMER_ID = RAC_BILL.CUST_ACCOUNT_ID
AND RA_H.BILL_TO_SITE_USE_ID = SU_BILL.SITE_USE_ID
AND SU_BILL.CUST_ACCT_SITE_ID = RAA_BILL.CUST_ACCT_SITE_ID
AND RAA_BILL.PARTY_SITE_ID = RAA_BILL_PS.PARTY_SITE_ID
AND RA_H.SHIP_TO_CUSTOMER_ID = RAC_SHIP.CUST_ACCOUNT_ID (+)
AND RA_H.SOLD_TO_CUSTOMER_ID = RAC_SOLD.CUST_ACCOUNT_ID (+)
--AND RA_L.CUSTOMER_TRX_LINE_ID = RA_T.LINK_TO_CUST_TRX_LINE_ID(+)
AND RA_L.LINE_TYPE IN ('LINE', 'CB', 'CHARGES')
AND RA_H.CUSTOMER_TRX_ID = ArPaymentSchedulsAllE0.CUSTOMER_TRX_ID
AND ArPaymentSchedulsAllE0.STATUS <> 'CL'
AND ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_REMAINING -- Partial paid Condition without tax
--AND ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_APPLIED -- Partial paid Condition without tax
--AND ArPaymentSchedulsAllE0.AMOUNT_DUE_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_DUE_REMAINING -- Partial paid Condition

UNION ALL

SELECT BU.SHORT_CODE RES_BUSINESS_UNIT_IDENTIFIER
,BU.BU_NAME RES_BUSINESS_UNIT_NAME
,(SELECT NAME
	FROM RA_BATCH_SOURCES_ALL
	WHERE BATCH_SOURCE_SEQ_ID = RA_H.BATCH_SOURCE_SEQ_ID
	) RES_TRANSACTION_BATCH_SOURCE_N
,(SELECT NAME 
	FROM RA_CUST_TRX_TYPES_ALL
	WHERE CUST_TRX_TYPE_SEQ_ID = RA_H.CUST_TRX_TYPE_SEQ_ID
	) RES_TRANSACTION_TYPE_NAME
,(SELECT NAME
	FROM RA_TERMS_TL
	WHERE TERM_ID = RA_H.TERM_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_PAYMENT_TERMS
,TO_CHAR(RA_H.TRX_DATE,'YYYY/MM/DD') RES_TRANSACTION_DATE
,TO_CHAR(ArPaymentSchedulsAllE0.GL_DATE,'YYYY/MM/DD') RES_ACCOUNTING_DATE
,RA_H.TRX_NUMBER RES_TRANSACTION_NUMBER
,NULL RES_ORIGINAL_SYSTEM_BILL_TO_CU -- Original System Bill-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_BILL_TO__0 -- Original System Bill-to Customer Address Reference
,NULL RES_ORIGINAL_SYSTEM_BILL_TO__1 -- Original System Bill-to Customer Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO_CU -- Original System Ship-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__2 -- Original System Ship-to Customer Address Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__3 -- Original System Ship-to Customer Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__4 -- Original System Ship-to Customer Account Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__5 -- Original System Ship-to Customer Account Address Reference
,NULL RES_ORIGINAL_SYSTEM_SHIP_TO__6 -- Original System Ship-to Customer Account Contact Reference
,NULL RES_ORIGINAL_SYSTEM_SOLD_TO_CU -- Original System Sold-to Customer Reference
,NULL RES_ORIGINAL_SYSTEM_SOLD_TO__7 -- Original System Sold-to Customer Account Reference
,RAC_BILL.ACCOUNT_NUMBER RES_BILL_TO_CUSTOMER_ACCOUNT_N
,RAA_BILL_PS.PARTY_SITE_NUMBER RES_BILL_TO_CUSTOMER_SITE_NUMB 
,(SELECT HzOrgContactsE0.CONTACT_NUMBER
	FROM HZ_CUST_ACCOUNT_ROLES RACO_BILL
	,HZ_ORG_CONTACTS HzOrgContactsE0
	WHERE RA_H.BILL_TO_CONTACT_ID = RACO_BILL.CUST_ACCOUNT_ROLE_ID
	AND RACO_BILL.RELATIONSHIP_ID = HzOrgContactsE0.PARTY_RELATIONSHIP_ID
	) RES_BILL_TO_CONTACT_PARTY_NUMB 
,RAC_SHIP.ACCOUNT_NUMBER RES_SHIP_TO_CUSTOMER_ACCOUNT_N 
,(SELECT RAA_SHIP_PS.PARTY_SITE_NUMBER
	FROM HZ_CUST_SITE_USES_ALL SU_SHIP
	,HZ_CUST_ACCT_SITES_ALL RAA_SHIP
	,HZ_PARTY_SITES RAA_SHIP_PS
	WHERE RA_H.SHIP_TO_SITE_USE_ID = SU_SHIP.SITE_USE_ID
	AND SU_SHIP.CUST_ACCT_SITE_ID = RAA_SHIP.CUST_ACCT_SITE_ID
	AND RAA_SHIP.PARTY_SITE_ID = RAA_SHIP_PS.PARTY_SITE_ID
	) RES_SHIP_TO_CUSTOMER_SITE_NUMB
,(SELECT HzOrgContactsE0.CONTACT_NUMBER
	FROM HZ_CUST_ACCOUNT_ROLES RACO_BILL
	,HZ_ORG_CONTACTS HzOrgContactsE0
	WHERE RA_H.SHIP_TO_CONTACT_ID = RACO_BILL.CUST_ACCOUNT_ROLE_ID
	AND RACO_BILL.RELATIONSHIP_ID = HzOrgContactsE0.PARTY_RELATIONSHIP_ID
	) RES_SHIP_TO_CONTACT_PARTY_NUMB 
,RAC_SOLD.ACCOUNT_NUMBER RES_SOLD_TO_CUSTOMER_ACCOUNT_N 
,RA_L.LINE_TYPE RES_TRANSACTION_LINE_TYPE
,'PAID' RES_TRANSACTION_LINE_DESCRIPTI
,RA_H.INVOICE_CURRENCY_CODE RES_CURRENCY_CODE
,(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = RA_H.EXCHANGE_RATE_TYPE
	) RES_CURRENCY_CONVERSION_TYPE
,TO_CHAR(RA_H.EXCHANGE_DATE,'DD-Mon-YYYY') RES_CURRENCY_CONVERSION_DATE
,ROUND(RA_H.EXCHANGE_RATE,5) RES_CURRENCY_CONVERSION_RATE
,((ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL - ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_REMAINING)*-1) RES_TRANSACTION_LINE_AMOUNT
,1 RES_TRANSACTION_LINE_QUANTITY
,1 RES_CUSTOMER_ORDERED_QUANTITY
,((ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL - ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_REMAINING)*-1) RES_UNIT_SELLING_PRICE
,RA_L.UNIT_STANDARD_PRICE RES_UNIT_STANDARD_PRICE
,RA_L.INTERFACE_LINE_CONTEXT RES_LINE_TRANSACTIONS_FLEXFIEL
,NVL(RA_L.INTERFACE_LINE_ATTRIBUTE1,RA_H.TRX_NUMBER) RES_LINE_TRANSACTIONS_FLEXFI_8
,'PAID' RES_LINE_TRANSACTIONS_FLEXFI_9	
,RA_L.INTERFACE_LINE_ATTRIBUTE3 RES_LINE_TRANSACTIONS_FLEXF_10
,RA_L.INTERFACE_LINE_ATTRIBUTE4 RES_LINE_TRANSACTIONS_FLEXF_11
,RA_L.INTERFACE_LINE_ATTRIBUTE5 RES_LINE_TRANSACTIONS_FLEXF_12
,RA_L.INTERFACE_LINE_ATTRIBUTE6 RES_LINE_TRANSACTIONS_FLEXF_13
,RA_L.INTERFACE_LINE_ATTRIBUTE7 RES_LINE_TRANSACTIONS_FLEXF_14
,RA_L.INTERFACE_LINE_ATTRIBUTE8 RES_LINE_TRANSACTIONS_FLEXF_15
,RA_L.INTERFACE_LINE_ATTRIBUTE9 RES_LINE_TRANSACTIONS_FLEXF_16
,RA_L.CUSTOMER_TRX_ID RES_LINE_TRANSACTIONS_FLEXF_17
,RA_L.CUSTOMER_TRX_LINE_ID RES_LINE_TRANSACTIONS_FLEXF_18
,RA_L.INTERFACE_LINE_ATTRIBUTE12 RES_LINE_TRANSACTIONS_FLEXF_19
,RA_L.INTERFACE_LINE_ATTRIBUTE13 RES_LINE_TRANSACTIONS_FLEXF_20
,RA_L.INTERFACE_LINE_ATTRIBUTE14 RES_LINE_TRANSACTIONS_FLEXF_21
,RA_L.INTERFACE_LINE_ATTRIBUTE15 RES_LINE_TRANSACTIONS_FLEXF_22
,(SELECT SalesE0.SALESREP_NUMBER
	FROM JTF_RS_SALESREPS SalesE0
	WHERE SalesE0.RESOURCE_SALESREP_ID = RA_H.PRIMARY_RESOURCE_SALESREP_ID
	) RES_PRIMARY_SALESPERSON_NUMBER
,NULL RES_TAX_CLASSIFICATION_CODE
,NULL RES_LEGAL_ENTITY_IDENTIFIER
,NULL RES_ACCOUNTED_AMOUNT_IN_LEDGER
,RA_L.SALES_ORDER RES_SALES_ORDER_NUMBER
,TO_CHAR(RA_L.SALES_ORDER_DATE,'YYYY/MM/DD') RES_SALES_ORDER_DATE
,TO_CHAR(RA_H.SHIP_DATE_ACTUAL,'YYYY/MM/DD') RES_ACTUAL_SHIP_DATE
,(SELECT ORGANIZATION_CODE  
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = RA_L.WAREHOUSE_ID
	) RES_WAREHOUSE_CODE --TRANSLATE
,RA_L.UOM_CODE RES_UNIT_OF_MEASURE_CODE
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = RA_L.UOM_CODE
	) RES_UNIT_OF_MEASURE_NAME
,(SELECT NAME 
	 FROM RA_RULES
	 WHERE RULE_ID = RA_H.INVOICING_RULE_ID
	 ) RES_INVOICING_RULE_NAME
,(SELECT NAME
	FROM RA_RULES
	WHERE RULE_ID = RA_L.ACCOUNTING_RULE_ID
	) RES_REVENUE_SCHEDULING_RULE_NA
,RA_L.ACCOUNTING_RULE_DURATION RES_NUMBER_OF_REVENUE_PERIODS
,TO_CHAR(RA_L.RULE_START_DATE,'YYYY/MM/DD') RES_REVENUE_SCHEDULING_RULE_ST
,NULL RES_REVENUE_SCHEDULING_RULE_EN
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'CREDIT_MEMO_REASON'
	AND LOOKUP_CODE = RA_L.REASON_CODE
	) RES_REASON_CODE_MEANING
,RA_L.LAST_PERIOD_TO_CREDIT RES_LAST_PERIOD_TO_CREDIT
,NULL RES_TRANSACTION_BUSINESS_CATEG
,NULL RES_PRODUCT_FISCAL_CLASSIFICAT
,NULL RES_PRODUCT_CATEGORY_CODE
,NULL RES_PRODUCT_TYPE
,NULL RES_LINE_INTENDED_USE_CODE 
,NULL RES_ASSESSABLE_VALUE
,NULL RES_DOCUMENT_SUB_TYPE
,NULL RES_DEFAULT_TAXATION_COUNTRY
,NULL RES_USER_DEFINED_FISCAL_CLASSI
,NULL RES_TAX_INVOICE_NUMBER
,NULL RES_TAX_INVOICE_DATE
,NULL RES_TAX_REGIME_CODE
,NULL RES_TAX
,NULL RES_TAX_STATUS_CODE
,NULL RES_TAX_RATE_CODE
,NULL RES_TAX_JURISDICTION_CODE
,NULL RES_FIRST_PARTY_REGISTRATION_N
,NULL RES_THIRD_PARTY_REGISTRATION_N
,NULL RES_FINAL_DISCHARGE_LOCATION
,RA_L.TAXABLE_AMOUNT RES_TAXABLE_AMOUNT
,RA_L.TAXABLE_FLAG RES_TAXABLE_FLAG
,RA_L.TAX_EXEMPT_FLAG RES_TAX_EXEMPTION_FLAG
,RA_L.TAX_EXEMPT_REASON_CODE RES_TAX_EXEMPTION_REASON_CODE
,NULL RES_TAX_EXEMPTION_REASON_CODE_ -- Translate
,RA_L.TAX_EXEMPT_NUMBER RES_TAX_EXEMPTION_CERTIFICATE_
,RA_L.AMOUNT_INCLUDES_TAX_FLAG RES_LINE_AMOUNT_INCLUDES_TAX_F
,RA_L.TAX_PRECEDENCE RES_TAX_PRECEDENCE
,NULL RES_CREDIT_METHOD_TO_BE_USED_F
,NULL RES_CREDIT_METHOD_TO_BE_USE_23
,RA_L.REASON_CODE RES_REASON_CODE
,RA_L.TAX_RATE RES_TAX_RATE
,RA_H.FOB_POINT RES_FOB_POINT
,NULL RES_CARRIER
,NULL RES_SHIPPING_REFERENCE
,RA_L.SALES_ORDER_LINE RES_SALES_ORDER_LINE_NUMBER
,RA_L.SALES_ORDER_SOURCE RES_SALES_ORDER_SOURCE
,RA_L.SALES_ORDER_REVISION RES_SALES_ORDER_REVISION_NUMBE
,RA_H.PURCHASE_ORDER RES_PURCHASE_ORDER_NUMBER
,RA_H.PURCHASE_ORDER_REVISION RES_PURCHASE_ORDER_REVISION_NU
,TO_CHAR(RA_H.PURCHASE_ORDER_DATE,'YYYY/MM/DD') RES_PURCHASE_ORDER_DATE
,NULL RES_AGREEMENT_NAME
,NULL RES_MEMO_LINE_NAME
,RA_H.DOC_SEQUENCE_VALUE RES_DOCUMENT_NUMBER
,NULL RES_ORIGINAL_SYSTEM_BATCH_NAME
,NULL RES_LINK_TO_TRANSACTIONS_FLEXF
,NULL RES_LINK_TO_TRANSACTIONS_FL_24
,NULL RES_LINK_TO_TRANSACTIONS_FL_25
,NULL RES_LINK_TO_TRANSACTIONS_FL_26
,NULL RES_LINK_TO_TRANSACTIONS_FL_27
,NULL RES_LINK_TO_TRANSACTIONS_FL_28
,NULL RES_LINK_TO_TRANSACTIONS_FL_29
,NULL RES_LINK_TO_TRANSACTIONS_FL_30
,NULL RES_LINK_TO_TRANSACTIONS_FL_31
,NULL RES_LINK_TO_TRANSACTIONS_FL_32
,NULL RES_LINK_TO_TRANSACTIONS_FL_33
,NULL RES_LINK_TO_TRANSACTIONS_FL_34
,NULL RES_LINK_TO_TRANSACTIONS_FL_35
,NULL RES_LINK_TO_TRANSACTIONS_FL_36
,NULL RES_LINK_TO_TRANSACTIONS_FL_37
,NULL RES_LINK_TO_TRANSACTIONS_FL_38
,NULL RES_REFERENCE_TRANSACTIONS_FLE
,NULL RES_REFERENCE_TRANSACTIONS__39
,NULL RES_REFERENCE_TRANSACTIONS__40
,NULL RES_REFERENCE_TRANSACTIONS__41
,NULL RES_REFERENCE_TRANSACTIONS__42
,NULL RES_REFERENCE_TRANSACTIONS__43
,NULL RES_REFERENCE_TRANSACTIONS__44
,NULL RES_REFERENCE_TRANSACTIONS__45
,NULL RES_REFERENCE_TRANSACTIONS__46
,NULL RES_REFERENCE_TRANSACTIONS__47
,NULL RES_REFERENCE_TRANSACTIONS__48
,NULL RES_REFERENCE_TRANSACTIONS__49
,NULL RES_REFERENCE_TRANSACTIONS__50
,NULL RES_REFERENCE_TRANSACTIONS__51
,NULL RES_REFERENCE_TRANSACTIONS__52
,NULL RES_REFERENCE_TRANSACTIONS__53
,NULL RES_LINK_TO_PARENT_LINE_CONTEX
,NULL RES_LINK_TO_PARENT_LINE_SEGMEN
,NULL RES_LINK_TO_PARENT_LINE_SEG_54
,NULL RES_LINK_TO_PARENT_LINE_SEG_55
,NULL RES_LINK_TO_PARENT_LINE_SEG_56
,NULL RES_LINK_TO_PARENT_LINE_SEG_57
,NULL RES_LINK_TO_PARENT_LINE_SEG_58
,NULL RES_LINK_TO_PARENT_LINE_SEG_59
,NULL RES_LINK_TO_PARENT_LINE_SEG_60
,NULL RES_LINK_TO_PARENT_LINE_SEG_61
,NULL RES_LINK_TO_PARENT_LINE_SEG_62
,NULL RES_LINK_TO_PARENT_LINE_SEG_63
,NULL RES_LINK_TO_PARENT_LINE_SEG_64
,NULL RES_LINK_TO_PARENT_LINE_SEG_65
,NULL RES_LINK_TO_PARENT_LINE_SEG_66
,NULL RES_LINK_TO_PARENT_LINE_SEG_67
,(SELECT NAME
	FROM AR_RECEIPT_METHODS
	WHERE RECEIPT_METHOD_ID = RA_H.RECEIPT_METHOD_ID
	) RES_RECEIPT_METHOD_NAME
,RA_H.PRINTING_OPTION RES_PRINTING_OPTION
,NULL RES_RELATED_BATCH_SOURCE_NAME
,NULL RES_RELATED_TRANSACTION_NUMBER
,NULL RES_INVENTORY_ITEM_NUMBER
,NULL RES_INVENTORY_ITEM_SEGMENT_2
,NULL RES_INVENTORY_ITEM_SEGMENT_3
,NULL RES_INVENTORY_ITEM_SEGMENT_4
,NULL RES_INVENTORY_ITEM_SEGMENT_5
,NULL RES_INVENTORY_ITEM_SEGMENT_6
,NULL RES_INVENTORY_ITEM_SEGMENT_7
,NULL RES_INVENTORY_ITEM_SEGMENT_8
,NULL RES_INVENTORY_ITEM_SEGMENT_9
,NULL RES_INVENTORY_ITEM_SEGMENT_10
,NULL RES_INVENTORY_ITEM_SEGMENT_11
,NULL RES_INVENTORY_ITEM_SEGMENT_12
,NULL RES_INVENTORY_ITEM_SEGMENT_13
,NULL RES_INVENTORY_ITEM_SEGMENT_14
,NULL RES_INVENTORY_ITEM_SEGMENT_15
,NULL RES_INVENTORY_ITEM_SEGMENT_16
,NULL RES_INVENTORY_ITEM_SEGMENT_17
,NULL RES_INVENTORY_ITEM_SEGMENT_18
,NULL RES_INVENTORY_ITEM_SEGMENT_19
,NULL RES_INVENTORY_ITEM_SEGMENT_20
,(SELECT BANK_ACCOUNT_NAME 
	FROM IBY_EXT_BANK_ACCOUNTS
	WHERE EXT_BANK_ACCOUNT_ID = RA_H.CUSTOMER_BANK_ACCOUNT_ID
	) RES_BILL_TO_CUSTOMER_BANK_ACCO
,NULL RES_RESET_TRANSACTION_DATE_FLA
,NULL RES_PAYMENT_SERVER_ORDER_NUMBE
,NULL RES_LAST_TRANSACTION_ON_DEBIT_
,NULL RES_APPROVAL_CODE
,NULL RES_ADDRESS_VERIFICATION_CODE
,NULL RES_TRANSACTION_LINE_TRANSLATE
,NULL RES_CONSOLIDATED_BILLING_NUMBE
,NULL RES_PROMISED_COMMITMENT_AMOUNT
,(SELECT SET_NAME 
	FROM FND_SETID_SETS
	WHERE SET_ID = RA_L.PAYMENT_SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_PAYMENT_SET_IDENTIFIER
,NULL RES_ORIGINAL_ACCOUNTING_DATE
,NULL RES_INVOICED_LINE_ACCOUNTING_L
,NULL RES_OVERRIDE_AUTOACCOUNTING_FL
,NULL RES_HISTORICAL_FLAG
,NULL RES_DEFERRAL_EXCLUSION_FLAG
,NULL RES_PAYMENT_ATTRIBUTES
,NULL RES_INVOICE_BILLING_DATE
,NULL RES_INVOICE_LINES_FLEXFIELD_CO
,NULL RES_INVOICE_LINES_FLEXFIELD_SE
,NULL RES_INVOICE_LINES_FLEXFIELD_68
,NULL RES_INVOICE_LINES_FLEXFIELD_69
,NULL RES_INVOICE_LINES_FLEXFIELD_70
,NULL RES_INVOICE_LINES_FLEXFIELD_71
,NULL RES_INVOICE_LINES_FLEXFIELD_72
,NULL RES_INVOICE_LINES_FLEXFIELD_73
,NULL RES_INVOICE_LINES_FLEXFIELD_74
,NULL RES_INVOICE_LINES_FLEXFIELD_75
,NULL RES_INVOICE_LINES_FLEXFIELD_76
,NULL RES_INVOICE_LINES_FLEXFIELD_77
,NULL RES_INVOICE_LINES_FLEXFIELD_78
,NULL RES_INVOICE_LINES_FLEXFIELD_79
,NULL RES_INVOICE_LINES_FLEXFIELD_80
,NULL RES_INVOICE_LINES_FLEXFIELD_81
,RA_H.ATTRIBUTE_CATEGORY RES_INVOICE_TRANSACTIONS_FLEXF
,RA_H.ATTRIBUTE1 RES_INVOICE_TRANSACTIONS_FL_82
,RA_H.ATTRIBUTE2 RES_INVOICE_TRANSACTIONS_FL_83
,RA_H.ATTRIBUTE3 RES_INVOICE_TRANSACTIONS_FL_84
,RA_H.ATTRIBUTE4 RES_INVOICE_TRANSACTIONS_FL_85
,RA_H.ATTRIBUTE5 RES_INVOICE_TRANSACTIONS_FL_86
,RA_H.ATTRIBUTE6 RES_INVOICE_TRANSACTIONS_FL_87
,RA_H.ATTRIBUTE7 RES_INVOICE_TRANSACTIONS_FL_88
,RA_H.ATTRIBUTE8 RES_INVOICE_TRANSACTIONS_FL_89
,RA_H.ATTRIBUTE9 RES_INVOICE_TRANSACTIONS_FL_90
,RA_H.ATTRIBUTE10 RES_INVOICE_TRANSACTIONS_FL_91
,RA_H.ATTRIBUTE11 RES_INVOICE_TRANSACTIONS_FL_92
,RA_H.ATTRIBUTE12 RES_INVOICE_TRANSACTIONS_FL_93
,RA_H.ATTRIBUTE13 RES_INVOICE_TRANSACTIONS_FL_94
,RA_H.ATTRIBUTE14 RES_INVOICE_TRANSACTIONS_FL_95
,RA_H.ATTRIBUTE15 RES_INVOICE_TRANSACTIONS_FL_96
,NULL RES_RECEIVABLES_TRANSACTION_RE
,NULL RES_RECEIVABLES_TRANSACTION_97
,NULL RES_RECEIVABLES_TRANSACTION_98
,NULL RES_RECEIVABLES_TRANSACTION_99
,NULL RES_RECEIVABLES_TRANSACTIO_100
,NULL RES_RECEIVABLES_TRANSACTIO_101
,NULL RES_RECEIVABLES_TRANSACTIO_102
,NULL RES_RECEIVABLES_TRANSACTIO_103
,NULL RES_RECEIVABLES_TRANSACTIO_104
,NULL RES_RECEIVABLES_TRANSACTIO_105
,NULL RES_RECEIVABLES_TRANSACTIO_106
,NULL RES_RECEIVABLES_TRANSACTIO_107
,NULL RES_RECEIVABLES_TRANSACTIO_108
,NULL RES_RECEIVABLES_TRANSACTIO_109
,NULL RES_RECEIVABLES_TRANSACTIO_110
,NULL RES_RECEIVABLES_TRANSACTIO_111
,NULL RES_RECEIVABLES_TRANSACTIO_112
,NULL RES_RECEIVABLES_TRANSACTIO_113
,NULL RES_RECEIVABLES_TRANSACTIO_114
,NULL RES_RECEIVABLES_TRANSACTIO_115
,NULL RES_RECEIVABLES_TRANSACTIO_116
,NULL RES_RECEIVABLES_TRANSACTIO_117
,NULL RES_RECEIVABLES_TRANSACTIO_118
,NULL RES_RECEIVABLES_TRANSACTIO_119
,NULL RES_RECEIVABLES_TRANSACTIO_120
,NULL RES_RECEIVABLES_TRANSACTIO_121
,NULL RES_RECEIVABLES_TRANSACTIO_122
,NULL RES_RECEIVABLES_TRANSACTIO_123
,NULL RES_RECEIVABLES_TRANSACTIO_124
,NULL RES_RECEIVABLES_TRANSACTIO_125
,NULL RES_RECEIVABLES_TRANSACTIO_126
,NULL RES_LINE_GLOBAL_DESCRIPTIVE_FL
,NULL RES_LINE_GLOBAL_DESCRIPTIV_127
,NULL RES_LINE_GLOBAL_DESCRIPTIV_128
,NULL RES_LINE_GLOBAL_DESCRIPTIV_129
,NULL RES_LINE_GLOBAL_DESCRIPTIV_130
,NULL RES_LINE_GLOBAL_DESCRIPTIV_131
,NULL RES_LINE_GLOBAL_DESCRIPTIV_132
,NULL RES_LINE_GLOBAL_DESCRIPTIV_133
,NULL RES_LINE_GLOBAL_DESCRIPTIV_134
,NULL RES_LINE_GLOBAL_DESCRIPTIV_135
,NULL RES_LINE_GLOBAL_DESCRIPTIV_136
,NULL RES_LINE_GLOBAL_DESCRIPTIV_137
,NULL RES_LINE_GLOBAL_DESCRIPTIV_138
,NULL RES_LINE_GLOBAL_DESCRIPTIV_139
,NULL RES_LINE_GLOBAL_DESCRIPTIV_140
,NULL RES_LINE_GLOBAL_DESCRIPTIV_141
,NULL RES_LINE_GLOBAL_DESCRIPTIV_142
,NULL RES_LINE_GLOBAL_DESCRIPTIV_143
,NULL RES_LINE_GLOBAL_DESCRIPTIV_144
,NULL RES_LINE_GLOBAL_DESCRIPTIV_145
,NULL RES_LINE_GLOBAL_DESCRIPTIV_146
,RA_H.COMMENTS RES_COMMENTS
,NULL RES_NOTES_FROM_SOURCE
,NULL RES_ENFORCE_CHRONOLOGICAL_DOCU
,RA_L.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,RA_L.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,RA_L.CREATED_BY RSC_CREATED_BY
,RA_L.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,RA_L.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM RA_CUSTOMER_TRX_ALL RA_H
,(SELECT L.*
	,ROW_NUMBER() OVER (PARTITION BY L.CUSTOMER_TRX_ID ORDER BY L.UNIT_SELLING_PRICE DESC) R1
	FROM RA_CUSTOMER_TRX_LINES_ALL L
	WHERE LINE_TYPE IN ('LINE', 'CB', 'CHARGES')
	) RA_L
--,RA_CUSTOMER_TRX_LINES_ALL RA_L
,FUN_ALL_BUSINESS_UNITS_V BU
,HZ_CUST_ACCOUNTS RAC_BILL
,HZ_CUST_SITE_USES_ALL SU_BILL
,HZ_CUST_ACCT_SITES_ALL RAA_BILL
,HZ_PARTY_SITES RAA_BILL_PS
,HZ_CUST_ACCOUNTS RAC_SHIP
,HZ_CUST_ACCOUNTS RAC_SOLD
,AR_PAYMENT_SCHEDULES_ALL ArPaymentSchedulsAllE0
WHERE RA_H.CUSTOMER_TRX_ID = RA_L.CUSTOMER_TRX_ID
AND RA_H.ORG_ID = BU.BU_ID
AND RA_H.BILL_TO_CUSTOMER_ID = RAC_BILL.CUST_ACCOUNT_ID
AND RA_H.BILL_TO_SITE_USE_ID = SU_BILL.SITE_USE_ID
AND SU_BILL.CUST_ACCT_SITE_ID = RAA_BILL.CUST_ACCT_SITE_ID
AND RAA_BILL.PARTY_SITE_ID = RAA_BILL_PS.PARTY_SITE_ID
AND RA_H.SHIP_TO_CUSTOMER_ID = RAC_SHIP.CUST_ACCOUNT_ID (+)
AND RA_H.SOLD_TO_CUSTOMER_ID = RAC_SOLD.CUST_ACCOUNT_ID (+)
--AND RA_L.TAX_LINE_ID = TaxLinesE0.TAX_LINE_ID(+)
--AND RA_L.LINE_TYPE IN ('LINE', 'CB', 'CHARGES')
AND RA_H.CUSTOMER_TRX_ID = ArPaymentSchedulsAllE0.CUSTOMER_TRX_ID
AND ArPaymentSchedulsAllE0.STATUS <> 'CL'
AND ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_REMAINING
--AND ArPaymentSchedulsAllE0.AMOUNT_LINE_ITEMS_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_APPLIED -- Partial paid Condition without tax
--AND ArPaymentSchedulsAllE0.AMOUNT_DUE_ORIGINAL != ArPaymentSchedulsAllE0.AMOUNT_DUE_REMAINING -- Partial paid Condition
--AND RA_L.LINE_NUMBER = 1
AND RA_L.R1 = 1
)
ORDER BY 2,7