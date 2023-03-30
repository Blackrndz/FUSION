/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT TERRITORY_SHORT_NAME
    FROM FND_TERRITORIES_VL
    WHERE TERRITORY_CODE = nameFormatsE0.LEGISLATION_CODE
    ) RES_COUNTRY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'PER_NAME_FORMATS'
    AND LOOKUP_CODE = nameFormatsE0.FORMAT_NAME
    ) RES_FORMAT_TYPE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'NAME_TYPE'
    AND LOOKUP_CODE = nameFormatsE0.USER_FORMAT_CHOICE
    ) RES_SCOPE
,nameFormatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,nameFormatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,nameFormatsE0.CREATED_BY RSC_CREATED_BY
,nameFormatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,nameFormatsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM HR_NAME_FORMATS nameFormatsE0
ORDER BY RES_COUNTRY NULLS FIRST,RES_FORMAT_TYPE