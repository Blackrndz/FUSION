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

SELECT partnersE0.NAME RES_PARTNER_NAME
,ptProvisngsE0.CLIENT_REF_KEY RES_REFERENCE_KEY
,mainaccE0.USERNAME RES_CLIENT_ID
,'' RES_CLIENT_SECRET
,(CASE
    WHEN catsE0.CODE = 'PROFILE_IMPORT' THEN
        DECODE(ptProvisngsE0.STATUS_CODE,'ORA_ACTIVE','Yes','No')
    END) RES_ACTIVE

,indeedsE0.USERNAME RES_INDEED_CLIENT_ID
,'' RES_INDEED_CLIENT_SECRET
,DECODE(indeedsE0.STATUS_CODE,'ORA_ACTIVE','Yes','No') RES_INDEED_ACTIVE
,DECODE(linkedinE0.USERNAME,NULL,'Yes','No') RES_CREATE_LINKEDIN_CUSTOMER_A
,'' RES_APPLICATION_NAME
,'' RES_WHITELISTED_URLS
,linkedinE0.USERNAME RES_LINKEDIN_CLIENT_ID
,'' RES_LINKEDIN_CLIENT_SECRET

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
,IRC_TP_PARTNER_ACCOUNTS mainaccE0
,(SELECT ptProvisngsE0.STATUS_CODE
	,mainaccE0.USERNAME
	FROM IRC_TP_PARTNER_PROVISNGS ptProvisngsE0
	,IRC_TP_PARTNER_ACCOUNTS mainaccE0
	WHERE ptProvisngsE0.PROVISIONING_ID = mainaccE0.PROVISIONING_ID(+)
	AND ptProvisngsE0.PROVISIONING_ID = 3002
	) indeedsE0
,(SELECT ptProvisngsE0.STATUS_CODE
	,mainaccE0.USERNAME
	FROM IRC_TP_PARTNER_PROVISNGS ptProvisngsE0
	,IRC_TP_PARTNER_ACCOUNTS mainaccE0
	WHERE ptProvisngsE0.PROVISIONING_ID = mainaccE0.PROVISIONING_ID(+)
	AND ptProvisngsE0.PROVISIONING_ID = 3004
	) linkedinE0
WHERE partnersE0.PARTNER_ID = ptProvisngsE0.PARTNER_ID
AND ptProvisngsE0.CATEGORY_ID = catsE0.CATEGORY_ID
AND ptProvisngsE0.PROVISIONING_ID = mainaccE0.PROVISIONING_ID(+)
AND catsE0.CODE = 'PROFILE_IMPORT'

AND partnersE0.PARTNER_ID NOT IN (301,302,303,304)

ORDER BY NVL(catsE0.SUB_CATEGORY_NAME,catsE0.CATEGORY_NAME)
,partnersE0.NAME