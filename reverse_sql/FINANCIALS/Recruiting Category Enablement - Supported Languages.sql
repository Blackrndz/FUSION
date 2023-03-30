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

SELECT partnersE0.NAME RES_NAME
,(SELECT DESCRIPTION
    FROM FND_LANGUAGES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND LANGUAGE_CODE = languagesE0.RP_LANGUAGE
    ) RES_SUPPORTED_LANGUAGES

,languagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,languagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,languagesE0.CREATED_BY RSC_CREATED_BY
,languagesE0.CREATION_DATE RSC_CREATION_DATE
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
,IRC_RP_ACTIVATION_CONFIG languagesE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = languagesE0.PROVISIONING_ID

AND catsE0.CODE = 'PROFILE_IMPORT'

AND partnersE0.PARTNER_ID NOT IN (301,303)

ORDER BY partnersE0.NAME