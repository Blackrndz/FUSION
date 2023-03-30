/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=IRC_DESCRIPTIONS_VL

SELECT librariesE0.NAME RES_NAME
,librariesE0.DESCRIPTION_CODE RES_CODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_DESCRIPTION_TYPE'
    AND LOOKUP_CODE = librariesE0.DESCRIPTION_TYPE_CODE
    ) RES_CATEGORY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_IRC_DESC_VISIBILITY'
    AND LOOKUP_CODE = librariesE0.VISIBILITY_CODE
    ) RES_VISIBILITY
,versionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,versionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,versionsE0.CREATED_BY RSC_CREATED_BY
,versionsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_DESCRIPTIONS_VL librariesE0
,(SELECT DESCRIPTION_ID
    ,SHORT_DESCRIPTION
    ,DESCRIPTION
    ,ROW_NUMBER() OVER(PARTITION BY DESCRIPTION_ID ORDER BY VERSION_START_DATE) R1
    ,CREATED_BY
    ,CREATION_DATE
    ,LAST_UPDATED_BY
    ,LAST_UPDATE_DATE
    FROM IRC_DESC_VERSIONS_VL
    ) versionsE0
WHERE librariesE0.DESCRIPTION_ID = versionsE0.DESCRIPTION_ID
AND versionsE0.R1 = 1
ORDER BY librariesE0.NAME