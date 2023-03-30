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
,IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  RES_CODE 
,IbyBepinfo.NAME RES_PAYMENT_SYSTEM_ACCOUNT
,paymentAccountsE0.PAYMENT_PROFILE_NAME RES_CONFIGURATION_PROFILE
,(SELECT TRANSMIT_CONFIGURATION_NAME
	FROM IBY_TRANSMIT_CONFIGS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TRANSMIT_CONFIGURATION_ID = paymentAccountsE0.TRANSMIT_CONFIGURATION_ID 
	) RES_PAYMENT_FILE_TRANSMISSION_
,TO_CHAR(paymentAccountsE0.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(paymentAccountsE0.END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(paymentAccountsE0.END_DATE,'DD-Mon-YYYY')) RES_TO_DATE
,paymentAccountsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,paymentAccountsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,paymentAccountsE0.CREATED_BY  RSC_CREATED_BY
,paymentAccountsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL IbySysPmtProfilesVl
,IBY_BEPINFO IbyBepinfo
,IBY_BEPKEYS ibyBepkeysEo
,IBY_ACCT_PMT_PROFILES_VL paymentAccountsE0
WHERE IbySysPmtProfilesVl.BEPID = IbyBepinfo.BEPID
AND IbyBepinfo.BEPID = ibyBepkeysEo.BEPID
AND IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE = paymentAccountsE0.SYSTEM_PROFILE_CODE
AND ibyBepkeysEo.BEP_ACCOUNT_ID = paymentAccountsE0.BEP_ACCOUNT_ID
ORDER BY IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME
,paymentAccountsE0.PAYMENT_PROFILE_NAME