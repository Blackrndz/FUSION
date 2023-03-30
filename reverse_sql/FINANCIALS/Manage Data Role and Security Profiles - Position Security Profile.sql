/* ****************************************************************************
* $Revision: 49069 $:
* $Author: Pisan.Jariyasettachok $:
* $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
* $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_POSITION_SECURITY_PROFILES

SELECT role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,BASE_ROLE RES_JOB_ROLE
,PositionSecurityProfileEO.Name RES_POSITION_POSITION_SECURITY
,PositionSecurityProfileEO.Name RES_NAME_BASIC_DETAILS
,PositionSecurityProfileEO.PositionFlag RES_ENABLED
,PositionSecurityProfileEO.PositionVA RES_VIEW_ALL
,PositionSecurityProfileEO.include_future_positions    RES_INCLUDE_FUTURE_POSITIONS
,PositionSecurityProfileEO.PositionSecHierarchy RES_SECURE_BY_POSITION_HIERARC
,PositionSecurityProfileEO.PositionTreeStructure RES_TREE_STRUCTURE
,PositionSecurityProfileEO.TREE_NAME RES_POSITION_TREE
,PositionSecurityProfileEO.PositionTopSelection RES_TOP_POSITION_SELECTION
,PositionSecurityProfileEO.PositionTopName RES_POSITION_NAME
,PositionSecurityProfileEO.POSITION_CODE RES_POSITION_CODE
,PositionSecurityProfileEO.PositionINCTopPosition RES_INCLUDE_TOP_POSITION
,PositionSecurityProfileEO.PositionSecDept RES_SECURE_BY_DEPARTMENT
,PositionSecurityProfileEO.PositionSecDeptName RES_NAME_SECURE_BY_DEPARTMENT
,PositionSecurityProfileEO.PositionSecBU RES_SECURE_BY_BUSINESS_UNIT
,PositionSecurityProfileEO.PositionSecBUName RES_NAME_SECURE_BY_BUSINESS_UN
,PositionSecurityProfileEO.PositionSecList RES_SECURE_BY_POSITIONS_LIST
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
	,DECODE(PositionE0.ENABLED_FLAG,'Y','Yes','No') PositionFlag
	,DECODE(PositionE0.VIEW_ALL,'Y','Yes','No') PositionVA
	,DECODE(PositionE0.SECURE_BY_POSITION_HIERARCHY,'Y','Yes','No') PositionSecHierarchy
	,DECODE(PositionE0.POS_HIERARCHY_TREE_STRUCT_CODE,'PER_POS_TREE_STRUCTURE','Position Tree Structure')
		PositionTreeStructure
	,FndTreeEO.TREE_NAME
	,(SELECT HcmLookupPEO.MEANING
		FROM HCM_LOOKUPS HcmLookupPEO
		WHERE HcmLookupPEO.LOOKUP_TYPE = 'PER_POS_SEC_PROF_TOP_POS_SEL'
		AND HcmLookupPEO.LOOKUP_CODE   = PositionE0.TOP_POS_SELECTION
		) PositionTopSelection
	,PositionDPEO.Name PositionTopName
	,PositionDPEO.POSITION_CODE
	,DECODE(PositionE0.INCLUDE_TOP_POSITION,'Y','Yes','No') PositionINCTopPosition
	,DECODE(PositionE0.SECURE_BY_DEPARTMENT,'Y','Yes','No') PositionSecDept
	,(SELECT NAME
		FROM PER_ORG_SECURITY_PROFILES
		WHERE ORG_SECURITY_PROFILE_ID = PositionE0.DEPT_ORG_SECURITY_PROFILE_ID
		) PositionSecDeptName
	,DECODE(PositionE0.SECURE_BY_BUSINESS_UNIT,'Y','Yes','No') PositionSecBU
	,(SELECT NAME
		FROM PER_ORG_SECURITY_PROFILES
		WHERE ORG_SECURITY_PROFILE_ID = PositionE0.BU_ORG_SECURITY_PROFILE_ID
		) PositionSecBUName
	,DECODE(PositionE0.SECURE_BY_POSITION_LIST,'Y','Yes','No') PositionSecList
	,PositionE0.CREATED_BY
	,PositionE0.CREATION_DATE
	,PositionE0.LAST_UPDATED_BY
	,PositionE0.LAST_UPDATE_DATE
	,PositionE0.BUSINESS_GROUP_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	,DECODE(PositionE0.include_future_positions,'Y','Yes','No') include_future_positions
	FROM PER_POSITION_SECURITY_PROFILES PositionE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	,FND_TREE_VL FndTreeEO
	,HR_ALL_POSITIONS_F_VL PositionDPEO
	WHERE DataE0.SECURITY_PROFILE_ID       = PositionE0.POSITION_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT          = 'POSITION'
	AND PositionE0.POS_HIERARCHY_TREE_CODE = FndTreeEO.TREE_CODE(+)
	AND PositionE0.TOP_POSITION_ID = PositionDPEO.POSITION_ID(+)
	) PositionSecurityProfileEO
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = PositionSecurityProfileEO.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE