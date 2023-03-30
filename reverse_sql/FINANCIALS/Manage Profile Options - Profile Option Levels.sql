/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Options%20-%20Profile%20Option%20Levels.sql $:
* $Id: Manage Profile Options - Profile Option Levels.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT PROFILE_OPTION_NAME
	FROM FND_PROFILE_OPTIONS_VL
	WHERE PROFILE_OPTION_ID = ProfileOptionLevelEO.PROFILE_OPTION_ID
	) AS RES_PROFILE_OPTION_CODE
,(SELECT USER_PROFILE_OPTION_NAME
	FROM FND_PROFILE_OPTIONS_VL
	WHERE PROFILE_OPTION_ID = ProfileOptionLevelEO.PROFILE_OPTION_ID
	)                                                                                       AS RES_PROFILE_DISPLAY_NAME
,DECODE(ProfileOptionLevelEO.LEVEL_NAME,'PRODUCT','Product','USER','User','SITE','Site') AS RES_LEVEL
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ProfileOptionLevelEO.ENABLED_FLAG
	),'No') AS RES_ENABLED
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ProfileOptionLevelEO.UPDATEABLE_FLAG
	),'No') AS RES_UPDATEABLE
,ProfileOptionLevelEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionLevelEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileOptionLevelEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionLevelEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTION_LEVELS ProfileOptionLevelEO
ORDER BY RES_PROFILE_OPTION_CODE