/* ****************************************************************************
* $Revision: 49069 $:
* $Author: Pisan.Jariyasettachok $:
* $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
* $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_PERSON_SECURITY_PROFILES

SELECT role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,BASE_ROLE RES_JOB_ROLE
,PersonSecurityProfileEO.Name RES_PUBLIC_PERSON_PERSON_SECUR
,PersonSecurityProfileEO.Name RES_NAME_BASIC_DETAILS
,PersonSecurityProfileEO.PersonFlag RES_ENABLED
,PersonSecurityProfileEO.PersonAccess RES_ACCESS_TO_OWN_RECORD
,PersonSecurityProfileEO.PersonINCContact RES_INCLUDE_RELATED_CONTACTS
,PersonSecurityProfileEO.include_shared_people_info RES_INCLUDE_SHARED_PEOPLE_INFO
,PersonSecurityProfileEO.PersonVA RES_VIEW_ALL
,PersonSecurityProfileEO.PersonSecPerson RES_SECURE_BY_PERSON_TYPE
,PersonSecurityProfileEO.PersonSecMGR RES_SECURE_BY_MANAGER_HIERARCH
,PersonSecurityProfileEO.PersonAssignment RES_PERSON_OR_ASSIGNMENT_LEVEL
,PersonSecurityProfileEO.MAX_LEVELS_IN_HIERARCHY RES_MAXIMUM_LEVELS_IN_HIERARCH
,PersonSecurityProfileEO.PersonMGRType RES_MANAGER_TYPE
,PersonSecurityProfileEO.PersonMGRTypeSelected RES_MANAGER_TYPE_SELECT
,PersonSecurityProfileEO.PersonHierarchyC RES_HIERARCHY_CONTENT
,PersonSecurityProfileEO.PersonSecDept RES_SECURE_BY_DEPARTMENT
,PersonSecurityProfileEO.PersonSecDeptName RES_SECURE_BY_DEPARTMENT_NAME
,PersonSecurityProfileEO.PersonSecBU RES_SECURE_BY_BUSINESS_UNIT
,PersonSecurityProfileEO.PersonSecBUName RES_SECURE_BY_BUSINESS_UNIT_NA
,PersonSecurityProfileEO.PersonSecLegal RES_SECURE_BY_LEGAL_EMPLOYER
,PersonSecurityProfileEO.PersonSecLEGName RES_SECURE_BY_LEGAL_EMPLOYER_N
,PersonSecurityProfileEO.PersonSecPosition RES_SECURE_BY_POSITION
,PersonSecurityProfileEO.PersonSecPositionName RES_SECURE_BY_POSITION_NAME
,PersonSecurityProfileEO.PersonSecLDG RES_SECURE_BY_LEGISLATIVE_DATA
,PersonSecurityProfileEO.PersonSecLDGName RES_SECURE_BY_LEGISLATIVE_DA_0
,PersonSecurityProfileEO.PersonSecPayroll RES_SECURE_BY_PAYROLL
,PersonSecurityProfileEO.PersonSecPayrollName RES_SECURE_BY_PAYROLL_NAME
,PersonSecurityProfileEO.PersonSecGlobal RES_SECURE_BY_GLOBAL_NAME_RANG
,PersonSecurityProfileEO.GLOBAL_NAME_RANGE_START RES_FROM_PERSON_NAME
,PersonSecurityProfileEO.GLOBAL_NAME_RANGE_END RES_TO_PERSON_NAME
,PersonSecurityProfileEO.PersonSecCustom RES_SECURE_BY_CUSTOM_CRITERIA
,PersonSecurityProfileEO.CUSTOM_RESTRICTION_TEXT RES_SECURE_BY_CUSTOM_CRITERIA_
,PerGenDataRole.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PerGenDataRole.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PerGenDataRole.CREATED_BY RSC_CREATED_BY
,PerGenDataRole.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,PersonSecurityProfileEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT role.role_id
	,role.role_name
	,role.ROLE_COMMON_NAME
	,role.job_role
	,role.description
	,NULL AS BASE_ROLE
	,role.delegation_allowed
	,role.CREATED_BY
	,role.CREATION_DATE
	,role.LAST_UPDATED_BY
	,role.LAST_UPDATE_DATE
	,NULL BUSINESS_GROUP_ID
	FROM per_generated_data_roles gen
	,per_roles_dn_vl role
	,hcm_lookups lookup
	WHERE gen.data_role_id(+) = role.role_id
	AND lookup.lookup_type    = 'PER_DATA_ROLE_STATUS'
	AND lookup.lookup_code    = DECODE(role.active_flag,'Y','EXISTING','N','DELETED')
	AND(gen.base_role_id     IS NULL
	OR gen.base_role_id       = - 1)
	UNION
	SELECT gen.data_role_id role_id
	,gen.data_role_display_name
	,gen.APP_ROLE_NAME ROLE_COMMON_NAME
	,role.job_role
	,gen.data_role_description RoleDescription
	,role.role_name AS BASE_ROLE
	,gen.delegation_allowed
	,gen.CREATED_BY
	,gen.CREATION_DATE
	,gen.LAST_UPDATED_BY
	,gen.LAST_UPDATE_DATE
	,gen.BUSINESS_GROUP_ID
	FROM per_generated_data_roles gen
	,per_ldap_roles ldap
	,per_roles_dn_vl role
	,per_ldap_requests ldapreq
	,hcm_lookups lookup
	,per_roles_dn_vl datarole
	,hcm_lookups lookup1
	WHERE gen.data_role_id     = ldap.ldap_role_id (+)
	AND lookup.lookup_type(+)  = 'PER_LDAP_REQUEST_STATUS'
	AND lookup.lookup_code(+)  = ldapreq.request_status
	AND lookup1.lookup_type(+) = 'PER_DATA_ROLE_STATUS'
	AND lookup1.lookup_code(+) = 'DELETED'
	AND datarole.role_id(+)    = ldap.ldap_role_id
	AND role.role_id           = gen.base_role_id
	AND ldap.ldap_request_id   = ldapreq.ldap_request_id (+)
	) PerRole
,PER_GENERATED_DATA_ROLES PerGenDataRole
,(SELECT Person.Name
	,DECODE(Person.ENABLED_FLAG,'Y','Yes','No') PersonFlag
	,DECODE(Person.ACCESS_TO_OWN_RECORD,'Y','Yes','No') PersonAccess
	,DECODE(Person.INCLUDE_RELATED_CONTACTS,'Y','Yes','No') PersonINCContact
	,DECODE(Person.include_shared_people_info,'Y','Yes','No') include_shared_people_info
	,DECODE(Person.VIEW_ALL,'Y','Yes','No') PersonVA
	,DECODE(Person.SECURE_BY_PERSON_TYPE,'Y','Yes','No') PersonSecPerson
	,DECODE(Person.SECURE_BY_MGR_HIERARCHY,'Y','Yes','No') PersonSecMGR
	,DECODE(Person.PERSON_OR_ASSIGNMENT_LEVEL,'P','Person','A','Assignment') PersonAssignment
	,Person.MAX_LEVELS_IN_HIERARCHY
	,DECODE(Person.MANAGER_TYPES,'LINE_MGR','Line Manager','SELECTIVE_MGR','Selected','ALL_MGR','All') PersonMGRType
	,DECODE(Person.MANAGER_TYPES,'SELECTIVE_MGR','Line Manager') PersonMGRTypeSelected
	,(SELECT HcmLookupPEO.MEANING
		FROM HCM_LOOKUPS HcmLookupPEO
		WHERE HcmLookupPEO.LOOKUP_TYPE = 'PER_PRSN_SEC_PROF_MGR_HIER_FOR'
		AND HcmLookupPEO.LOOKUP_CODE   = Person.EVAL_MGR_HIERARCHY_FOR
		) PersonHierarchyC
	,DECODE(Person.SECURE_BY_DEPARTMENT,'Y','Yes','No') PersonSecDept
	,(SELECT NAME
		FROM PER_ORG_SECURITY_PROFILES
		WHERE ORG_SECURITY_PROFILE_ID = Person.DEPT_ORG_SECURITY_PROFILE_ID
		) PersonSecDeptName
	,DECODE(Person.SECURE_BY_BUSINESS_UNIT,'Y','Yes','No') PersonSecBU
	,(SELECT NAME
		FROM PER_ORG_SECURITY_PROFILES
		WHERE ORG_SECURITY_PROFILE_ID = Person.BU_ORG_SECURITY_PROFILE_ID
		) PersonSecBUName
	,DECODE(Person.SECURE_BY_LEGAL_EMPLOYER,'Y','Yes','No') PersonSecLegal
	,(SELECT NAME
		FROM PER_ORG_SECURITY_PROFILES
		WHERE ORG_SECURITY_PROFILE_ID = Person.LEG_EMP_ORG_SEC_PROFILE_ID
		) PersonSecLEGName
	,DECODE(Person.SECURE_BY_POSITION,'Y','Yes','No') PersonSecPosition
	,(SELECT NAME
		FROM PER_POSITION_SECURITY_PROFILES
		WHERE POSITION_SECURITY_PROFILE_ID = Person.POSITION_SECURITY_PROFILE_ID
		) PersonSecPositionName
	,DECODE(Person.SECURE_BY_LDG,'Y','Yes','No') PersonSecLDG
	,(SELECT NAME
		FROM PER_LDG_SECURITY_PROFILES
		WHERE LDG_SECURITY_PROFILE_ID = Person.LDG_SECURITY_PROFILE_ID
		) PersonSecLDGName
	,DECODE(Person.SECURE_BY_PAYROLL,'Y','Yes','No') PersonSecPayroll
	,(SELECT NAME
		FROM PAY_PAY_SECURITY_PROFILES
		WHERE PAY_SECURITY_PROFILE_ID = Person.PAY_SECURITY_PROFILE_ID
		) PersonSecPayrollName
	,DECODE(Person.SECURE_BY_GLOBAL_NAME_RANGE,'Y','Yes','No') PersonSecGlobal
	,Person.GLOBAL_NAME_RANGE_START
	,Person.GLOBAL_NAME_RANGE_END
	,DECODE(Person.SECURE_BY_CUSTOM_RESTRICTION,'Y','Yes','No') PersonSecCustom
	,Person.CUSTOM_RESTRICTION_TEXT
	,Person.CREATED_BY
	,Person.CREATION_DATE
	,Person.LAST_UPDATED_BY
	,Person.LAST_UPDATE_DATE
	,Person.BUSINESS_GROUP_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_PERSON_SECURITY_PROFILES Person
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = Person.PERSON_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'PUBLIC_PERSON'
	) PersonSecurityProfileEO
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PersonSecurityProfileEO.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE