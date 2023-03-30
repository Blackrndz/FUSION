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

SELECT catsE0.TCAT_NAME RES_NAME
,catsE0.DESCRIPTION RES_DESCRIPTION
,DECODE(catsE0.PERSISTENT_FLAG,'Y','Yes','N','No') RES_TRACK_USAGE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_UOM'
    AND LOOKUP_CODE = catsE0.UOM
    ) RES_UNIT_OF_MEASURE
,catsE0.ACR_RULE_ID RES_RULE_NAME
,catsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,catsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,catsE0.CREATED_BY RSC_CREATED_BY
,catsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCATS_VL catsE0
ORDER BY catsE0.TCAT_NAME