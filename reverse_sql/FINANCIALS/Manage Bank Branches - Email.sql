/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT BankBranchEO.BANK_NAME RES_BANK
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'HZ_DOMAIN_SUFFIX_LIST'
	AND language  = userenv('LANG')
	AND LOOKUP_CODE   = BankBranchEO.BANK_HOME_COUNTRY
	) RES_COUNTRY
,BankBranchEO.BANK_BRANCH_NAME RES_BRANCH_NAME
,PersonProfileE0.PERSON_NAME RES_CONTACT_NAME
,DECODE(EmailEO.PRIMARY_FLAG,'Y','Yes','No') RES_PRIMARY
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LOOKUP_TYPE = 'CONTACT_POINT_PURPOSE'
	AND language  = userenv('LANG')
	AND LOOKUP_CODE   = EmailEO.CONTACT_POINT_PURPOSE
	) RES_PURPOSE
,EmailEO.EMAIL_ADDRESS RES_E_MAIL
,EmailEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,EmailEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,EmailEO.CREATED_BY RSC_CREATED_BY
,EmailEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_ORG_CONTACTS OrganizationContactEO
,CE_BANK_BRANCHES_V BankBranchEO
,CE_CONTACT_ASSIGNMENTS CeContactAssignments
,HZ_RELATIONSHIPS RelationshipEO
,HZ_PERSON_PROFILES PersonProfileE0
,HZ_PARTIES OrganizationPartyEO
,HZ_CONTACT_POINTS EmailEO
WHERE OrganizationContactEO.PARTY_RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
AND CeContactAssignments.RELATIONSHIP_ID          = RelationshipEO.RELATIONSHIP_ID
AND(CeContactAssignments.ASSIGNMENT_TYPE          = 'BRANCH')
AND BankBranchEO.BRANCH_PARTY_ID                  = CeContactAssignments.BRANCH_PARTY_ID
AND BankBranchEO.BANK_PARTY_ID                    = RelationshipEO.SUBJECT_ID
AND RelationshipEO.OBJECT_ID                      = PersonProfileE0.PARTY_ID
AND RelationshipEO.OBJECT_ID                      = OrganizationPartyEO.PARTY_ID
AND RelationshipEO.RELATIONSHIP_TYPE              = 'CONTACT'
AND PersonProfileE0.PARTY_ID                      = EmailEO.OWNER_TABLE_ID
AND EmailEO.CONTACT_POINT_TYPE                    = 'EMAIL'
ORDER BY BankBranchEO.BANK_NAME
,BankBranchEO.BANK_BRANCH_NAME
,PersonProfileE0.PERSON_NAME