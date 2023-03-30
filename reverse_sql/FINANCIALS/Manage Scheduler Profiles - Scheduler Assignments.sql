/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HXT_SETUP_PROFILES_VL

SELECT profilesE0.NAME RES_PROFILE_NAME
,(SELECT LIST_NAME
    FROM PER_PERSON_NAMES_F
    WHERE NAME_TYPE = 'GLOBAL'
    AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND PERSON_ID = assingsE0.INCL_MEMBER_ID
    ) RES_SCHEDULER_NAME
,(SELECT PERSON_NUMBER
    FROM PER_ALL_PEOPLE_F
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND PERSON_ID = assingsE0.INCL_MEMBER_ID
    ) RES_SCHEDULER_NUMBER
,assingsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,assingsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,assingsE0.CREATED_BY RSC_CREATED_BY
,assingsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,profilesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HXT_SETUP_PROFILES_VL profilesE0
,HXT_SETUP_PROFILE_ASGS assignmentsE0
,HWM_GRPS_B groupsE0
,HWM_GRP_INCL_MEMBERS assingsE0
WHERE profilesE0.PRODUCT_AREA = 'HTS'
AND profilesE0.SETUP_PROFILE_ID = assignmentsE0.SETUP_PROFILE_ID
AND assignmentsE0.OBJECT_ID = groupsE0.GRP_ID
AND groupsE0.GRP_ID = assingsE0.GRP_ID
ORDER BY profilesE0.NAME