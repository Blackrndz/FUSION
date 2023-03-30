/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Banks%20-%20Bank%20Contact.sql $:
* $Id: Manage Banks - Bank Contact.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
SELECT BankEO.COUNTRY_NAME    AS RES_COUNTRY ,
  BankEO.BANK_NAME            AS RES_BANK_NAME ,
  PersonProfileE0.PERSON_NAME AS RES_CONTACT_NAME ,
  (SELECT MEANING
  FROM fnd_lookups
  WHERE LOOKUP_TYPE = 'CONTACT_TITLE'
  AND LOOKUP_CODE   = PersonProfileE0.PERSON_PRE_NAME_ADJUNCT
  )                                  AS RES_PREFIX ,
  PersonProfileE0.PERSON_FIRST_NAME  AS RES_FIRST_NAME ,
  PersonProfileE0.PERSON_MIDDLE_NAME AS RES_MIDDLE_NAME ,
  PersonProfileE0.PERSON_LAST_NAME   AS RES_LAST_NAME ,
  PersonProfileE0.COMMENTS           AS RES_COMMENTS ,
  PersonProfileE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY ,
  PersonProfileE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE ,
  PersonProfileE0.CREATED_BY RSC_CREATED_BY ,
  PersonProfileE0.CREATION_DATE RSC_CREATION_DATE ,
  NULL RSC_LEDGER_ID ,
  NULL RSC_CHART_OF_ACCOUNTS_ID ,
  NULL RSC_BUSINESS_UNIT_ID ,
  NULL RSC_LEGAL_ENTITY_ID ,
  NULL RSC_ORGANIZATION_ID ,
  NULL RSC_BUSINESS_GROUP_ID ,
  NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANKS_V BankEO ,
  CE_CONTACT_ASSIGNMENTS CeContactAssignments ,
  HZ_RELATIONSHIPS RelationshipEO ,
  HZ_PERSON_PROFILES PersonProfileE0 ,
  HZ_PARTIES OrganizationPartyEO
WHERE BankEO.BANK_PARTY_ID               = RelationshipEO.SUBJECT_ID
AND RelationshipEO.OBJECT_ID             = PersonProfileE0.PARTY_ID
AND RelationshipEO.OBJECT_ID             = OrganizationPartyEO.PARTY_ID
AND RelationshipEO.RELATIONSHIP_TYPE     = 'CONTACT'
AND CeContactAssignments.RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
AND BankEO.BANK_PARTY_ID                 = CeContactAssignments.BANK_PARTY_ID
AND(CeContactAssignments.ASSIGNMENT_TYPE = 'BANK')
ORDER BY RES_COUNTRY ,
  RES_BANK_NAME