/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Subledger%20Accounting%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Subledger Accounting Profile Options - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select PROFILEOPTIONEO.PROFILE_OPTION_NAME	RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME	RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY  as RSC_LAST_UPDATED_BY
,ProfileOptionEO.last_update_date  as RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY  RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
where ProfileOptionEO.MODULE_ID IN (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,FND_APPL_TAXONOMY AT
	WHERE AT.MODULE_TYPE = 'LBA'
	AND at.module_key    = 'FinXlaSharedObj'
	AND at.module_id     = rf.ancestor_module_id)
order by PROFILEOPTIONEO.PROFILE_OPTION_NAME
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME