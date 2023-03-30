/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Configure%20Legislations%20for%20Human%20Resources%20-%20Component%20Groups.sql $:
 * $Id: Configure Legislations for Human Resources - Component Groups.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_VL 
	WHERE TERRITORY_CODE = payINSTALLLEGISEO.LEGISLATION_CODE 
	) RES_LEGISLATION
,DECODE(payDEDUCGRPEO.BASE_NAME,'GLB_ABSENCES','Absence','GLB_TIME_CARDS','Time Cards',payDEDUCGRPEO.BASE_NAME) RES_BASE_NAME
,payDEDUCGRPEO.NAME RES_DISPLAY_NAME
,'Yes' RES_ENABLE
,payDEDUCGRPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payDEDUCGRPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payDEDUCGRPEO.CREATED_BY RSC_CREATED_BY
,payDEDUCGRPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,payINSTALLLEGISEO.LEGISLATION_CODE RSC_COUNTRY_ID
FROM PAY_INSTALLED_LEGISLATIONS payINSTALLLEGISEO
,PAY_DEDUCTION_GROUPS_VL payDEDUCGRPEO
WHERE  payINSTALLLEGISEO.LEGISLATION_CODE = payDEDUCGRPEO.LEGISLATION_CODE
ORDER BY 1