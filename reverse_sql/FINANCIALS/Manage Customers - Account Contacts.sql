/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT 
(SELECT MEANING 
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PARTY_TYPE'
	AND LOOKUP_CODE = HzPartiesE0.PARTY_TYPE
	) RES_CUSTOMER_TYPE
,HzPartiesE0.PARTY_NUMBER RES_REGISTRY_ID
,HzCustAccountsE0.ACCOUNT_NUMBER RES_ACCOUNT_NUMBER
,DECODE(HzCustAccountRolesE0.PRIMARY_FLAG,'Y','Yes','N','No') RES_PRIMARY_CONTACT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'CONTACT_TITLE'
	AND LOOKUP_CODE = ContactDetailE0.PERSON_PRE_NAME_ADJUNCT
	) RES_PREFIX
,ContactDetailE0.PERSON_FIRST_NAME RES_FIRST_NAME
,ContactDetailE0.PERSON_LAST_NAME RES_LAST_NAME
,ContactDetailE0.PERSON_MIDDLE_NAME RES_MIDDLE_NAME
,ContactDetailE0.PERSON_NAME_SUFFIX RES_SUFFIX
,HzOrgContactsE0.CONTACT_NUMBER RES_CONTACT_NUMBER
,ContactDetailE0.PERSON_TITLE RES_TITLE
,HzOrgContactsE0.JOB_TITLE RES_JOB_TITLE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'RESPONSIBILITY'
	AND LOOKUP_CODE = HzOrgContactsE0.JOB_TITLE_CODE
	) RES_JOB_TITLE_CODE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ACCT_ROLE_TYPE'
	AND LOOKUP_CODE = HzRelationshipE0.RELATIONSHIP_CODE
	) RES_ROLE_TYPE 
,ContactDetailE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ContactDetailE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ContactDetailE0.CREATED_BY  RSC_CREATED_BY
,ContactDetailE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM HZ_PARTIES HzPartiesE0
,(SELECT PARTY_ID 
	FROM HZ_PARTY_USG_ASSIGNMENTS
	WHERE PARTY_USAGE_CODE = 'CUSTOMER'
	) HzPartyUsgAssignmentsE0
,HZ_CUST_ACCOUNTS HzCustAccountsE0
,HZ_CUST_ACCOUNT_ROLES HzCustAccountRolesE0
,HZ_RELATIONSHIPS HzRelationshipE0
,HZ_ORG_CONTACTS HzOrgContactsE0
,HZ_PARTIES ContactDetailE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartiesE0.PARTY_ID = HzCustAccountsE0.PARTY_ID
AND HzCustAccountsE0.CUST_ACCOUNT_ID = HzCustAccountRolesE0.CUST_ACCOUNT_ID
AND HzCustAccountRolesE0.RELATIONSHIP_ID = HzRelationshipE0.RELATIONSHIP_ID
AND HzCustAccountRolesE0.CUST_ACCT_SITE_ID IS NULL
AND HzRelationshipE0.DIRECTIONAL_FLAG = 'B'
AND HzRelationshipE0.RELATIONSHIP_ID = HzOrgContactsE0.PARTY_RELATIONSHIP_ID
AND HzRelationshipE0.OBJECT_ID = ContactDetailE0.PARTY_ID
AND HzCustAccountRolesE0.STATUS = 'A'
ORDER BY HzPartiesE0.PARTY_NUMBER
,HzCustAccountsE0.ACCOUNT_NUMBER
,ContactDetailE0.PERSON_FIRST_NAME