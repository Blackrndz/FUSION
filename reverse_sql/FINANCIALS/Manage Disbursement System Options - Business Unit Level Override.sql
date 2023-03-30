/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Disbursement%20System%20Options%20-%20Business%20Unit%20Level%20Override.sql $:
 * $Id: Manage Disbursement System Options - Business Unit Level Override.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT
	(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = IbyInternalPayersAll.ORG_ID
	) AS RES_BUSINESS_UNIT
,(SELECT meaning
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'IBY_PSO_DEF_PAY_METHOD'
	AND LOOKUP_CODE   = IbyInternalPayersAll.PAYMENT_METHOD_AT_PAYEE_FLAG
	) AS RES_PAYMENT_METHOD_DEFAULT_BAS
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'YES_NO'
	AND LOOKUP_CODE   = IbyInternalPayersAll.ALLOW_EXT_ACCT_OVERRIDE_FLAG
	) AS RES_ALLOW_PAYEE_BANK_ACCOUNT_O
,IbyInternalPayersAll.SRA_SEND_FROM AS RES_SEPARATE_REMITTANCE_ADVICE
,IbyInternalPayersAll.SRA_EMAIL_SUBJECT AS RES_SEPARATE_REMITTANCE_ADVI_0
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
WHERE IbyInternalPayersAll.ORG_ID IS NOT NULL
ORDER BY RES_BUSINESS_UNIT