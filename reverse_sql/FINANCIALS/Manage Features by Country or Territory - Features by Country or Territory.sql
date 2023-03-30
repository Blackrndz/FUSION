/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Features%20by%20Country%20or%20Territory%20-%20Features%20by%20Country%20or%20Territory.sql $:
 * $Id: Manage Features by Country or Territory - Features by Country or Territory.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=PAY_INSTALLED_LEGISLATIONS
 
SELECT (SELECT TERRITORY_SHORT_NAME FROM FND_TERRITORIES_VL WHERE TERRITORY_CODE = pILEO.LEGISLATION_CODE) RES_LEGISLATION
,pILEO.LEGISLATION_CODE RES_LEGISLATION_CODE
,DECODE(pILEO.PAYROLL_LICENSE,'PAY','Payroll','HRY','Payroll Interface',NULL,'Human Resources or None') RES_SELECTED_EXTENSION
,DECODE(pILEO.ADDRESS_STYLE_CODE,'SUPP_TAX_AND_RPTNG_ADDR','Supplemental Taxation and Reporting Address','POSTAL_ADDR','Postal Address') RES_ADDRESS_STYLE
,DECODE(pILEO.ADDRESS_VALIDATION_FLAG,'Y','Yes','No') RES_ADDRESS_VALIDATION
,pILEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pILEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pILEO.CREATED_BY RSC_CREATED_BY
,pILEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,pILEO.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PAY_INSTALLED_LEGISLATIONS  pILEO
ORDER BY 1































