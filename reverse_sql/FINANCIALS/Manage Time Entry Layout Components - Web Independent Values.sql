/* ****************************************************************************
 * $Revision: 59704 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-22 17:48:05 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19.01/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 59704 2016-11-22 10:48:05Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT layoutCompsE0.NAME RES_NAME
,dependentsE0.NAME RES_DEPENDENT_FIELD_NAME
,(SELECT ALT_NAME_VALUE
	FROM HWM_TE_ALT_NAME_VALS_VL
	WHERE TE_ALT_NAME_VAL_ID = independentValuesE0.TCLAYFLD_VALUE
	) RES_INDEPENDENT_TIME_ATTRIBUTE
,independentValuesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,independentValuesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,independentValuesE0.CREATED_BY RSC_CREATED_BY
,independentValuesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HXT_TCLAYFLD_DEFNS_VL layoutCompsE0
,(SELECT * FROM HXT_TCLAYFLD_DEFNS_VL WHERE TCLAY_ID IS NULL) dependentsE0
,HXT_TCLAYFLD_CXT_DEPT independentValuesE0
WHERE layoutCompsE0.TCLAY_ID IS NULL
AND layoutCompsE0.TCLAYFLD_DEFNS_ID = dependentsE0.P_TCLAYFLD_DEFNS_ID
AND layoutCompsE0.TCLAYFLD_ATTRIBUTE_CHAR1 = 'W'
AND dependentsE0.TCLAYFLD_DEFNS_ID = independentValuesE0.TCLAYFLD_DEFNS_ID
ORDER BY layoutCompsE0.NAME