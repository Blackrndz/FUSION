/* ****************************************************************************
 * $Revision: 78329 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-04-19 15:19:57 +0700 (Tue, 19 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Performance%20Templates%20-%20Participation.sql $:
 * $Id: Manage Performance Templates - Participation.sql 78329 2022-04-19 08:19:57Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS = HRA_ROLE_DEFNS_VL
 
SELECT pfTemplatesE0.NAME RES_NAME
,(CASE
    WHEN rolesE0.MANAGER_TYPE IS NOT NULL THEN
        rolesE0.NAME||' - '||(SELECT MEANING
            FROM FND_LOOKUP_VALUES
            WHERE LANGUAGE = USERENV('LANG')
            AND LOOKUP_TYPE = 'PER_SUPERVISOR_TYPE'
            AND LOOKUP_CODE = rolesE0.MANAGER_TYPE)
    ELSE
        rolesE0.NAME
    END) RES_PARTICIPATION_ROLE
,tmpRolesE0.MINIMUM_NUM_PCPNS RES_MINIMUM_NUMBER_OF_PARTICIP

,tmpRolesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,tmpRolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,tmpRolesE0.CREATED_BY  RSC_CREATED_BY
,tmpRolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_TMPL_ROLES tmpRolesE0
,HRA_ROLE_DEFNS_VL rolesE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = tmpRolesE0.TEMPLATE_DEFN_ID
AND tmpRolesE0.ROLE_ID = rolesE0.ROLE_ID
ORDER BY pfTemplatesE0.NAME
