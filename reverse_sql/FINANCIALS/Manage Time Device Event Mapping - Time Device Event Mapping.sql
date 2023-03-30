/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCD_MAPPINGS_VL

SELECT deviceMapsE0.NAME RES_NAME
,deviceMapsE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_TCD_SUPPLIERS'
    AND LOOKUP_CODE = deviceMapsE0.VENDOR_CD
    ) RES_DEVICE_SUPPLIER
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_TCD_SUPPLIER_EVENTS'
    AND LOOKUP_CODE = deviceMapsE0.TCD_EVENT_CD
    ) RES_SUPPLIER_DEVICE_EVENT
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_HWM_TCD_EVENTS'
    AND LOOKUP_CODE = deviceMapsE0.WFM_EVENT_IN_OUT
    ) RES_APPLICATION_EVENT
,deviceMapsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,deviceMapsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,deviceMapsE0.CREATED_BY RSC_CREATED_BY
,deviceMapsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,deviceMapsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCD_MAPPINGS_VL deviceMapsE0
ORDER BY deviceMapsE0.NAME