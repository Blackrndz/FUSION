/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Process%20Profiles%20-%20Payment%20Process%20Profiles%20-%20DFF.sql $:
 * $Id: Manage Payment Process Profiles - Payment Process Profiles - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=673##RES##IBY_SYS_PMT_PROFILES
-- DFF_ATTRIBUTES=ATTRIBUTE
-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.
 
select IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME   RES_NAME
,IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE               RES_CODE
,IbySysPmtProfilesVl.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,IbySysPmtProfilesVl.ATTRIBUTE1 
,IbySysPmtProfilesVl.ATTRIBUTE2
,IbySysPmtProfilesVl.ATTRIBUTE3
,IbySysPmtProfilesVl.ATTRIBUTE4
,IbySysPmtProfilesVl.ATTRIBUTE5
,IbySysPmtProfilesVl.ATTRIBUTE6
,IbySysPmtProfilesVl.ATTRIBUTE7
,IbySysPmtProfilesVl.ATTRIBUTE8
,IbySysPmtProfilesVl.ATTRIBUTE9
,IbySysPmtProfilesVl.ATTRIBUTE10
,IbySysPmtProfilesVl.ATTRIBUTE11
,IbySysPmtProfilesVl.ATTRIBUTE12
,IbySysPmtProfilesVl.ATTRIBUTE13
,IbySysPmtProfilesVl.ATTRIBUTE14
,IbySysPmtProfilesVl.ATTRIBUTE15
,IbySysPmtProfilesVl.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,IbySysPmtProfilesVl.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,IbySysPmtProfilesVl.CREATED_BY  RSC_CREATED_BY
,IbySysPmtProfilesVl.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,'' RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE (IbySysPmtProfilesVl.ATTRIBUTE_CATEGORY IS NOT NULL OR
IbySysPmtProfilesVl.ATTRIBUTE1 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE2 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE3 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE4 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE5 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE6 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE7 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE8 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE9 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE10 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE11 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE12 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE13 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE14 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE15 IS NOT NULL)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID

UNION

select IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME   RES_NAME
,IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE               RES_CODE
,IbySysPmtProfilesVl.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,IbySysPmtProfilesVl.ATTRIBUTE1 
,IbySysPmtProfilesVl.ATTRIBUTE2
,IbySysPmtProfilesVl.ATTRIBUTE3
,IbySysPmtProfilesVl.ATTRIBUTE4
,IbySysPmtProfilesVl.ATTRIBUTE5
,IbySysPmtProfilesVl.ATTRIBUTE6
,IbySysPmtProfilesVl.ATTRIBUTE7
,IbySysPmtProfilesVl.ATTRIBUTE8
,IbySysPmtProfilesVl.ATTRIBUTE9
,IbySysPmtProfilesVl.ATTRIBUTE10
,IbySysPmtProfilesVl.ATTRIBUTE11
,IbySysPmtProfilesVl.ATTRIBUTE12
,IbySysPmtProfilesVl.ATTRIBUTE13
,IbySysPmtProfilesVl.ATTRIBUTE14
,IbySysPmtProfilesVl.ATTRIBUTE15
,IbySysPmtProfilesVl.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,IbySysPmtProfilesVl.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,IbySysPmtProfilesVl.CREATED_BY  RSC_CREATED_BY
,IbySysPmtProfilesVl.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
from IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
WHERE (IbySysPmtProfilesVl.ATTRIBUTE_CATEGORY IS NOT NULL OR
IbySysPmtProfilesVl.ATTRIBUTE1 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE2 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE3 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE4 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE5 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE6 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE7 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE8 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE9 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE10 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE11 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE12 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE13 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE14 IS NOT NULL OR 
IbySysPmtProfilesVl.ATTRIBUTE15 IS NOT NULL)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID