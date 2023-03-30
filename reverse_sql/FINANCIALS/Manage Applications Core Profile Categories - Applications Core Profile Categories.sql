/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Applications%20Core%20Profile%20Categories%20-%20Applications%20Core%20Profile%20Categories.sql $:
* $Id: Manage Applications Core Profile Categories - Applications Core Profile Categories.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ProfileCategoryEO.NAME   AS RES_CATEGORY_CODE
,ProfileCategoryEO.DISPLAY_NAME AS RES_CATEGORY_NAME
,(SELECT Application_name
	FROM fnd_application_vl
	WHERE APPLICATION_ID = ProfileCategoryEO.APPLICATION_ID
	) AS RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = ProfileCategoryEO.MODULE_ID
	)                             AS RES_MODULE
,ProfileCategoryEO.DESCRIPTION AS RES_DESCRIPTION
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ProfileCategoryEO.ENABLED
	),'No') AS RES_ENABLED
,ProfileCategoryEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileCategoryEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileCategoryEO.CREATED_BY RSC_CREATED_BY
,ProfileCategoryEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_CATS_VL ProfileCategoryEO
WHERE ProfileCategoryEO.LAST_UPDATE_LOGIN <> '-1'
ORDER BY ProfileCategoryEO.NAME