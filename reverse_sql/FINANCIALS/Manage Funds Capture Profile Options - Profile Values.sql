/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Funds%20Capture%20Profile%20Options%20-%20Profile%20Values.sql $:
* $Id: Manage Funds Capture Profile Options - Profile Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT PROFILE_OPTION_NAME
	FROM FND_PROFILE_OPTIONS_VL
	WHERE PROFILE_OPTION_ID = fndpropvalues.PROFILE_OPTION_ID
	) AS RES_PROFILE_OPTION_CODE
,(SELECT USER_PROFILE_OPTION_NAME
	FROM FND_PROFILE_OPTIONS_VL
	WHERE PROFILE_OPTION_ID = fndpropvalues.PROFILE_OPTION_ID
	) AS RES_PROFILE_DISPLAY_NAME
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'ZMM_NOTE_TYPE'
	AND lookup_code   = fndpropvalues.LEVEL_VALUE
	)                                  AS RES_PROFILE_LEVEL
,''                                 AS RES_PRODUCT_NAME
,''                                 AS RES_USER_NAME
,fndpropvalues.PROFILE_OPTION_VALUE AS RES_PROFILE_VALUE
,fndpropvalues.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fndpropvalues.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fndpropvalues.CREATED_BY RSC_CREATED_BY
,fndpropvalues.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTION_VALUES fndpropvalues
WHERE APPLICATION_ID = '673'
ORDER BY RES_PROFILE_OPTION_CODE