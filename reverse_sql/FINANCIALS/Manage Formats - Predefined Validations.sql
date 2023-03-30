/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT IbyFormatsVl.FORMAT_NAME RES_NAME
,IbyFormatsVl.FORMAT_CODE RES_CODE
,IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME RES_VALIDATION
,TerritoryPEO.TERRITORY_SHORT_NAME RES_COUNTRY
,IbyPaymentMethodsVl.PAYMENT_METHOD_NAME RES_PAYMENT_METHOD
,TO_CHAR(IbyValAssignments.START_DATE,'DD-MM-YYYY') RES_FROM_DATE
,DECODE(TO_CHAR(IbyValAssignments.END_DATE,'DD-MM-YYYY'),'31-12-4712',null,TO_CHAR(IbyValAssignments.END_DATE,'DD-Mon-YYYY')) RES_TO_DATE
,IbyValAssignments.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbyValAssignments.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbyValAssignments.CREATED_BY RSC_CREATED_BY
,IbyValAssignments.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_FORMATS_VL IbyFormatsVl
,IBY_VAL_ASSIGNMENTS IbyValAssignments
,IBY_VALIDATION_SETS_VL IbyValidationSetsVl
,FND_TERRITORIES_VL TerritoryPEO
,IBY_PAYMENT_METHODS_VL IbyPaymentMethodsVl
WHERE IbyFormatsVl.FORMAT_CODE = IbyValAssignments.ASSIGNMENT_ENTITY_ID
AND IbyValAssignments.VALIDATION_SET_CODE = IbyValidationSetsVl.VALIDATION_SET_CODE
AND IbyValAssignments.TERRITORY_CODE = TerritoryPEO.TERRITORY_CODE(+)
AND IbyValAssignments.PAYMENT_METHOD_CODE = IbyPaymentMethodsVl.PAYMENT_METHOD_CODE(+)
AND IbyValAssignments.FIELD_NAME_CODE IS NULL
ORDER BY IbyFormatsVl.FORMAT_NAME
,IbyFormatsVl.FORMAT_CODE
,IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME