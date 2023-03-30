/* ****************************************************************************
 * $Revision: 53609 $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2016-07-13 10:53:25 +0700  $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Accounting%20Calendars%20-%20Additional%20Year.sql $:
 * $Id: Manage Bank Accounts - Phone Numbers.sql 53609 2016-07-13 03:53:25Z  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT Head.BANK_NAME RES_BANK
,Head.COUNTRY_NAME RES_COUNTRY
,Head.BANK_BRANCH_NAME RES_BANK_BRANCH
,Head.BANK_ACCOUNT_NAME RES_ACCOUNT_NAME
,Head.BANK_ACCOUNT_NUM RES_ACCOUNT_NUMBER
,Detail.PARTY_NAME RES_CONTACT_NAME
,DECODE(Detail.PRIMARY_FLAG,'Y','Yes','No') RES_PRIMARY
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CONTACT_POINT_PURPOSE'
	AND LOOKUP_CODE   = Detail.CONTACT_POINT_PURPOSE
	) RES_PURPOSE
,Detail.PHONE_COUNTRY_CODE RES_PHONE_COUNTRY_CODE
,Detail.PHONE_AREA_CODE RES_AREA_CODE
,Detail.PHONE_NUMBER RES_PHONE
,Detail.PHONE_EXTENSION RES_EXTENSION
,Detail.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY RSC_CREATED_BY
,Detail.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,Head.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT CeBankAccounts.BANK_ACCOUNT_ID
	,BankBranchSimplePEO.BANK_NAME
	,BankBranchSimplePEO.COUNTRY_NAME
	,BankBranchSimplePEO.BANK_BRANCH_NAME
	,CeBankAccounts.BANK_ACCOUNT_NAME
	,CeBankAccounts.BANK_ACCOUNT_NUM
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
    FROM CE_BANK_ACCOUNTS CeBankAccounts
	,XLE_ENTITY_PROFILES XleEntityProfiles
	,CE_BANK_BRANCHES_SIMPLE_V BankBranchSimplePEO
	,CE_RECON_RULESETS BankStatementReconRuleSetPEO
    WHERE ((CeBankAccounts.ACCOUNT_OWNER_ORG_ID = XleEntityProfiles.LEGAL_ENTITY_ID)
	AND (CeBankAccounts.BANK_BRANCH_ID = BankBranchSimplePEO.BRANCH_PARTY_ID)
	AND (CeBankAccounts.RECON_RULESET_ID = BankStatementReconRuleSetPEO.RECON_RULESET_ID (+))
	AND NOT EXISTS
	(SELECT xtr.bank_account_id
		FROM ce_bank_accounts xtr
		WHERE NVL(AP_USE_ALLOWED_FLAG, 'N') = 'N'
		AND NVL(AR_USE_ALLOWED_FLAG, 'N')   = 'N'
		AND NVL(PAY_USE_ALLOWED_FLAG, 'N')  = 'N'
		AND NVL(XTR_USE_ALLOWED_FLAG, 'N')  = 'Y'
		AND xtr.bank_account_id = CeBankAccounts.bank_account_id))
	) Head
,(SELECT CeContactAssignments.BANK_ACCOUNT_ID
	,SubjectPartyEO.PARTY_NAME
	,PhoneEO.PRIMARY_FLAG
	,PhoneEO.CONTACT_POINT_PURPOSE
	,PhoneEO.PHONE_COUNTRY_CODE 
	,PhoneEO.PHONE_AREA_CODE 
	,PhoneEO.PHONE_NUMBER 
	,PhoneEO.PHONE_EXTENSION 
	,PhoneEO.LAST_UPDATED_BY 
	,PhoneEO.LAST_UPDATE_DATE 
	,PhoneEO.CREATED_BY 
	,PhoneEO.CREATION_DATE 
	FROM CE_CONTACT_ASSIGNMENTS CeContactAssignments
	,HZ_RELATIONSHIPS RelationshipEO
	,HZ_ORG_CONTACTS OrganizationContactEO
	,HZ_PARTY_SITES ContactPartySiteEO
	,HZ_PARTIES SubjectPartyEO
	,HZ_CONTACT_POINTS PhoneEO
	WHERE CeContactAssignments.RELATIONSHIP_ID = RelationshipEO.RELATIONSHIP_ID
	AND RelationshipEO.RELATIONSHIP_ID = OrganizationContactEO.PARTY_RELATIONSHIP_ID(+)
	AND RelationshipEO.RELATIONSHIP_ID = ContactPartySiteEO.RELATIONSHIP_ID(+)
	AND RelationshipEO.SUBJECT_ID = ContactPartySiteEO.PARTY_ID(+)
	AND RelationshipEO.RELATIONSHIP_ID = PhoneEO.RELATIONSHIP_ID(+)
	AND RelationshipEO.SUBJECT_ID = PhoneEO.OWNER_TABLE_ID(+)
	AND PhoneEO.OWNER_TABLE_NAME(+) = 'HZ_PARTIES'
	AND CeContactAssignments.ASSIGNMENT_TYPE = 'ACCOUNT' 
	AND PhoneEO.CONTACT_POINT_TYPE = 'PHONE'
	AND RelationshipEO.SUBJECT_ID = SubjectPartyEO.PARTY_ID
	) Detail
WHERE Head.BANK_ACCOUNT_ID = Detail.BANK_ACCOUNT_ID
ORDER BY RES_BANK 
,RES_COUNTRY 
,RES_ACCOUNT_NAME
,RES_CONTACT_NAME