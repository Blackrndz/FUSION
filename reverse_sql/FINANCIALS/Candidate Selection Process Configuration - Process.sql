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

SELECT configPoolsE0.NAME RES_NAME
,configPoolsE0.CODE RES_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_PROCESS_STATUS'
    AND LOOKUP_CODE = configPoolsE0.STATUS_CODE 
	) RES_STATUS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_PROCESS_TYPE'
    AND LOOKUP_CODE = NVL(processTypesE0.STRING_VALUE,'ORA_STANDARD')
    ) RES_PROCESS_TYPE
,configPoolsE0.DESCRIPTION RES_DESCRIPTION
,configPoolsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,configPoolsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,configPoolsE0.CREATED_BY RSC_CREATED_BY
,configPoolsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_PROCESSES_VL configPoolsE0
,(SELECT SETTING_ID
    ,STRING_VALUE
    FROM IRC_LC_SETTING_ITEMS
    WHERE ITEM_KEY_NAME = 'ProcessType'
    ) processTypesE0
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.SETTING_ID = processTypesE0.SETTING_ID(+)
ORDER BY configPoolsE0.NAME