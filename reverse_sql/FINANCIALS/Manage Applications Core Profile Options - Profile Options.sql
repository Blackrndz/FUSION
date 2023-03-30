/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Applications Core Profile Options - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
/*<RSC_PRE_STEPS_LARGE_COLUMN_POSITION>6</RSC_PRE_STEPS_LARGE_COLUMN_POSITION>
	
-- The column position that using special data type.
 <RSC_PRE_STEPS_LARGE_COLUMN_TYPE>LONG</RSC_PRE_STEPS_LARGE_COLUMN_TYPE>

-- Specify what type of the data.
*/

 
SELECT ProfileOptionEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,ProfileOptionEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,AppNameE0.APPLICATION_NAME RES_APPLICATION
,ApplTaxonomyPEO.USER_MODULE_NAME RES_MODULE
,ProfileOptionEO.DESCRIPTION RES_DESCRIPTION
,ProfileOptionEO.SQL_VALIDATION RES_SQL_VALIDATION
,TO_CHAR(ProfileOptionEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ProfileOptionEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE

,ProfileOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
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
,FND_APPLICATION_VL AppNameE0
WHERE ProfileOptionEO.MODULE_ID = ApplTaxonomyPEO.MODULE_ID
AND ProfileOptionEO.APPLICATION_ID = AppNameE0.APPLICATION_ID
AND(ProfileOptionEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'FND'
	AND at.module_id     = rf.ancestor_module_id
	))
ORDER BY ProfileOptionEO.PROFILE_OPTION_NAME