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
,mappingSetsE0.DESCRIPTION RES_DESCRIPTION
,mappingSetsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,mappingSetsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,mappingSetsE0.CREATED_BY RSC_CREATED_BY
,mappingSetsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,mappingSetsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCD_MAPPING_SETS_VL mappingSetsE0
ORDER BY mappingSetsE0.NAME