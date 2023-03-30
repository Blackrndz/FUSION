/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PartyPEO.PARTY_NAME RES_PERSON_NAME
,PartyPEO.PARTY_NUMBER RES_REGISTRY_ID
,(SELECT MEANING
	FROM HZ_LOOKUPS
	WHERE LOOKUP_TYPE = 'JTF_RS_USAGE_FILTER'
	AND LOOKUP_CODE = PartyUsageAssignmentPEO.PARTY_USAGE_CODE
	) RES_USAGE
,TO_CHAR(ResourceEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(ResourceEO.END_DATE_ACTIVE,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(ResourceEO.END_DATE_ACTIVE,'DD-Mon-YYYY')) RES_TO_DATE
,ORGRuleE0.NAME RES_ORGANIZATION
,ORGRuleE0.ROLE_NAME RES_ROLE
,SetE0.SET_CODE RES_SET
,SetE0.SALES_CREDIT_TYPE_ID RES_SALES_CREDIT_TYPE
,SetE0.SALES_TAX_GEOCODE RES_SALES_TAX_GEOGRAPHY
,DECODE(SetE0.SALES_TAX_INSIDE_CITY_LIMITS,'1','Yes','No') RES_INSIDE_CITY_LIMITS
,ResourceEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ResourceEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ResourceEO.CREATED_BY RSC_CREATED_BY
,ResourceEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM JTF_RS_RESOURCE_PROFILES ResourceEO
,HZ_PARTIES PartyPEO
,(SELECT PARTY_ID
	,PARTY_USAGE_CODE
	FROM HZ_PARTY_USG_ASSIGNMENTS
	WHERE PARTY_USAGE_CODE <> 'RESOURCE'
	) PartyUsageAssignmentPEO
,(SELECT PERSON_ID
	FROM PER_ALL_PEOPLE_F 
	WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) PersonDPEONQ1
,HZ_ORIG_SYS_REFERENCES OrigSysRefPEONQ1
,(SELECT PartyPEO.PARTY_ID
	,OrganizationUnitPEO.NAME
	,OrganizationUnitPEO.ORGANIZATION_ID
	,ResourceRole.ROLE_NAME
	FROM JTF_RS_GROUP_MEMBERS ResourceOrganizationMember
	,JTF_RS_ROLE_RELATIONS ResourceRoleAssign
	,JTF_RS_ROLES_VL ResourceRole
	,HZ_PARTIES PartyPEO
	,HR_ALL_ORGANIZATION_UNITS_F_VL OrganizationUnitPEO
	WHERE ResourceOrganizationMember.GROUP_MEMBER_ID = ResourceRoleAssign.ROLE_RESOURCE_ID
	AND('RS_GROUP_MEMBER')                           = ResourceRoleAssign.ROLE_RESOURCE_TYPE
	AND ResourceRoleAssign.ROLE_ID                   = ResourceRole.ROLE_ID
	AND ResourceOrganizationMember.RESOURCE_ID       = PartyPEO.PARTY_ID
	AND ResourceOrganizationMember.GROUP_ID          = OrganizationUnitPEO.ORGANIZATION_ID
	AND(((ResourceOrganizationMember.DELETE_FLAG    <> 'Y')
	AND(ResourceRoleAssign.ROLE_RESOURCE_TYPE        = 'RS_GROUP_MEMBER')
	AND(ResourceRoleAssign.DELETE_FLAG              <> 'Y')))
	AND(sysdate BETWEEN OrganizationUnitPEO.EFFECTIVE_START_DATE AND OrganizationUnitPEO.EFFECTIVE_END_DATE)
	) ORGRuleE0
,(SELECT ResourceSalesrep.RESOURCE_ID
	,SetIdSetPEO.SET_CODE
	,ResourceSalesrep.SALES_CREDIT_TYPE_ID
	,ResourceSalesrep.SALES_TAX_GEOCODE
	,ResourceSalesrep.SALES_TAX_INSIDE_CITY_LIMITS
	FROM JTF_RS_SALESREPS ResourceSalesrep
	,FND_SETID_SETS_VL SetIdSetPEO
	WHERE ResourceSalesrep.SET_ID = SetIdSetPEO.SET_ID
	AND(ResourceSalesrep.STATUS   = 'A')
	) SetE0
WHERE ResourceEO.PARTY_ID                    = PartyPEO.PARTY_ID
AND ResourceEO.PARTY_ID                        = PartyUsageAssignmentPEO.PARTY_ID
AND TO_CHAR(PersonDPEONQ1.PERSON_ID)         = OrigSysRefPEONQ1.ORIG_SYSTEM_REFERENCE
AND ResourceEO.PARTY_ID                      = OrigSysRefPEONQ1.OWNER_TABLE_ID
AND ResourceEO.PARTY_ID = ORGRuleE0.PARTY_ID(+)
AND ResourceEO.PARTY_ID = SetE0.RESOURCE_ID(+)
ORDER BY RES_PERSON_NAME
,RES_REGISTRY_ID
,RES_USAGE
,RES_FROM_DATE