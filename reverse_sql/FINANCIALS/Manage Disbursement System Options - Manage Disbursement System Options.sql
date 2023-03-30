/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Disbursement%20System%20Options%20-%20Manage%20Disbursement%20System%20Options.sql $:
 * $Id: Manage Disbursement System Options - Manage Disbursement System Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=IBY_INTERNAL_PAYERS_ALL 

SELECT
	NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.ALLOW_EXT_ACCT_OVERRIDE_FLAG
	),'No') AS RES_ALLOW_PAYEE_BANK_ACCOUNT_O
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'IBY_PSO_DEF_PAY_METHOD'
	AND LOOKUP_CODE   = IbyInternalPayersAll.PAYMENT_METHOD_AT_PAYEE_FLAG
	) AS RES_PAYMENT_METHOD_DEFAULT_BAS
,IbyInternalPayersAll.SRA_SEND_FROM AS RES_SEPARATE_REMITTANCE_ADVICE
,IbyInternalPayersAll.SRA_EMAIL_SUBJECT AS RES_SEPARATE_REMITTANCE_ADVI_0
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'IBY_DOCUMENT_REJECTION_LEVELS'
	AND LOOKUP_CODE   = IbyInternalPayersAll.DOCUMENT_REJECTION_LEVEL_CODE
	) AS RES_DOCUMENT
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'IBY_PAYMENT_REJECTION_LEVELS'
	AND LOOKUP_CODE   = IbyInternalPayersAll.PAYMENT_REJECTION_LEVEL_CODE
	) AS RES_PAYMENT
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.REQUIRE_PROP_PMTS_REVIEW_FLAG
	),'No') AS RES_REVIEW_PROPOSED_PAYMENTS_A
,DECODE(IbyInternalPayersAll.PAYMENTS_APPROVAL_FLAG,'Y','Yes','No') RES_ENABLE_PAYMENT_APPROVAL
,(SELECT FORMAT_NAME
	FROM IBY_FORMATS_VL
	WHERE FORMAT_CODE = IbyInternalPayersAll.PPR_REPORT_FORMAT
	) AS RES_FORMAT
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.AUTOMATIC_PPR_REPORT_SUBMIT
	),'No') AS RES_AUTOMATICALLY_SUBMIT_AT_PA
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.SAVE_PAYMENT_FILE_IN_DB
	),'No') AS RES_SAVE_FORMATTED_PAYMENT_FIL
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'IBY_BANK_CHARGE_BEARER'
	AND LOOKUP_CODE   = IbyInternalPayersAll.BANK_CHARGE_BEARER
	) AS RES_BANK_CHARGE_BEARER
,NVL((SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.EXCLUSIVE_PAYMENT_FLAG
	),'No') AS RES_PAY_EACH_DOCUMENT_ALONE
,IbyInternalPayersAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,IbyInternalPayersAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,IbyInternalPayersAll.CREATED_BY  RSC_CREATED_BY
,IbyInternalPayersAll.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,IbyInternalPayersAll.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_INTERNAL_PAYERS_ALL IbyInternalPayersAll
WHERE IbyInternalPayersAll.ORG_ID IS NULL