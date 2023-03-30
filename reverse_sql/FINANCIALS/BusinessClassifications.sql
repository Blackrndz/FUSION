/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-09-14  $:
 * $HeadURL: $:
 * $Id: Manage Suppliers - Supplier Business Classifications.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=POZ_BUS_CLASSIFICATIONS 
-- STRICTLY_BATCH_SEQ = RES_SUPPLIER_NAME,RES_CLASSIFICATION

SELECT 'CREATE' RES_IMPORT_ACTION
,(SELECT PARTY_NAME
	FROM HZ_PARTIES 
	WHERE PARTY_ID = BusinessClassificationsEO.PARTY_ID  
	) RES_SUPPLIER_NAME
,BusinessClassificationsEO.LOOKUP_CODE RES_CLASSIFICATION
,NULL RES_CLASSIFICATION_NEW
,BusinessClassificationsEO.EXT_ATTR_1 RES_SUBCLASSIFICATION
,PozCertifyingAgencyEO.NAME RES_CERTIFYING_AGENCY
,BusinessClassificationsEO.OTHER_CERTIFYING_AGENCY RES_CERTIFYING_AGENCY_NEW
,NULL RES_CREATE_CERTIFYING_AGENCY
,BusinessClassificationsEO.CERTIFICATE_NUMBER RES_CERTIFICATE_NUMBER
,NULL RES_CERTIFICATE_NUMBER_NEW
,TO_CHAR(BusinessClassificationsEO.START_DATE_ACTIVE,'YYYY/MM/DD') RES_START_DATE
,TO_CHAR(BusinessClassificationsEO.EXPIRATION_DATE,'YYYY/MM/DD') RES_EXPIRATION_DATE
,BusinessClassificationsEO.NOTES RES_NOTES
,POZ_UTIL.FORMAT_NAME(PartyPEO.PERSON_FIRST_NAME,PartyPEO.PERSON_LAST_NAME) RES_PROVIDED_BY_FIRST_NAME
,NULL RES_PROVIDED_BY_LAST_NAME
,NULL RES_PROVIDED_BY_E_MAIL
,NULL RES_BATCH_ID
,'END' RES_END
,BusinessClassificationsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BusinessClassificationsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BusinessClassificationsEO.CREATED_BY RSC_CREATED_BY
,BusinessClassificationsEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POZ_BUS_CLASSIFICATIONS BusinessClassificationsEO
,POZ_CERTIFYING_AGENCIES PozCertifyingAgencyEO
,HZ_PARTIES PartyPEO
,HZ_RELATIONSHIPS RelationshipPEO
WHERE businessclassificationseo.certifying_agency_id   = POZCERTIFYINGAGENCYEO.AGENCY_ID(+)
AND BusinessClassificationsEO.PROVIDED_BY_CONTACT_ID = RelationshipPEO.SUBJECT_ID(+)
AND BusinessClassificationsEO.PROVIDED_BY_CONTACT_ID = PartyPEO.PARTY_ID(+)
AND (RelationshipPEO.RELATIONSHIP_ID                IS NULL
	OR (RelationshipPEO.RELATIONSHIP_TYPE                = 'CONTACT'
	AND RelationshipPEO.RELATIONSHIP_CODE                = 'CONTACT_OF'
	AND RelationshipPEO.SUBJECT_TYPE                     = 'PERSON'
	AND RelationshipPEO.SUBJECT_TABLE_NAME               = 'HZ_PARTIES'
	AND RelationshipPEO.OBJECT_TYPE                      = 'ORGANIZATION'
	AND RelationshipPEO.OBJECT_TABLE_NAME                = 'HZ_PARTIES'
	AND BusinessClassificationsEO.PARTY_ID               = RelationshipPEO.OBJECT_ID
	AND RelationshipPEO.STATUS                           = 'A'))
AND NVL(BusinessClassificationsEO.DELETED, 'N') <> 'Y'
ORDER BY BusinessClassificationsEO.LAST_UPDATE_DATE DESC
,BUSINESSCLASSIFICATIONSEO.EXPIRATION_DATE DESC
,BusinessClassificationsEO.LOOKUP_CODE