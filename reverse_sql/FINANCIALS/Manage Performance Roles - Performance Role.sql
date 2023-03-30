/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception Set $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HRA_ROLE_DEFNS_VL

SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRA_ROLE_TYPE'
    AND LOOKUP_CODE = rolesE0.ROLE_TYPE_CODE
    ) RES_ROLE_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_SUPERVISOR_TYPE'
    AND LOOKUP_CODE = rolesE0.MANAGER_TYPE
    ) RES_DEFAULT_MANAGER_TYPE
,rolesE0.NAME RES_ROLE
,rolesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(rolesE0.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(rolesE0.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(rolesE0.STATUS_CODE,'A','Active','Inactive') RES_STATUS
,DECODE(rolesE0.MATRIX_PARTICIPANT_FLAG,'Y','Yes','N','No') RES_ALLOW_ROLE_TO_VIEW_WORKER_
,rolesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rolesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rolesE0.CREATED_BY RSC_CREATED_BY
,rolesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,rolesE0.BUSINESS_GROUP_ID  RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM HRA_ROLE_DEFNS_VL rolesE0
ORDER BY rolesE0.NAME