/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-21  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Filter Organizations $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_SETS_VL
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_SETS_FILTERS

SELECT ExceptionSetsE0.name RES_EXCEPTION_SET
,(SELECT ORGANIZATION_CODE 
	FROM MSC_PARAMETERS
	WHERE ORGANIZATION_ID = ExceptionSetFiltersE0.FILTER_VALUE
	) RES_ORGANIZATION
,ExceptionSetFiltersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExceptionSetFiltersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExceptionSetFiltersE0.CREATED_BY RSC_CREATED_BY
,ExceptionSetFiltersE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_EXCEPTION_SETS_VL ExceptionSetsE0
,MSC_EXCEPTION_SETS_FILTERS ExceptionSetFiltersE0
WHERE ExceptionSetsE0.EXCEPTION_SET_ID = ExceptionSetFiltersE0.EXCEPTION_SET_ID
AND ExceptionSetFiltersE0.FILTER_TYPE = 1
ORDER BY 1,2