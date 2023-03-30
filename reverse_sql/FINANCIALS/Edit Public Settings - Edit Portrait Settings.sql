/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT publicSetting.PORTRAIT_CONTENT_ITEM_NAME RES_CARD_OR_CONTENTS
,(CASE
    WHEN publicSetting.PARENT_CONTENT_ITEM_KEY IS NULL THEN
        DECODE(publicSetting.DEFAULT_CARD,'Y','Yes','No')
    END) RES_DEFAULT_CARD
,(CASE
    WHEN publicSetting.PARENT_CONTENT_ITEM_KEY IS NULL THEN
        publicSetting.CARD_ORDER
    END) RES_ORDER
,(CASE
    WHEN publicSetting.PARENT_CONTENT_ITEM_KEY IS NULL THEN
        DECODE(publicSetting.DISPLAY_CARD_IN_PORTRAIT,'Y','Yes','No')
    END) RES_DISPLAY
,(CASE
	WHEN publicSetting.PORTRAIT_ADMIN_FLAG = 'N' THEN
		DECODE(publicSetting.ALLOW_USER_CONTROL_FLAG,'Y','Yes','No') 
	END) RES_ALLOW_USER_CONTROL
,(CASE
	WHEN publicSetting.PORTRAIT_ADMIN_FLAG = 'N' THEN
		DECODE(publicSetting.DEFAULT_MANAGER_VISIBLE,'Y','Yes','No')
	END) RES_DEFAULT_VISIBILITY_MY_MANA
,(CASE
	WHEN publicSetting.PORTRAIT_ADMIN_FLAG = 'N' THEN
		DECODE(publicSetting.DEFAULT_EVERYONE_VISIBLE,'Y','Yes','No')
	END) RES_DEFAULT_VISIBILITY_EVERYON
,publicSetting.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,publicSetting.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,publicSetting.CREATED_BY RSC_CREATED_BY
,publicSetting.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_PORTRAIT_CONTENT_VL publicSetting
START WITH publicSetting.PARENT_CONTENT_ITEM_KEY IS NULL
CONNECT BY PRIOR publicSetting.PORTRAIT_CONTENT_ITEM_KEY = publicSetting.PARENT_CONTENT_ITEM_KEY