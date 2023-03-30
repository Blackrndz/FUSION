/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT partiesE0.PARTY_NAME RES_NAME
,partiesE0.PARTY_NUMBER RES_NUMBER
,partiesE0.URL RES_PRIMARY_URL
,HZ_FORMAT_PUB.FORMAT_ADDRESS(P_LOCATION_ID => partiesE0.IDEN_ADDR_LOCATION_ID, P_LINE_BREAK => ',') RES_PRIMARY_ADDRESS
,contactsE0.PARTY_NAME RES_PRIMARY_CONTACT
,contactsE0.PRIMARY_PHONE_NUMBER RES_CONTACT_PHONE
,contactsE0.EMAIL_ADDRESS RES_CONTACT_EMAIL
,accE0.ACCOUNT_NUMBER RES_SPONSOR_ACCOUNT_NUMBER
,DECODE(sponsorsE0.FEDERAL_FLAG,'Y','Yes','No') RES_FEDERAL
,(SELECT IND_SCH_NAME
    FROM PJF_IND_RATE_SCH_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND IND_RATE_SCH_ID = sponsorsE0.IND_RATE_SCH_ID 
	) RES_BURDEN_SCHEDULE
,sponsorsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,sponsorsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,sponsorsE0.CREATED_BY RSC_CREATED_BY
,sponsorsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_SPONSORS_VL sponsorsE0
,HZ_PARTIES partiesE0
,HZ_PARTIES contactsE0
,HZ_CUST_ACCOUNTS accE0
WHERE sponsorsE0.PARTY_ID = partiesE0.PARTY_ID
AND partiesE0.PREFERRED_CONTACT_PERSON_ID = contactsE0.PARTY_ID
AND sponsorsE0.SPONSOR_ACCT_ID = accE0.CUST_ACCOUNT_ID
ORDER BY partiesE0.PARTY_NAME