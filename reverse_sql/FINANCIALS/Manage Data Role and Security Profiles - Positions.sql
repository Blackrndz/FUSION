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
,PositionSecurityProfileEO.Name RES_NAME_BASIC_DETAILS
,PositionSecurityProfileEO.PositionTopName RES_NAME_POSITION
,PositionSecurityProfileEO.POSITION_CODE RES_CODE_POSITION
,PositionSecurityProfileEO.PositionInEx RES_INCLUDE_OR_EXCLUDE_POSITIO
,PerGenDataRole.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PerGenDataRole.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PerGenDataRole.CREATED_BY RSC_CREATED_BY
,PerGenDataRole.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,PositionSecurityProfileEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
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
,(SELECT PositionE0.Name
	,PositionDPEO.Name PositionTopName
	,PositionDPEO.POSITION_CODE
	,(SELECT HcmLookupPEO.MEANING
		FROM HCM_LOOKUPS HcmLookupPEO
		WHERE HcmLookupPEO.LOOKUP_TYPE = 'INCLUDE_EXCLUDE'
		AND HcmLookupPEO.LOOKUP_CODE   = PositionProf.INCLUDE_EXCLUDE_FLAG
		) PositionInEx
	,PositionE0.CREATED_BY
	,PositionE0.CREATION_DATE
	,PositionE0.LAST_UPDATED_BY
	,PositionE0.LAST_UPDATE_DATE
	,PositionE0.BUSINESS_GROUP_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_POSITION_SECURITY_PROFILES PositionE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	,PER_POS_SEC_PROFILE_POSITIONS PositionProf
	,HR_ALL_POSITIONS_F_VL PositionDPEO
	WHERE DataE0.SECURITY_PROFILE_ID            = PositionE0.POSITION_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT               = 'POSITION'
	AND PositionE0.POSITION_SECURITY_PROFILE_ID = PositionProf.POSITION_SECURITY_PROFILE_ID
	AND PositionProf.POSITION_ID                = PositionDPEO.POSITION_ID
	) PositionSecurityProfileEO
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PositionSecurityProfileEO.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE
,RES_NAME_POSITION