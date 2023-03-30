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

SELECT extDefsE0.BASE_DEFINITION_NAME RES_NAME
,parametersE0.PARAM_NAME RES_PARAMETERS_NAME
,parametersE0.XML_TAG_NAME RES_TAG_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PAY_PARAM_DISP_TYPE'
    AND LOOKUP_CODE = parametersE0.DATA_TYPE
    ) RES_DATA_TYPE
,DECODE(parametersE0.DISPLAY_FLAG,'Y','Yes','N','No') RES_DISPLAY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PAY_PARAM_DISP_TYPE'
    AND LOOKUP_CODE = parametersE0.PARAM_DISP_TYPE
    ) RES_DISPLAY_FORMAT
,(CASE
    WHEN parametersE0.PARAM_DISP_TYPE IN ('L','R','LOV') THEN
        parametersE0.PARAM_LOOKUP
        -- need to translate 'oracle.apps.hcm.common.pay.publicView.parameters.BalanceCategoryPVO' this kind of value to match the display -*-
    WHEN parametersE0.PARAM_DISP_TYPE IN ('LK','D','N','T','ORA_VALUESET') THEN
        parametersE0.PARAM_LOOKUP
    END) RES_LOOKUP

/*,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PAY_TASK_DEFAULT_TYPE'
    AND LOOKUP_CODE = parametersE0.DEFAULT_TYPE
    ) DEFAULT_TYPE
,parametersE0.DEFAULT_VAL*/
,parametersE0.DESCRIPTION RES_DESCRIPTION
,parametersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,parametersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,parametersE0.CREATED_BY RSC_CREATED_BY
,parametersE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,(SELECT LEGISLATION_CODE
	FROM PER_LEGISLATIVE_DATA_GROUPS_VL
	WHERE LEGISLATIVE_DATA_GROUP_ID = extDefsE0.LEGISLATIVE_DATA_GROUP_ID
	) RSC_COUNTRY_ID

FROM PER_EXT_DEFINITIONS_VL extDefsE0
,PER_EXT_PARAMETERS_VL parametersE0
WHERE extDefsE0.LEGISLATION_CODE IS NULL
AND extDefsE0.CREATOR_ID IS NULL
AND extDefsE0.EXT_DEFINITION_ID = parametersE0.EXT_DEFINITION_ID
ORDER BY extDefsE0.BASE_DEFINITION_NAME