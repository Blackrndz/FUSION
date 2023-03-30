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
,(SELECT DISPLAY_NAME
    FROM HWM_TM_ATRB_FLDS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND TM_ATRB_FLD_ID = eventMapsE0.TM_ATRB_FLD_ID
    ) RES_TIME_ATTRIBUTE
,(CASE
    WHEN eventMapsE0.DISP_VALUE IS NOT NULL THEN
        eventMapsE0.DISP_VALUE
    ELSE
        NVL(NVL(TO_CHAR(eventMapsE0.NUMBER_VALUE),TO_CHAR(eventMapsE0.DATE_VALUE,'DD-Mon-YYYY')),TO_CHAR(eventMapsE0.TIMESTAMP_VALUE,'DD-Mon-YYYY'))
    END) RES_DEFAULT_VALUE
,eventMapsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,eventMapsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,eventMapsE0.CREATED_BY RSC_CREATED_BY
,eventMapsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,deviceMapsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCD_MAPPINGS_VL deviceMapsE0
,(SELECT *
    FROM HWM_TCD_MAPPING_DTLS
    WHERE WFM_EVENT_CD = 'OUT'
    ) eventMapsE0
WHERE deviceMapsE0.TCD_MAPPING_ID = eventMapsE0.TCD_MAPPING_ID
ORDER BY deviceMapsE0.NAME