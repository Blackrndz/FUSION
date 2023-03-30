/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_PARAMETERS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_PARAMETER_VALUES
 
SELECT QpPricingParameters.NAME RES_PARAMETER_NAME
,(CASE
	WHEN QpPricingParameters.PARAMETER_CODE = 'QP_DEF_PERIODICITY_UOM_CLASS' THEN
		(SELECT UOM_CLASS_TL
			FROM INV_UOM_CLASSES_VL
			WHERE UOM_CLASS = QpPricingParameterValues.PARAMETER_VALUE_CODE)
	END) RES_VALUE
,(CASE
	WHEN QpPricingParameters.PARAMETER_CODE = 'QP_PRODUCT_CATALOG_USAGE_NAME' THEN
		(SELECT CATALOG_CODE
		FROM EGP_CATEGORY_SETS_VL
		WHERE CATEGORY_SET_ID = QpPricingParameterValues.PARAMETER_VALUE_CODE)
	END) RES_CATALOG
,QpPricingParameterValues.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QpPricingParameterValues.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QpPricingParameterValues.CREATED_BY RSC_CREATED_BY
,QpPricingParameterValues.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_PRICING_PARAMETERS_VL QpPricingParameters
,QP_PRICING_PARAMETER_VALUES QpPricingParameterValues
WHERE QpPricingParameters.PARAMETER_USAGE_CODE = 'QP'
AND QpPricingParameters.PARAMETER_ID = QpPricingParameterValues.PARAMETER_ID
ORDER BY QpPricingParameters.NAME