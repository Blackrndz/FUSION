/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception Set $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_SETS_VL

SELECT ExceptionSetsE0.NAME RES_EXCEPTION_SET
,ExceptionSetsE0.DESCRIPTION RES_DESCRIPTION
,ExceptionSetsE0.TIME_FENCE RES_EXCEPTION_CUTOFF_DAYS
,ExceptionSetsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExceptionSetsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExceptionSetsE0.CREATED_BY RSC_CREATED_BY
,ExceptionSetsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_EXCEPTION_SETS_VL ExceptionSetsE0
ORDER BY ExceptionSetsE0.NAME