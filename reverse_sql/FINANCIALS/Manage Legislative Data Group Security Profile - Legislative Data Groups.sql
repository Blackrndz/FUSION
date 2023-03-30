/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ldgSecPflsE0.NAME RES_NAME
,LegislativeGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP_NAM
,LegislativeGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LegislativeGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LegislativeGroupsE0.CREATED_BY RSC_CREATED_BY
,LegislativeGroupsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,LegislativeGroupsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PER_LDG_SECURITY_PROFILES ldgSecPflsE0
,PER_LDG_SECURITY_PROFILE_LDGS lglsE0
,PER_LEGISLATIVE_DATA_GROUPS_VL LegislativeGroupsE0
WHERE ldgSecPflsE0.LDG_SECURITY_PROFILE_ID = lglsE0.LDG_SECURITY_PROFILE_ID
AND lglsE0.LEGISLATIVE_DATA_GROUP_ID = LegislativeGroupsE0.LEGISLATIVE_DATA_GROUP_ID
ORDER BY ldgSecPflsE0.NAME
,LegislativeGroupsE0.NAME