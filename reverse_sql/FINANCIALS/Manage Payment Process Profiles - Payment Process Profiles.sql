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
,IbySysPmtProfilesVl.SYSTEM_PROFILE_DESCRIPTION RES_DESCRIPTION
,TO_CHAR(IbySysPmtProfilesVl.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(IbySysPmtProfilesVl.END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(IbySysPmtProfilesVl.END_DATE,
	'DD-Mon-YYYY')) RES_TO_DATE
,IbyFormatsVl.Format_Name RES_PAYMENT_FILE_FORMAT_NAME
,IbyFormatsVl.Format_code RES_PAYMENT_FILE_FORMAT_CODE
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_PROCESSING_TYPES'
	AND LookupPEO.LOOKUP_CODE   = IbySysPmtProfilesVl.PROCESSING_TYPE
	) RES_PROCESSING_TYPE
,NULL RES_DEFAULT_PAYMENT_DOCUMENT
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_MARK_COMPLETE_EVENTS'
	AND LookupPEO.LOOKUP_CODE   = IbySysPmtProfilesVl.MARK_COMPLETE_EVENT
	) RES_PAYMENT_CONFIRMATION_POINT
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'ELECTRONIC',DECODE(IbySysPmtProfilesVl.MANUAL_MARK_COMPLETE_FLAG,'Y','Yes'
	,'No')) RES_ALLOW_MANUAL_SETTING_OF_PA
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',DECODE(IbySysPmtProfilesVl.SEND_TO_FILE_FLAG,'Y','Send to file',
	'N','Send to printer')) RES_PAYMENT_FILE
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',DECODE(IbySysPmtProfilesVl.PRINT_INSTRUCTION_IMMED_FLAG,'Y','Yes'
	,'No')) RES_AUTOMATICALLY_PRINT_AFTER_
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',IbySysPmtProfilesVl.DEFAULT_PRINTER) RES_DEFAULT_PRINTER
,IbySysPmtProfilesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbySysPmtProfilesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbySysPmtProfilesVl.CREATED_BY RSC_CREATED_BY
,IbySysPmtProfilesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,'' RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,IBY_FORMATS_VL IbyFormatsVl
WHERE IbySysPmtProfilesVl.PAYMENT_FORMAT_CODE = IbyFormatsVl.FORMAT_CODE

UNION

SELECT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME RES_NAME
,IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE RES_CODE
,IbySysPmtProfilesVl.SYSTEM_PROFILE_DESCRIPTION RES_DESCRIPTION
,TO_CHAR(IbySysPmtProfilesVl.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(IbySysPmtProfilesVl.END_DATE,'DD-Mon-YYYY'),'31-12-4712',NULL,TO_CHAR(IbySysPmtProfilesVl.END_DATE,
	'DD-Mon-YYYY')) RES_TO_DATE
,IbyFormatsVl.Format_Name RES_PAYMENT_FILE_FORMAT_NAME
,IbyFormatsVl.Format_code RES_PAYMENT_FILE_FORMAT_CODE
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_PROCESSING_TYPES'
	AND LookupPEO.LOOKUP_CODE   = IbySysPmtProfilesVl.PROCESSING_TYPE
	) RES_PROCESSING_TYPE
,PaymentDocumentE0.DEFAULT_PAYMENT_DOCUMENT RES_DEFAULT_PAYMENT_DOCUMENT
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_MARK_COMPLETE_EVENTS'
	AND LookupPEO.LOOKUP_CODE   = IbySysPmtProfilesVl.MARK_COMPLETE_EVENT
	) RES_PAYMENT_CONFIRMATION_POINT
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'ELECTRONIC',DECODE(IbySysPmtProfilesVl.MANUAL_MARK_COMPLETE_FLAG,'Y','Yes'
	,'No')) RES_ALLOW_MANUAL_SETTING_OF_PA
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',DECODE(IbySysPmtProfilesVl.SEND_TO_FILE_FLAG,'Y','Send to file',
	'N','Send to printer')) RES_PAYMENT_FILE
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',DECODE(IbySysPmtProfilesVl.PRINT_INSTRUCTION_IMMED_FLAG,'Y','Yes'
	,'No')) RES_AUTOMATICALLY_PRINT_AFTER_
,DECODE(IbySysPmtProfilesVl.PROCESSING_TYPE,'PRINTED',IbySysPmtProfilesVl.DEFAULT_PRINTER) RES_DEFAULT_PRINTER
,IbySysPmtProfilesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbySysPmtProfilesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbySysPmtProfilesVl.CREATED_BY RSC_CREATED_BY
,IbySysPmtProfilesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,IBY_FORMATS_VL IbyFormatsVl
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_NAME||' '||CeBankAccounts.BANK_ACCOUNT_NAME DEFAULT_PAYMENT_DOCUMENT
	,CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE IbySysPmtProfilesVl.PAYMENT_FORMAT_CODE = IbyFormatsVl.FORMAT_CODE
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

/*
	Note!
	Due to the data in WHO column from parent table (Manage Payment Process Profiles - Payment Process Profiles) have been conflict
	with data in the child table which it has their own data in WHO column (In this case they use Business Unit ID.). It rise the issue
	with the filter in RapidExtract with 3 possiblity.
	
	1. Parent as Global and child as BU - This situation is fine for all cuase.
	2. Parent and child have diffrence BU - Child BU whom difference than parent will return BUID to -1.
	3. Parent as BU and Child as global - the parent will have 2 records 1 that tie with BUID and one of them as global.
	
	
*/