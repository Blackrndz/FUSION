/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGP_SYSTEM_ITEMS_B
-- REPLACE_HTML_KEYWORD = RES_SELF_SERVICE_DESCRIPTION_T

SELECT USER_NAME RES_ENROLLMENT_DISPLAY_NAME
,DECODE(ACTIVE_FLAG,'Y','Yes','No') RES_DISPLAY
,DECODE(CONFIG_CHAR_1,'Y','Yes','No') RES_SHOW_FILTERS
,REPLACE(REPLACE(REPLACE(CATEGORY_HELP_TEXT,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_SELF_SERVICE_DESCRIPTION_T
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM BEN_BNFT_CATEGORY
WHERE USAGE_CD = 'SS'
ORDER BY USER_NAME