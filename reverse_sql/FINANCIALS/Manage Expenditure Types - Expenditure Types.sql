/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT expTypesE0.EXPENDITURE_TYPE_NAME RES_EXPENDITURE_TYPE
,expTypesE0.DESCRIPTION RES_DESCRIPTION
,(SELECT EXPENDITURE_CATEGORY_NAME 
	FROM PJF_EXP_CATEGORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND EXPENDITURE_CATEGORY_ID = expTypesE0.EXPENDITURE_CATEGORY_ID
	) RES_EXPENDITURE_CATEGORY
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
	AND LOOKUP_CODE = expTypesE0.REVENUE_CATEGORY_CODE
	) RES_REVENUE_CATEGORY
,(CASE
	WHEN expTypesE0.UNIT_OF_MEASURE = 'HOURS' THEN
		'Hours'
	WHEN expTypesE0.UNIT_OF_MEASURE = 'DOLLARS' THEN
		'Currency'
	ELSE
		(SELECT UNIT_OF_MEASURE 
		FROM INV_UNITS_OF_MEASURE_VL
		WHERE UOM_CODE = expTypesE0.UNIT_OF_MEASURE)
	END) RES_UNIT_OF_MEASURE
,DECODE(expTypesE0.COST_RATE_FLAG,'Y','Yes','No') RES_RATE_REQUIRED
,DECODE(expTypesE0.PROCEEDS_FLAG,'Y','Yes','No') RES_PROCEEDS_OF_SALE
,TO_CHAR(expTypesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(expTypesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,expTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,expTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,expTypesE0.CREATED_BY RSC_CREATED_BY
,expTypesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_TYPES_VL expTypesE0
ORDER BY expTypesE0.EXPENDITURE_TYPE_NAME