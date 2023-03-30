/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzPartiesE0.PARTY_NAME RES_NAME
,HzPartySitesE0.PARTY_SITE_NUMBER RES_SITE_NUMBER
,HzPartySitesE0.PARTY_SITE_NAME RES_SITE_NAME
,DECODE(ExtPaymentMethodsE0.PRIMARY_FLAG,'Y','Yes','N','No') RES_DEFAULT
,(SELECT PAYMENT_METHOD_NAME 
	FROM IBY_PAYMENT_METHODS_TL
	WHERE PAYMENT_METHOD_CODE = ExtPaymentMethodsE0.PAYMENT_METHOD_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_PAYMENT_METHOD
,TO_CHAR(ExtPaymentMethodsE0.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(ExtPaymentMethodsE0.END_DATE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ExtPaymentMethodsE0.END_DATE,'DD-Mon-YYYY')) RES_TO_DATE
,ExtPaymentMethodsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ExtPaymentMethodsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ExtPaymentMethodsE0.CREATED_BY  RSC_CREATED_BY
,ExtPaymentMethodsE0.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_ORGANIZATION_PROFILES HzOrganizationProfileE0
,HZ_PARTY_SITES HzPartySitesE0
,IBY_EXTERNAL_PAYEES_ALL ExtPayeesE0
,IBY_EXT_PARTY_PMT_MTHDS ExtPaymentMethodsE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzOrganizationProfileE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzPartySitesE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CREDIT_CARD_PROVIDER'
AND HzPartySitesE0.STATUS = 'A'
AND HzPartySitesE0.PARTY_ID = ExtPayeesE0.PAYEE_PARTY_ID
AND HzPartySitesE0.PARTY_SITE_ID = ExtPayeesE0.PARTY_SITE_ID
AND ExtPayeesE0.EXT_PAYEE_ID = ExtPaymentMethodsE0.EXT_PMT_PARTY_ID
AND ExtPaymentMethodsE0.PRIMARY_FLAG = 'Y'
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzPartySitesE0.PARTY_SITE_NUMBER
,RES_PAYMENT_METHOD