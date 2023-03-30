/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Banks%20-%20Email%20-%20DFF.sql $:
* $Id: Manage Banks - Email - DFF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
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
  AND LOOKUP_CODE   = EmailEO.CONTACT_POINT_PURPOSE
  )                     AS RES_PURPOSE ,
  EmailEO.EMAIL_ADDRESS AS RES_E_MAIL ,
  EmailEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE ,
  EmailEO.ATTRIBUTE1 ,
  EmailEO.ATTRIBUTE2 ,
  EmailEO.ATTRIBUTE3 ,
  EmailEO.ATTRIBUTE4 ,
  EmailEO.ATTRIBUTE5 ,
  EmailEO.ATTRIBUTE6 ,
  EmailEO.ATTRIBUTE7 ,
  EmailEO.ATTRIBUTE8 ,
  EmailEO.ATTRIBUTE9 ,
  EmailEO.ATTRIBUTE10 ,
  EmailEO.ATTRIBUTE11 ,
  EmailEO.ATTRIBUTE12 ,
  EmailEO.ATTRIBUTE13 ,
  EmailEO.ATTRIBUTE14 ,
  EmailEO.ATTRIBUTE15 ,
  EmailEO.ATTRIBUTE16 ,
  EmailEO.ATTRIBUTE17 ,
  EmailEO.ATTRIBUTE18 ,
  EmailEO.ATTRIBUTE19 ,
  EmailEO.ATTRIBUTE20 ,
  EmailEO.ATTRIBUTE21 ,
  EmailEO.ATTRIBUTE22 ,
  EmailEO.ATTRIBUTE23 ,
  EmailEO.ATTRIBUTE24 ,
  EmailEO.ATTRIBUTE25 ,
  EmailEO.ATTRIBUTE26 ,
  EmailEO.ATTRIBUTE27 ,
  EmailEO.ATTRIBUTE28 ,
  EmailEO.ATTRIBUTE29 ,
  EmailEO.ATTRIBUTE30 ,
  EmailEO.ATTRIBUTE_NUMBER1 ,
  EmailEO.ATTRIBUTE_NUMBER2 ,
  EmailEO.ATTRIBUTE_NUMBER3 ,
  EmailEO.ATTRIBUTE_NUMBER4 ,
  EmailEO.ATTRIBUTE_NUMBER5 ,
  EmailEO.ATTRIBUTE_NUMBER6 ,
  EmailEO.ATTRIBUTE_NUMBER7 ,
  EmailEO.ATTRIBUTE_NUMBER8 ,
  EmailEO.ATTRIBUTE_NUMBER9 ,
  EmailEO.ATTRIBUTE_NUMBER10 ,
  EmailEO.ATTRIBUTE_NUMBER11 ,
  EmailEO.ATTRIBUTE_NUMBER12 ,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE1, 'DD-Mon-YYYY') ATTRIBUTE_DATE1,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE2, 'DD-Mon-YYYY') ATTRIBUTE_DATE2,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE3, 'DD-Mon-YYYY') ATTRIBUTE_DATE3,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE4, 'DD-Mon-YYYY') ATTRIBUTE_DATE4,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE5, 'DD-Mon-YYYY') ATTRIBUTE_DATE5,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE6, 'DD-Mon-YYYY') ATTRIBUTE_DATE6,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE7, 'DD-Mon-YYYY') ATTRIBUTE_DATE7,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE8, 'DD-Mon-YYYY') ATTRIBUTE_DATE8,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE9, 'DD-Mon-YYYY') ATTRIBUTE_DATE9,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE10, 'DD-Mon-YYYY') ATTRIBUTE_DATE10,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE11, 'DD-Mon-YYYY') ATTRIBUTE_DATE11,
  TO_CHAR(EmailEO.ATTRIBUTE_DATE12, 'DD-Mon-YYYY') ATTRIBUTE_DATE12,
  EmailEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY ,
  EmailEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE ,
  EmailEO.CREATED_BY RSC_CREATED_BY ,
  EmailEO.CREATION_DATE RSC_CREATION_DATE ,
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
  HZ_CONTACT_POINTS EmailEO
WHERE OrganizationContactEO.PARTY_RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
AND CeContactAssignments.RELATIONSHIP_ID          = RelationshipEO.RELATIONSHIP_ID
AND(CeContactAssignments.ASSIGNMENT_TYPE          = 'BANK')
AND BankEO.BANK_PARTY_ID                          = CeContactAssignments.BANK_PARTY_ID
AND BankEO.BANK_PARTY_ID                          = RelationshipEO.SUBJECT_ID
AND RelationshipEO.OBJECT_ID                      = PersonProfileE0.PARTY_ID
AND RelationshipEO.OBJECT_ID                      = OrganizationPartyEO.PARTY_ID
AND RelationshipEO.RELATIONSHIP_TYPE              = 'CONTACT'
AND PersonProfileE0.PARTY_ID                      = EmailEO.OWNER_TABLE_ID
AND EmailEO.CONTACT_POINT_TYPE                    = 'EMAIL'
AND (EmailEO.ATTRIBUTE_CATEGORY                  IS NOT NULL
OR EmailEO.ATTRIBUTE1                            IS NOT NULL
OR EmailEO.ATTRIBUTE2                            IS NOT NULL
OR EmailEO.ATTRIBUTE3                            IS NOT NULL
OR EmailEO.ATTRIBUTE4                            IS NOT NULL
OR EmailEO.ATTRIBUTE5                            IS NOT NULL
OR EmailEO.ATTRIBUTE6                            IS NOT NULL
OR EmailEO.ATTRIBUTE7                            IS NOT NULL
OR EmailEO.ATTRIBUTE8                            IS NOT NULL
OR EmailEO.ATTRIBUTE9                            IS NOT NULL
OR EmailEO.ATTRIBUTE10                           IS NOT NULL
OR EmailEO.ATTRIBUTE11                           IS NOT NULL
OR EmailEO.ATTRIBUTE12                           IS NOT NULL
OR EmailEO.ATTRIBUTE13                           IS NOT NULL
OR EmailEO.ATTRIBUTE14                           IS NOT NULL
OR EmailEO.ATTRIBUTE15                           IS NOT NULL
OR EmailEO.ATTRIBUTE16                           IS NOT NULL
OR EmailEO.ATTRIBUTE17                           IS NOT NULL
OR EmailEO.ATTRIBUTE18                           IS NOT NULL
OR EmailEO.ATTRIBUTE19                           IS NOT NULL
OR EmailEO.ATTRIBUTE20                           IS NOT NULL
OR EmailEO.ATTRIBUTE21                           IS NOT NULL
OR EmailEO.ATTRIBUTE22                           IS NOT NULL
OR EmailEO.ATTRIBUTE23                           IS NOT NULL
OR EmailEO.ATTRIBUTE24                           IS NOT NULL
OR EmailEO.ATTRIBUTE25                           IS NOT NULL
OR EmailEO.ATTRIBUTE26                           IS NOT NULL
OR EmailEO.ATTRIBUTE27                           IS NOT NULL
OR EmailEO.ATTRIBUTE28                           IS NOT NULL
OR EmailEO.ATTRIBUTE29                           IS NOT NULL
OR EmailEO.ATTRIBUTE30                           IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER1                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER2                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER3                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER4                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER5                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER6                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER7                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER8                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER9                     IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER10                    IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER11                    IS NOT NULL
OR EmailEO.ATTRIBUTE_NUMBER12                    IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE1                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE2                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE3                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE4                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE5                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE6                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE7                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE8                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE9                       IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE10                      IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE11                      IS NOT NULL
OR EmailEO.ATTRIBUTE_DATE12                      IS NOT NULL )
ORDER BY RES_COUNTRY ,
  RES_BANK_NAME ,
  RES_CONTACT_NAME