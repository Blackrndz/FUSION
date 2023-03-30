/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Profile%20Categories%20-%20Profile%20Options.sql $:
* $Id: Manage Applications Core Profile Categories - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ProfileCategoryOptionEO.CATEGORY_NAME AS RES_CATEGORY_CODE
,(SELECT DISPLAY_NAME
	FROM FND_PROFILE_CATS_VL
	WHERE NAME         = ProfileCategoryOptionEO.CATEGORY_NAME
	AND APPLICATION_ID = ProfileCategoryOptionEO.APPLICATION_ID
	)                                        AS RES_CATEGORY_NAME
,ProfileCategoryOptionEO.DISPLAY_SEQUENCE AS RES_DISPLAY_SEQUENCE
,(SELECT USER_PROFILE_OPTION_NAME
	FROM FND_PROFILE_OPTIONS_VL
	WHERE PROFILE_OPTION_ID = ProfileCategoryOptionEO.PROFILE_OPTION_ID
	AND APPLICATION_ID      = ProfileCategoryOptionEO.PROFILE_OPTION_APPLICATION_ID
	) AS RES_PROFILE_NAME
,ProfileCategoryOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileCategoryOptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileCategoryOptionEO.CREATED_BY RSC_CREATED_BY
,ProfileCategoryOptionEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_CAT_OPTIONS_B ProfileCategoryOptionEO
WHERE ProfileCategoryOptionEO.LAST_UPDATE_LOGIN <> '-1'
ORDER BY RES_CATEGORY_CODE