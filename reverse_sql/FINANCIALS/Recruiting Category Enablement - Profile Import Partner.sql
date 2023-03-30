/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

WITH SERVICES AS (SELECT serveicesE0.PROVISIONING_ID
	,catphasesE0.PHASE_CODE
	,serveicesE0.URL
	,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LANGUAGE = USERENV('LANG')
		AND LOOKUP_TYPE = 'ORA_IRC_TP_HTTP_METHOD'
		AND LOOKUP_CODE = serveicesE0.HTTP_METHOD_TYPE_CODE
		) METHODS
	,serveicesE0.CUSTOM_PARAMS
	FROM IRC_TP_PARTNER_SERVICES serveicesE0
	,IRC_TP_CATEGORY_PHASES catphasesE0
	WHERE serveicesE0.CATEGORY_PHASE_ID = catphasesE0.CATEGORY_PHASE_ID)

SELECT partnersE0.NAME RES_NAME
,'' RES_LOGO
,partnersE0.PARTNER_GUID RES_PARTNER_KEY
,catsE0.CATEGORY_NAME RES_SERVICE_CATEGORY
,NVL(catsE0.SUB_CATEGORY_NAME,'None') RES_SERVICE_SUB_CATEGORY

,accTokensE0.URL RES_ACCESS_TOKEN_URL_WEB_SERVI -- Access Token URL - Web Service Endpoint
,accTokensE0.METHODS RES_ACCESS_TOKEN_URL_METHOD -- Access Token URL - Method
,'' RES_ACCESS_TOKEN_URL_DEFAULT_P -- Access Token URL - Default Parameters
,accTokensE0.CUSTOM_PARAMS RES_ACCESS_TOKEN_URL_PARTNER_S -- Access Token URL - Partner Specific Parameters

,servicesE0.URL RES_SERVICE_URL_WEB_SERVICE_EN -- Service URL - Web Service Endpoint
,servicesE0.METHODS RES_SERVICE_URL_METHOD -- Service URL - Method
,'' RES_SERVICE_URL_DEFAULT_PARAME -- Service URL - Default Parameters
,servicesE0.CUSTOM_PARAMS RES_SERVICE_URL_PARTNER_SPECIF -- Service URL - Partner Specific Parameters

,ptProvisngsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ptProvisngsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ptProvisngsE0.CREATED_BY RSC_CREATED_BY
,ptProvisngsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM IRC_TP_PARTNERS partnersE0
,IRC_TP_PARTNER_PROVISNGS ptProvisngsE0
,IRC_TP_CATEGORIES_VL catsE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_TOKEN_GRANT'
	) accTokensE0
,(SELECT * 
	FROM SERVICES 
	WHERE PHASE_CODE = 'ORA_RESOURCE_GRANT'
	) servicesE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = accTokensE0.PROVISIONING_ID(+)
AND ptProvisngsE0.PROVISIONING_ID = servicesE0.PROVISIONING_ID(+)

AND catsE0.CODE = 'PROFILE_IMPORT'

AND partnersE0.PARTNER_ID NOT IN (301,303)

ORDER BY partnersE0.NAME