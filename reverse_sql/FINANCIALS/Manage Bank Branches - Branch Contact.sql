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
	AND LOOKUP_CODE   = BankBranchEO.BANK_HOME_COUNTRY
	AND LANGUAGE = USERENV('LANG')
	) RES_COUNTRY
,BankBranchEO.BANK_BRANCH_NAME RES_BRANCH_NAME
,(SELECT MEANING
  FROM fnd_lookups
  WHERE LOOKUP_TYPE = 'CONTACT_TITLE'
  AND LOOKUP_CODE   = PersonProfileE0.PERSON_PRE_NAME_ADJUNCT
  )                                  AS RES_PREFIX 
,PersonProfileE0.PERSON_NAME RES_CONTACT_NAME
,PersonProfileE0.PERSON_FIRST_NAME RES_FIRST_NAME
,PersonProfileE0.PERSON_MIDDLE_NAME RES_MIDDLE_NAME
,PersonProfileE0.PERSON_LAST_NAME RES_LAST_NAME
,PersonProfileE0.COMMENTS RES_COMMENTS
,PersonProfileE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PersonProfileE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PersonProfileE0.CREATED_BY RSC_CREATED_BY
,PersonProfileE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANK_BRANCHES_V BankBranchEO
,CE_CONTACT_ASSIGNMENTS CeContactAssignments
,HZ_RELATIONSHIPS RelationshipEO
,HZ_PERSON_PROFILES PersonProfileE0
,HZ_PARTIES OrganizationPartyEO
WHERE BankBranchEO.BANK_PARTY_ID         = RelationshipEO.SUBJECT_ID
AND RelationshipEO.OBJECT_ID             = PersonProfileE0.PARTY_ID
AND RelationshipEO.OBJECT_ID             = OrganizationPartyEO.PARTY_ID
AND RelationshipEO.RELATIONSHIP_TYPE     = 'CONTACT'
AND CeContactAssignments.RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
AND BankBranchEO.BRANCH_PARTY_ID         = CeContactAssignments.BRANCH_PARTY_ID
AND(CeContactAssignments.ASSIGNMENT_TYPE = 'BRANCH')
ORDER BY BankBranchEO.BANK_NAME
,BankBranchEO.BANK_BRANCH_NAME
,PersonProfileE0.PERSON_NAME