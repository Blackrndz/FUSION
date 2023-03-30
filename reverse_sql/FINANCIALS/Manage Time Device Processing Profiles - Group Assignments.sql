/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HXT_SETUP_PROFILES_VL

SELECT tDevicesE0.NAME RES_PROFILE_NAME
,(SELECT GROUP_NAME
    FROM HWM_GRPS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND GRP_ID = asgsE0.OBJECT_ID
    ) RES_GROUP_NAME
,TO_CHAR(asgsE0.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(asgsE0.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE
,asgsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,asgsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,asgsE0.CREATED_BY RSC_CREATED_BY
,asgsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,tDevicesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 

FROM HXT_SETUP_PROFILES_VL tDevicesE0
,(SELECT *
    FROM HXT_SETUP_PROFILE_ASGS
    WHERE ASSIGN_TO = 'GROUP'
    ) asgsE0
WHERE tDevicesE0.PRODUCT_AREA = 'TIME_DEVICE'
AND tDevicesE0.SETUP_PROFILE_ID = asgsE0.SETUP_PROFILE_ID
ORDER BY tDevicesE0.PRECEDENCE