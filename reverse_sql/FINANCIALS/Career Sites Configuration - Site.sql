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

SELECT cxSitesE0.SITE_NAME RES_SITE_NAME
,cxSitesE0.SITE_CODE RES_SITE_CODE
,(SELECT DESCRIPTION
    FROM FND_LANGUAGES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LANGUAGE_CODE = cxSitesE0.DEFAULT_LANG
    ) RES_DEFAULT_LANGUAGE
,(SELECT DECODE(TEMPLATE_NUMBER,'mohegan','Modern','minimal','Minimal',TEMPLATE_NUMBER)
    FROM IRC_CX_SITE_TEMPLATES_VL
    WHERE IS_ACTIVE_FLAG = '1'
    AND SITE_NUMBER = cxSitesE0.SITE_NUMBER
    ) RES_SELECT_A_TEMPLATE
,cxSitesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cxSitesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cxSitesE0.CREATED_BY RSC_CREATED_BY
,cxSitesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_CX_SITES_VL cxSitesE0
,IRC_CX_COOKIES_VL CookiesE0
,IRC_CX_TC_SIGNUP_VL tcsE0
WHERE cxSitesE0.SITE_ID = CookiesE0.SITE_ID(+)
AND cxSitesE0.SITE_ID = tcsE0.SITE_ID(+)
ORDER BY cxSitesE0.SEQUENCE_NUMBER