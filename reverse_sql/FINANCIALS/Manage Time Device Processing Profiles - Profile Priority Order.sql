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

SELECT tDevicesE0.PRECEDENCE RES_PRIORITY
,tDevicesE0.NAME RES_PROFILE_NAME
,tDevicesE0.DESCRIPTION RES_DESCRIPTION
,tDevicesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,tDevicesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,tDevicesE0.CREATED_BY RSC_CREATED_BY
,tDevicesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,tDevicesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HXT_SETUP_PROFILES_VL tDevicesE0
WHERE tDevicesE0.PRODUCT_AREA = 'TIME_DEVICE'
ORDER BY tDevicesE0.PRECEDENCE