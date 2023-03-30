/* ****************************************************************************
* $Revision: 49069 $:
* $Author: Pisan.Jariyasettachok $:
* $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
* $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=IRC_REQ_SEC_PROFILES

SELECT PerRole.role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,PerRole.BASE_ROLE RES_JOB_ROLE
,reqPROFILE0.NAME RES_JOB_REQUISITION_SECURITY_P
,DECODE(reqPROFILE0.ENABLED_FLAG,'Y','Yes','No')  RES_ENABLE
,DECODE(reqPROFILE0.VIEW_ALL_FLAG,'Y','Yes','No')   RES_VIEW_ALL
,DECODE(reqPROFILE0.SECURE_BY_JOB_FAMILY_FLAG,'Y','Yes','No')   RES_SECURE_BY_JOB_FAMILY
,DECODE(reqPROFILE0.SECURE_BY_JOB_FUNCTION_FLAG,'Y','Yes','No')   RES_SECURE_BY_JOB_FUNCTION
,DECODE(reqPROFILE0.SECURE_BY_LOCATION_FLAG,'Y','Yes','No')   RES_SECURE_BY_LOCATION
,DECODE(reqPROFILE0.SECURE_BY_ORGANIZATION_FLAG,'Y','Yes','No')   RES_SECURE_BY_ORGANIZATION
,DECODE(reqPROFILE0.SECURE_BY_REC_TYPE_FLAG,'Y','Yes','No')   RES_SECURE_BY_RECRUITING_TYPE

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
,PER_GEN_DATA_ROLE_PROFILES DataE0
,IRC_REQ_SEC_PROFILES reqPROFILE0
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = DataE0.GENERATED_DATA_ROLE_ID
AND DataE0.HR_SECURING_OBJECT    = 'REQUISITION'
AND DataE0.SECURITY_PROFILE_ID = reqPROFILE0.REQ_SECURITY_PROFILE_ID 
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE,reqPROFILE0.NAME