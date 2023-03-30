/* ****************************************************************************
* $Revision$:
* $Author$:
* $Date$:
* $HeadURL$:
* $Id$:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=HRM_POOL_SECURITY_PROFILES
--RSC_PREREQUISITE_OBJECTS=HRM_POOL_SEC_PROF_JOB_FAMILIES

SELECT PerRole.role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,PerRole.BASE_ROLE RES_JOB_ROLE
,jobfamPOOLE0.NAME RES_TALENT_POOL_SECURITY_PROFI
,jobfamPOOLE0.NAME RES_NAME_BASIC_DETAILS
,(SELECT JOB_FAMILY_NAME FROM PER_JOB_FAMILY_F_VL WHERE JOB_FAMILY_ID = jobfamPOOLE0.JOB_FAMILY_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND NVL(EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_JOB_FAMILIES

,jobfamPOOLE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,jobfamPOOLE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,jobfamPOOLE0.CREATED_BY RSC_CREATED_BY
,jobfamPOOLE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,PerRole.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
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
,(SELECT jobfamPOOL.JOB_FAMILY_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	,poolPROE0.Name
	,jobfamPOOL.CREATED_BY
	,jobfamPOOL.CREATION_DATE
	,jobfamPOOL.LAST_UPDATED_BY
	,jobfamPOOL.LAST_UPDATE_DATE
	FROM HRM_POOL_SEC_PROF_JOB_FAMILIES jobfamPOOL
	,HRM_POOL_SECURITY_PROFILES poolPROE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = poolPROE0.POOL_SECURITY_PROFILE_ID
	AND poolPROE0.POOL_SECURITY_PROFILE_ID = jobfamPOOL.POOL_SECURITY_PROFILE_ID 
	AND DataE0.HR_SECURING_OBJECT    = 'TALENTPOOL'
	) jobfamPOOLE0

WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = jobfamPOOLE0.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE,RES_JOB_FAMILIES