/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartyEO.PARTY_NAME RES_CARRIER_NAME
,CarrierContactEO.PERSON_LAST_NAME RES_LAST_NAME
,CarrierContactEO.PERSON_FIRST_NAME RES_FIRST_NAME
,CarrierContactEO.ORG_JOB_TITLE RES_JOB_TITLE
,CarrierContactEO.PHONE_NUMBER RES_PHONE
,CarrierContactEO.EMAIL_ADDRESS RES_E_MAIL
,NULL RSC_LAST_UPDATED_BY
,NULL RSC_LAST_UPDATE_DATE
,NULL RSC_CREATED_BY
,NULL RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WSH_CARRIERS CarrierEO
,HZ_PARTIES PartyEO
,WSH_CARRIER_CONTACTS_V CarrierContactEO
WHERE CarrierEO.CARRIER_ID = PartyEO.PARTY_ID
AND CarrierEO.CARRIER_ID   = CarrierContactEO.CARRIER_ID
ORDER BY PartyEO.PARTY_NAME
,CarrierContactEO.PERSON_LAST_NAME