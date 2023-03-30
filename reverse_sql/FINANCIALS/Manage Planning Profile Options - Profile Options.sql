/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-04-19 $:
 * $HeadURL:  $:
 * $Id: Manage Receiving Profile Options - Profile Options.sql $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ProfileOptionEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,ProfileOptionEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionEO.last_update_date RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_APPL_TAXONOMY_VL ApplTaxonomyPEO
WHERE ProfileOptionEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID
AND (ProfileOptionEO.MODULE_ID IN
  (SELECT rf.child_module_id
  FROM fnd_appl_taxonomy_rf rf,
    fnd_appl_taxonomy at
  WHERE at.module_type = 'APPLICATION'
  AND at.module_key    = 'MSC'
  AND at.module_id     = rf.ancestor_module_id
  ))
ORDER BY ProfileOptionEO.PROFILE_OPTION_NAME