/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Payroll%20Legislations%20-%20Balance%20Dimensions.sql $:
 * $Id: Configure Payroll Legislations - Balance Dimensions.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT  (SELECT TERRITORY_SHORT_NAME FROM FND_TERRITORIES_VL WHERE TERRITORY_CODE = payINSTALLLEGISEO.LEGISLATION_CODE ) RES_LEGISLATION
,payDIMENSIONEO.DESCRIPTION RES_BASE_NAME
,payDIMENSIONEO.DIMENSION_NAME RES_DISPLAY_NAME
,'Yes' RES_ENABLE

,payDIMENSIONEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payDIMENSIONEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payDIMENSIONEO.CREATED_BY RSC_CREATED_BY
,payDIMENSIONEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_INSTALLED_LEGISLATIONS payINSTALLLEGISEO
,PAY_DIMENSION_USAGES_VL payDIMENSIONEO

WHERE  payINSTALLLEGISEO.LEGISLATION_CODE = payDIMENSIONEO.LEGISLATION_CODE
ORDER BY 1,2