/* ****************************************************************************
* $Revision: 49069 $:
* $Author: Pisan.Jariyasettachok $:
* $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
* $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,BASE_ROLE RES_JOB_ROLE
,PersonSecurityProfileEO.Name RES_NAME_BASIC_DETAILS
,PersonSecurityProfileEO.PersonType RES_TYPE
,PersonSecurityProfileEO.PersonSystemType RES_SYSTEM_PERSON_TYPE
,PersonSecurityProfileEO.PersonUserType RES_USER_PERSON_TYPE
,PersonSecurityProfileEO.PersonAccess RES_ACCESS
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
	,(SELECT HcmLookupPEO.MEANING
		FROM HCM_LOOKUPS HcmLookupPEO
		WHERE HcmLookupPEO.LOOKUP_TYPE = 'PER_PRSN_SEC_PROF_PER_TYPE'
		AND HcmLookupPEO.LOOKUP_CODE   = PersonProf.PERSON_TYPE_COLUMN
		) PersonType
	,(SELECT HcmLookupPEO.MEANING
		FROM HCM_LOOKUPS HcmLookupPEO
		WHERE HcmLookupPEO.LOOKUP_TYPE = 'SYSTEM_PERSON_TYPE'
		AND HcmLookupPEO.LOOKUP_CODE   = PersonProf.SYSTEM_PERSON_TYPE
		) PersonSystemType
	,(SELECT PersonTypePEO.USER_PERSON_TYPE
		FROM PER_PERSON_TYPES_VL PersonTypePEO
		WHERE PersonTypePEO.SYSTEM_PERSON_TYPE != 'CANCELED_HIRE' AND PersonTypePEO.PERSON_TYPE_ID = PersonProf.PERSON_TYPE_ID
		) PersonUserType
	,Decode(PersonProf.ACCESS_TO, 'A', 'All', 'R', 'Restricted') PersonAccess
	,PersonProf.CREATED_BY
	,PersonProf.CREATION_DATE
	,PersonProf.LAST_UPDATED_BY
	,PersonProf.LAST_UPDATE_DATE
	,PersonProf.BUSINESS_GROUP_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_PERSON_SECURITY_PROFILES Person
	,PER_PERSON_SEC_PROF_PER_TYPES PersonProf
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID      = Person.PERSON_SECURITY_PROFILE_ID
	AND Person.PERSON_SECURITY_PROFILE_ID = PersonProf.PERSON_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT         = 'PUBLIC_PERSON'
	) PersonSecurityProfileEO
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PersonSecurityProfileEO.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE