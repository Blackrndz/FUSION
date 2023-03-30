/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-09-11  $:
 * $HeadURL: $:
 * $Id: Manage Suppliers - Supplier Contact Addresses.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- STRICTLY_BATCH_SEQ = RES_SUPPLIER_NAME,RES_ADDRESS_NAME,RES_FIRST_NAME,RES_LAST_NAME

SELECT 'CREATE' RES_IMPORT_ACTION
,(SELECT PersonParty.PARTY_NAME 
	FROM HZ_PARTIES PersonParty
	WHERE PersonParty.PARTY_ID = QRSLT.SUPPLIER_PARTY_ID
	) RES_SUPPLIER_NAME
,(SELECT PARTY_SITE_NAME
	FROM HZ_PARTY_SITES
	WHERE PARTY_SITE_ID = supContactsE0.PARTY_SITE_ID
	) RES_ADDRESS_NAME
,QRSLT.FIRST_NAME RES_FIRST_NAME
,QRSLT.LAST_NAME RES_LAST_NAME
,QRSLT.EMAIL_ADDRESS RES_E_MAIL
,NULL RES_BATCH_ID
,'END' RES_END
,QRSLT.RSC_LAST_UPDATED_BY
,QRSLT.RSC_LAST_UPDATE_DATE
,QRSLT.RSC_CREATED_BY
,QRSLT.RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,supContactsE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT PersonParty.PERSON_FIRST_NAME FIRST_NAME
	,PersonParty.PERSON_LAST_NAME LAST_NAME
	,Relationship.OBJECT_ID SUPPLIER_PARTY_ID
	,Email.EMAIL_ADDRESS
	,PersonParty.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
	,PersonParty.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
	,PersonParty.CREATED_BY RSC_CREATED_BY
	,PersonParty.CREATION_DATE RSC_CREATION_DATE
	,PersonParty.party_name
	,Relationship.RELATIONSHIP_ID 
	FROM HZ_PARTIES PersonParty
	,HZ_RELATIONSHIPS Relationship
	,HZ_PARTY_USG_ASSIGNMENTS PartyUsageAssignment
	,HZ_ORG_CONTACTS OrgContact
	,HZ_CONTACT_POINTS Email
	WHERE PersonParty.STATUS = 'A'
	AND (Relationship.SUBJECT_ID = PersonParty.PARTY_ID 
	and Relationship.RELATIONSHIP_TYPE = 'CONTACT' 
	and Relationship.RELATIONSHIP_CODE = 'CONTACT_OF' 
	and Relationship.SUBJECT_TYPE = 'PERSON' 
	and Relationship.SUBJECT_TABLE_NAME = 'HZ_PARTIES' 
	and Relationship.OBJECT_TYPE = 'ORGANIZATION' 
	and Relationship.OBJECT_TABLE_NAME = 'HZ_PARTIES' 
	and Relationship.STATUS = 'A')
	AND OrgContact.PARTY_RELATIONSHIP_ID(+) = Relationship.RELATIONSHIP_ID 
	AND (PersonParty.PARTY_ID = PartyUsageAssignment.PARTY_ID 
	AND PartyUsageAssignment.PARTY_USAGE_CODE = 'SUPPLIER_CONTACT' 
	AND PartyUsageAssignment.STATUS_FLAG = 'A' 
	AND PartyUsageAssignment.OWNER_TABLE_ID = Relationship.RELATIONSHIP_ID 
	AND PartyUsageAssignment.OWNER_TABLE_NAME = 'HZ_RELATIONSHIPS' ) 
	AND (Email.OWNER_TABLE_NAME(+) = 'HZ_PARTIES'  
	and Email.OWNER_TABLE_ID(+) =  Relationship.SUBJECT_ID 
	and Email.RELATIONSHIP_ID(+) = Relationship.RELATIONSHIP_ID 
	and Email.CONTACT_POINT_TYPE(+) = 'EMAIL' 
	and Email.PRIMARY_FLAG(+) = 'Y' 
	and Email.STATUS(+) = 'A')   
	
	UNION
	
	SELECT ContactRequest.FIRST_NAME
	,ContactRequest.LAST_NAME
	,RequestMapping.PARTY_ID SUPPLIER_PARTY_ID
	,ContactRequest.EMAIL_ADDRESS
	,ContactRequest.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
	,ContactRequest.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
	,ContactRequest.CREATED_BY RSC_CREATED_BY
	,ContactRequest.CREATION_DATE RSC_CREATION_DATE
	,NULL party_name
	,CAST(NULL AS NUMBER) RELATIONSHIP_ID
	FROM POZ_CONTACT_REQUESTS ContactRequest
	,POZ_SUPPLIER_MAPPINGS RequestMapping
	,POZ_UP_REQUESTS UserRequests
	WHERE ContactRequest.REQUEST_STATUS = 'PENDING'
	and ContactRequest.REQUEST_TYPE = 'ADD'
	and ContactRequest.contact_party_id is null
	and ContactRequest.MAPPING_ID = RequestMapping.MAPPING_ID 
	and ContactRequest.contact_request_id = UserRequests.contact_request_id (+)
	) QRSLT  
,(SELECT CONTACT.RELATIONSHIP_ID
	,CONTACT.PARTY_SITE_ID
	,SUPSITE.PRC_BU_ID
	FROM POZ_SUPPLIER_CONTACTS CONTACT
	,POZ_SUPPLIER_SITES_ALL_M SUPSITE
	WHERE SUPSITE.PARTY_SITE_ID = CONTACT.PARTY_SITE_ID
	AND NVL(SUPSITE.INACTIVE_DATE,TO_DATE('4712/12/31','YYYY/MM/DD')) > SYSDATE
	) supContactsE0
WHERE QRSLT.RELATIONSHIP_ID = supContactsE0.RELATIONSHIP_ID(+)