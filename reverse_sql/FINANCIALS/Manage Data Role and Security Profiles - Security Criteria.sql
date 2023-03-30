/* ****************************************************************************
* $Revision: 80169 $:
* $Author: tanawat.wongjan $:
* $Date: 2023-02-15 19:18:22 +0700 (Wed, 15 Feb 2023) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Role%20and%20Security%20Profiles%20-%20Security%20Criteria.sql $:
* $Id: Manage Data Role and Security Profiles - Security Criteria.sql 80169 2023-02-15 12:18:22Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=IRC_REQ_SEC_PROFILES
--RSC_PREREQUISITE_OBJECTS=HRM_POOL_SECURITY_PROFILES

SELECT PerRole.role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,PerRole.BASE_ROLE RES_JOB_ROLE
,OrganizationSecurityProfileEO.Name RES_ORGANIZATION_SECURITY_PROF
,PositionSecurityProfileEO.Name RES_POSITION_POSITION_SECURITY
,CountrySecurityProfileEO.NAME RES_COUNTRY_SECURITY_PROFILE
,LDGSecurityProfileEO.NAME RES_LDG_SECURITY_PROFILE
,PersonSecurityProfileEO.NAME RES_PERSON_PERSON_SECURITY_PRO
,PublicPersonSecurityProfileEO.Name RES_PUBLIC_PERSON_PERSON_SECUR
,DocTypeProfileEO.Name RES_DOCUMENT_TYPE_SECURITY_PRO
,PayRollProfileEO.Name RES_PAYROLL_SECURITY_PROFILE
,PayFlowProfileEO.Name RES_PAYROLL_FLOW_SECURITY_PROF
,poolPROFILE0.NAME RES_TALENT_POOL_SECURITY_PROFI
,DECODE(poolPROFILE0.SECURE_BY_BUSINESS_UNIT,'Y','Yes','No') RES_TALENT_POOL_SECURE_BY_BUSI
,DECODE(poolPROFILE0.SECURE_BY_DEPARTMENT,'Y','Yes','No') RES_TALENT_POOL_SECURE_BY_DEPA
,DECODE(poolPROFILE0.SECURE_BY_JOB_FAMILY,'Y','Yes','No') RES_TALENT_POOL_SECURE_BY_JOB_
,reqPROFILE0.NAME RES_JOB_REQUISITION_SECURITY_P
,PerGenDataRole.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PerGenDataRole.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PerGenDataRole.CREATED_BY RSC_CREATED_BY
,PerGenDataRole.CREATION_DATE RSC_CREATION_DATE
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
,(SELECT Person.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_PERSON_SECURITY_PROFILES Person
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = Person.PERSON_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'PERSON'
	) PersonSecurityProfileEO
,(SELECT PPerson.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_PERSON_SECURITY_PROFILES PPerson
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = PPerson.PERSON_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'PUBLIC_PERSON'
	) PublicPersonSecurityProfileEO
,(SELECT Country.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_COUNTRY_SECURITY_PROFILES Country
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = Country.COUNTRY_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'COUNTRY'
	) CountrySecurityProfileEO
,(SELECT OrganizationE0.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_ORG_SECURITY_PROFILES OrganizationE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = OrganizationE0.ORG_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'ORGANIZATION'
	) OrganizationSecurityProfileEO
,(SELECT PostionE0.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_POSITION_SECURITY_PROFILES PostionE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = PostionE0.POSITION_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'POSITION'
	) PositionSecurityProfileEO
,(SELECT LDGE0.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_LDG_SECURITY_PROFILES LDGE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = LDGE0.LDG_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'LDG'
	) LDGSecurityProfileEO
,(SELECT DocType.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_DOC_TYPE_SECURITY_PROFILES DocType
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = DocType.DOC_TYPE_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'DOR'
	) DocTypeProfileEO
,(SELECT PayRoll.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PAY_PAY_SECURITY_PROFILES PayRoll
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = PayRoll.PAY_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'PAYROLL'
	) PayRollProfileEO
,(SELECT PayFlow.FLW_SECURITY_PROFILE_ID
	,PayFlow.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PAY_FLW_SECURITY_PROFILES PayFlow
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = PayFlow.FLW_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'FLOWPATTERN'
	) PayFlowProfileEO
,(SELECT reqPROE0.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM IRC_REQ_SEC_PROFILES reqPROE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = reqPROE0.REQ_SECURITY_PROFILE_ID 
	AND DataE0.HR_SECURING_OBJECT    = 'REQUISITION'
	) reqPROFILE0
,(SELECT poolPROE0.Name
	,DataE0.GENERATED_DATA_ROLE_ID
	,poolPROE0.SECURE_BY_BUSINESS_UNIT
	,poolPROE0.SECURE_BY_DEPARTMENT
	,poolPROE0.SECURE_BY_JOB_FAMILY
	FROM HRM_POOL_SECURITY_PROFILES poolPROE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	WHERE DataE0.SECURITY_PROFILE_ID = poolPROE0.POOL_SECURITY_PROFILE_ID  
	AND DataE0.HR_SECURING_OBJECT    = 'TALENTPOOL'
	) poolPROFILE0
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PersonSecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PublicPersonSecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = CountrySecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = OrganizationSecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PositionSecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = LDGSecurityProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = DocTypeProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = DocTypeProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PayRollProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PayFlowProfileEO.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = reqPROFILE0.GENERATED_DATA_ROLE_ID(+)
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = poolPROFILE0.GENERATED_DATA_ROLE_ID(+)
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE