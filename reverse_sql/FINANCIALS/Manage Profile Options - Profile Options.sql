/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Options%20-%20Profile%20Options.sql $:
* $Id: Manage Profile Options - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ProfileOptionTranslationEO.PROFILE_OPTION_NAME AS RES_PROFILE_OPTION_CODE
,ProfileOptionTranslationEO.USER_PROFILE_OPTION_NAME  AS RES_PROFILE_DISPLAY_NAME
,(SELECT Application_name
	FROM fnd_application_vl
	WHERE APPLICATION_ID = ProfileOptionTranslationEO.APPLICATION_ID
	) AS RES_APPLICATION
,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID = ProfileOptionTranslationEO.MODULE_ID
	)                                                                   AS RES_MODULE
,ProfileOptionTranslationEO.DESCRIPTION                              AS RES_DESCRIPTION
,ProfileOptionTranslationEO.SQL_VALIDATION                           AS RES_SQL_VALIDATION
,TO_CHAR(ProfileOptionTranslationEO.START_DATE_ACTIVE,'DD-Mon-YYYY') AS RES_START_DATE
,TO_CHAR(ProfileOptionTranslationEO.END_DATE_ACTIVE,'DD-Mon-YYYY')   AS RES_END_DATE
,ProfileOptionTranslationEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionTranslationEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileOptionTranslationEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionTranslationEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionTranslationEO
ORDER BY RES_PROFILE_OPTION_CODE