/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Banks%20-%20Phone%20Numbers%20-%20DFF.sql $:
* $Id: Manage Banks - Phone Numbers - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=10024##RES##HZ_CONTACT_POINTS
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_NUMBER,ATTRIBUTE_DATE
-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.
SELECT BankEO.COUNTRY_NAME    AS RES_COUNTRY ,
  BankEO.BANK_NAME            AS RES_BANK_NAME ,
  PersonProfileE0.PERSON_NAME AS RES_CONTACT_NAME ,
  (SELECT MEANING
  FROM FND_LOOKUP_VALUES
  WHERE LOOKUP_TYPE = 'CONTACT_POINT_PURPOSE'
  AND LOOKUP_CODE   = PhoneEO.CONTACT_POINT_PURPOSE
  )                          AS RES_PURPOSE ,
  PhoneEO.PHONE_COUNTRY_CODE AS RES_PHONE_COUNTRY_CODE ,
  PhoneEO.PHONE_AREA_CODE    AS RES_AREA_CODE ,
  PhoneEO.PHONE_NUMBER       AS RES_PHONE ,
  PhoneEO.PHONE_EXTENSION    AS RES_EXTENSION ,
  PhoneEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE ,
  PhoneEO.ATTRIBUTE1 ,
  PhoneEO.ATTRIBUTE2 ,
  PhoneEO.ATTRIBUTE3 ,
  PhoneEO.ATTRIBUTE4 ,
  PhoneEO.ATTRIBUTE5 ,
  PhoneEO.ATTRIBUTE6 ,
  PhoneEO.ATTRIBUTE7 ,
  PhoneEO.ATTRIBUTE8 ,
  PhoneEO.ATTRIBUTE9 ,
  PhoneEO.ATTRIBUTE10 ,
  PhoneEO.ATTRIBUTE11 ,
  PhoneEO.ATTRIBUTE12 ,
  PhoneEO.ATTRIBUTE13 ,
  PhoneEO.ATTRIBUTE14 ,
  PhoneEO.ATTRIBUTE15 ,
  PhoneEO.ATTRIBUTE16 ,
  PhoneEO.ATTRIBUTE17 ,
  PhoneEO.ATTRIBUTE18 ,
  PhoneEO.ATTRIBUTE19 ,
  PhoneEO.ATTRIBUTE20 ,
  PhoneEO.ATTRIBUTE21 ,
  PhoneEO.ATTRIBUTE22 ,
  PhoneEO.ATTRIBUTE23 ,
  PhoneEO.ATTRIBUTE24 ,
  PhoneEO.ATTRIBUTE25 ,
  PhoneEO.ATTRIBUTE26 ,
  PhoneEO.ATTRIBUTE27 ,
  PhoneEO.ATTRIBUTE28 ,
  PhoneEO.ATTRIBUTE29 ,
  PhoneEO.ATTRIBUTE30 ,
  PhoneEO.ATTRIBUTE_NUMBER1 ,
  PhoneEO.ATTRIBUTE_NUMBER2 ,
  PhoneEO.ATTRIBUTE_NUMBER3 ,
  PhoneEO.ATTRIBUTE_NUMBER4 ,
  PhoneEO.ATTRIBUTE_NUMBER5 ,
  PhoneEO.ATTRIBUTE_NUMBER6 ,
  PhoneEO.ATTRIBUTE_NUMBER7 ,
  PhoneEO.ATTRIBUTE_NUMBER8 ,
  PhoneEO.ATTRIBUTE_NUMBER9 ,
  PhoneEO.ATTRIBUTE_NUMBER10 ,
  PhoneEO.ATTRIBUTE_NUMBER11 ,
  PhoneEO.ATTRIBUTE_NUMBER12 ,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE6, 'DD-Mon-YYYY') ATTRIBUTE_DATE6,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE7, 'DD-Mon-YYYY') ATTRIBUTE_DATE7,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE8, 'DD-Mon-YYYY') ATTRIBUTE_DATE8,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE9, 'DD-Mon-YYYY') ATTRIBUTE_DATE9,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE10, 'DD-Mon-YYYY') ATTRIBUTE_DATE10,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE11, 'DD-Mon-YYYY') ATTRIBUTE_DATE11,
  TO_CHAR(PhoneEO.ATTRIBUTE_DATE12, 'DD-Mon-YYYY') ATTRIBUTE_DATE12,
  PhoneEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY ,
  PhoneEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE ,
  PhoneEO.CREATED_BY RSC_CREATED_BY ,
  PhoneEO.CREATION_DATE RSC_CREATION_DATE ,
  NULL RSC_LEDGER_ID ,
  NULL RSC_CHART_OF_ACCOUNTS_ID ,
  NULL RSC_BUSINESS_UNIT_ID ,
  NULL RSC_LEGAL_ENTITY_ID ,
  NULL RSC_ORGANIZATION_ID ,
  NULL RSC_BUSINESS_GROUP_ID ,
  NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_ORG_CONTACTS OrganizationContactEO ,
  CE_BANKS_V BankEO ,
  CE_CONTACT_ASSIGNMENTS CeContactAssignments ,
  HZ_RELATIONSHIPS RelationshipEO ,
  HZ_PERSON_PROFILES PersonProfileE0 ,
  HZ_PARTIES OrganizationPartyEO ,
  HZ_CONTACT_POINTS PhoneEO
WHERE OrganizationContactEO.PARTY_RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
AND CeContactAssignments.RELATIONSHIP_ID          = RelationshipEO.RELATIONSHIP_ID
AND(CeContactAssignments.ASSIGNMENT_TYPE          = 'BANK')
AND BankEO.BANK_PARTY_ID                          = CeContactAssignments.BANK_PARTY_ID
AND BankEO.BANK_PARTY_ID                          = RelationshipEO.SUBJECT_ID
AND RelationshipEO.OBJECT_ID                      = PersonProfileE0.PARTY_ID
AND RelationshipEO.OBJECT_ID                      = OrganizationPartyEO.PARTY_ID
AND RelationshipEO.RELATIONSHIP_TYPE              = 'CONTACT'
AND PersonProfileE0.PARTY_ID                      = PhoneEO.OWNER_TABLE_ID
AND PhoneEO.CONTACT_POINT_TYPE                    = 'PHONE'
AND (PhoneEO.ATTRIBUTE_CATEGORY                  IS NOT NULL
OR PhoneEO.ATTRIBUTE1                            IS NOT NULL
OR PhoneEO.ATTRIBUTE2                            IS NOT NULL
OR PhoneEO.ATTRIBUTE3                            IS NOT NULL
OR PhoneEO.ATTRIBUTE4                            IS NOT NULL
OR PhoneEO.ATTRIBUTE5                            IS NOT NULL
OR PhoneEO.ATTRIBUTE6                            IS NOT NULL
OR PhoneEO.ATTRIBUTE7                            IS NOT NULL
OR PhoneEO.ATTRIBUTE8                            IS NOT NULL
OR PhoneEO.ATTRIBUTE9                            IS NOT NULL
OR PhoneEO.ATTRIBUTE10                           IS NOT NULL
OR PhoneEO.ATTRIBUTE11                           IS NOT NULL
OR PhoneEO.ATTRIBUTE12                           IS NOT NULL
OR PhoneEO.ATTRIBUTE13                           IS NOT NULL
OR PhoneEO.ATTRIBUTE14                           IS NOT NULL
OR PhoneEO.ATTRIBUTE15                           IS NOT NULL
OR PhoneEO.ATTRIBUTE16                           IS NOT NULL
OR PhoneEO.ATTRIBUTE17                           IS NOT NULL
OR PhoneEO.ATTRIBUTE18                           IS NOT NULL
OR PhoneEO.ATTRIBUTE19                           IS NOT NULL
OR PhoneEO.ATTRIBUTE20                           IS NOT NULL
OR PhoneEO.ATTRIBUTE21                           IS NOT NULL
OR PhoneEO.ATTRIBUTE22                           IS NOT NULL
OR PhoneEO.ATTRIBUTE23                           IS NOT NULL
OR PhoneEO.ATTRIBUTE24                           IS NOT NULL
OR PhoneEO.ATTRIBUTE25                           IS NOT NULL
OR PhoneEO.ATTRIBUTE26                           IS NOT NULL
OR PhoneEO.ATTRIBUTE27                           IS NOT NULL
OR PhoneEO.ATTRIBUTE28                           IS NOT NULL
OR PhoneEO.ATTRIBUTE29                           IS NOT NULL
OR PhoneEO.ATTRIBUTE30                           IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER1                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER2                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER3                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER4                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER5                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER6                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER7                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER8                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER9                     IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER10                    IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER11                    IS NOT NULL
OR PhoneEO.ATTRIBUTE_NUMBER12                    IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE1                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE2                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE3                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE4                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE5                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE6                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE7                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE8                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE9                       IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE10                      IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE11                      IS NOT NULL
OR PhoneEO.ATTRIBUTE_DATE12                      IS NOT NULL )
ORDER BY RES_COUNTRY ,
  RES_BANK_NAME ,
  RES_CONTACT_NAME