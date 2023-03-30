/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCD_MAPPING_SETS_VL

SELECT mappingSetsE0.NAME RES_NAME
,(SELECT NAME
    FROM HWM_TCD_MAPPINGS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TCD_MAPPING_ID = mappingSetDtlsE0.TCD_MAPPING_ID
    ) RES_MAPPING_NAME
,(SELECT NAME
    FROM HWM_TCD_MAPPINGS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TCD_MAPPING_ID = mappingSetDtlsE0.TCD_MAPPING_ID
    ) RES_SELECTED
,mappingSetDtlsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,mappingSetDtlsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,mappingSetDtlsE0.CREATED_BY RSC_CREATED_BY
,mappingSetDtlsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,mappingSetsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCD_MAPPING_SETS_VL mappingSetsE0
,HWM_TCD_MAPPING_SET_DTLS mappingSetDtlsE0
WHERE mappingSetsE0.TCD_MAPPING_SET_ID = mappingSetDtlsE0.TCD_MAPPING_SET_ID
ORDER BY mappingSetsE0.NAME