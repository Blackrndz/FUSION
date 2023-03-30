/* ****************************************************************************
* $Revision: 79059 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-07-26 13:14:46 +0700 (Tue, 26 Jul 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Data%20Role%20and%20Security%20Profiles%20-%20Organization%20Security%20Profile.sql $:
* $Id: Manage Data Role and Security Profiles - Organization Security Profile.sql 79059 2022-07-26 06:14:46Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=PER_ORG_SECURITY_PROFILES

SELECT PerRole.role_name RES_DATA_ROLE
,PerRole.ROLE_COMMON_NAME RES_DATA_ROLE_CODE
,PerRole.BASE_ROLE RES_JOB_ROLE
,OrganizationSecurityProfileEO.Name RES_ORGANIZATION_SECURITY_PROF
,OrganizationSecurityProfileEO.Name RES_NAME_BASIC_DETAILS
,OrganizationSecurityProfileEO.OrganizationFLAG RES_ENABLED
,OrganizationSecurityProfileEO.OrganizationVIEWALL RES_VIEW_ALL
,OrganizationSecurityProfileEO.OrganizationIncludefuture RES_INCLUDE_FUTURE_ORGANIZATIO
,OrganizationSecurityProfileEO.OrganizationHierarchy RES_SECURE_BY_ORGANIZATION_HIE
,OrganizationSecurityProfileEO.OrganizationHierarchyTree RES_TREE_STRUCTURE
,OrganizationSecurityProfileEO.DepartmentTreeName RES_DEPARTMENT_TREE
,OrganizationSecurityProfileEO.ORGTreeName RES_ORGANIZATION_TREE
,OrganizationSecurityProfileEO.OrganizationSelection RES_TOP_ORGANIZATION_SELECTION
,(select name
	from HR_ALL_ORGANIZATION_UNITS_F_VL HOU
	where HOU.ORGANIZATION_ID = ORGANIZATIONSECURITYPROFILEEO.ORGANIZATIONTOPORG
	AND(sysdate BETWEEN HOU.EFFECTIVE_START_DATE AND HOU.EFFECTIVE_END_DATE)
	) RES_ORGANIZATION
,OrganizationSecurityProfileEO.OrganizationINCTop RES_INCLUDE_TOP_ORGANIZATION
,OrganizationSecurityProfileEO.OrganizationSecLoc RES_SECURE_BY_ORGANIZATION_CLA
,OrganizationSecurityProfileEO.OrganizationSecList RES_SECURE_BY_ORGANIZATION_LIS
,PerGenDataRole.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PerGenDataRole.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PerGenDataRole.CREATED_BY RSC_CREATED_BY
,PerGenDataRole.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,ORGANIZATIONSECURITYPROFILEEO.ORGANIZATIONTOPORG RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,OrganizationSecurityProfileEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
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
,(SELECT OrganizationE0.Name
	,DECODE(OrganizationE0.ENABLED_FLAG,'Y','Yes','No') OrganizationFLAG
	,DECODE(OrganizationE0.VIEW_ALL,'Y','Yes','No') OrganizationVIEWALL
	,DECODE(OrganizationE0.SECURE_BY_ORG_HIERARCHY,'Y','Yes','No') OrganizationHierarchy
	,DECODE(OrganizationE0.ORG_HIER_TREE_STRUCT_CODE,'PER_ORG_TREE_STRUCTURE','Generic organization hierarchy',
		'PER_DEPT_TREE_STRUCTURE','Department hierarchy') OrganizationHierarchyTree
	,DepartmentTree.TREE_NAME DepartmentTreeName
	,ORGTree.TREE_NAME ORGTreeName
	,DECODE(OrganizationE0.TOP_ORG_SELECTION,'S','Specify organization','U',
		'Use the organization on the user''s assignment(s)') OrganizationSelection
	,OrganizationE0.TOP_ORGANIZATION_ID OrganizationTopORG
	,DECODE(OrganizationE0.INCLUDE_TOP_ORGANIZATION,'Y','Yes','No') OrganizationINCTop
	,DECODE(OrganizationE0.SECURE_BY_LOCATION,'Y','Yes','No') OrganizationSecLoc
	,DECODE(OrganizationE0.SECURE_BY_ORG_LIST,'Y','Yes','No') OrganizationSecList
	,DECODE(OrganizationE0.INCLUDE_FUTURE_ORGANIZATIONS,'Y','Yes','No') OrganizationIncludefuture
	,OrganizationE0.CREATED_BY
	,OrganizationE0.CREATION_DATE
	,OrganizationE0.LAST_UPDATED_BY
	,OrganizationE0.LAST_UPDATE_DATE
	,OrganizationE0.BUSINESS_GROUP_ID
	,DataE0.GENERATED_DATA_ROLE_ID
	FROM PER_ORG_SECURITY_PROFILES OrganizationE0
	,PER_GEN_DATA_ROLE_PROFILES DataE0
	,(SELECT FndTreeEO.TREE_NAME
		,FndTreeEO.TREE_CODE
		FROM FND_TREE_VL FndTreeEO
		,FND_TREE_VERSION_VL FndTreeVersionEO
		WHERE(FndTreeEO.TREE_STRUCTURE_CODE = FndTreeVersionEO.TREE_STRUCTURE_CODE)
		AND(FndTreeEO.TREE_CODE             = FndTreeVersionEO.TREE_CODE)
		AND(TRUNC(SYSDATE) BETWEEN FndTreeVersionEO.EFFECTIVE_START_DATE AND FndTreeVersionEO.EFFECTIVE_END_DATE)
		AND(FndTreeVersionEO.STATUS       = 'ACTIVE')
		AND(FndTreeEO.TREE_STRUCTURE_CODE = 'PER_DEPT_TREE_STRUCTURE')
		) DepartmentTree
	,(SELECT FndTreeEO.TREE_NAME
		,FndTreeEO.TREE_CODE
		FROM FND_TREE_VL FndTreeEO
		,FND_TREE_VERSION_VL FndTreeVersionEO
		WHERE(FndTreeEO.TREE_STRUCTURE_CODE = FndTreeVersionEO.TREE_STRUCTURE_CODE)
		AND(FndTreeEO.TREE_CODE             = FndTreeVersionEO.TREE_CODE)
		AND(TRUNC(SYSDATE) BETWEEN FndTreeVersionEO.EFFECTIVE_START_DATE AND FndTreeVersionEO.EFFECTIVE_END_DATE)
		AND(FndTreeVersionEO.STATUS       = 'ACTIVE')
		AND(FndTreeEO.TREE_STRUCTURE_CODE = 'PER_ORG_TREE_STRUCTURE')
		) ORGTREE
	WHERE DataE0.SECURITY_PROFILE_ID = OrganizationE0.ORG_SECURITY_PROFILE_ID
	AND DataE0.HR_SECURING_OBJECT    = 'ORGANIZATION'
	AND OrganizationE0.ORG_HIER_TREE_CODE     = DepartmentTree.TREE_CODE(+)
	AND OrganizationE0.ORG_HIER_TREE_CODE     = ORGTREE.TREE_CODE(+)
	) OrganizationSecurityProfileEO
WHERE PerRole.ROLE_ID                     = PerGenDataRole.DATA_ROLE_ID
AND PerGenDataRole.GENERATED_DATA_ROLE_ID = OrganizationSecurityProfileEO.GENERATED_DATA_ROLE_ID
ORDER BY RES_DATA_ROLE,RES_DATA_ROLE_CODE