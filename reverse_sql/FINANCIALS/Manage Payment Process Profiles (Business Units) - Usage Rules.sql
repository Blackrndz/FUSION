/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME          	RES_NAME 
, IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  RES_CODE 
,  decode(pm.applicable_value_to ,'','All','Specify')       		RES_BUSINESS_UNITS_OPTION
,  (select distinct BusinessUnitPEO.BU_NAME  
    from  FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
    where BusinessUnitPEO.BU_ID = pm.applicable_value_to )          RES_BUSINESS_UNITS
, PM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, PM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, PM.CREATED_BY  RSC_CREATED_BY
, PM.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, (CASE 
	WHEN PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID IS NULL THEN
		TO_CHAR(BUDETAIL.ORGANIZATION_ID)
	ELSE
		CASE	
			WHEN pm.applicable_value_to IS NULL THEN
				NULL
			ELSE
				CASE
					WHEN PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID = BUDETAIL.ORG_INFORMATION2 THEN
						TO_CHAR(BUDETAIL.ORGANIZATION_ID)
					ELSE
						'-1'
					END
			END
	END) RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL    IbySysPmtProfilesVl,
     IBY_APPLICABLE_PMT_PROFS   PM
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_NAME||' '||CeBankAccounts.BANK_ACCOUNT_NAME DEFAULT_PAYMENT_DOCUMENT
	,CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
,(SELECT ORG_INFORMATION2
	,ORGANIZATION_ID 
	FROM HR_ORGANIZATION_INFORMATION
	WHERE ORG_INFORMATION_CONTEXT = 'FUN_BUSINESS_UNIT') BUDETAIL
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE         = PM.SYSTEM_PROFILE_CODE(+)
AND pm.applicable_type_code  = 'PAYER_ORG'
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
AND TO_CHAR(pm.applicable_value_to) = BUDETAIL.ORGANIZATION_ID(+)
ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME 