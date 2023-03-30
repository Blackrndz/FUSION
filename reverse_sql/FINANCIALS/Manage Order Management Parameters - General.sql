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
 
SELECT QpPricingParameters.NAME RES_PARAMETER_NAME
,QpPricingParameters.DESCRIPTION RES_PARAMETER_DESCRIPTION
,QpPricingParameters.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QpPricingParameters.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QpPricingParameters.CREATED_BY RSC_CREATED_BY
,QpPricingParameters.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_PRICING_PARAMETERS_VL QpPricingParameters
WHERE QpPricingParameters.PARAMETER_USAGE_CODE <> 'QP'
ORDER BY QpPricingParameters.NAME