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
,IbyValidationParamsVl.VALIDATION_PARAM_DISPLAY_NAME RES_PARAMETERS_NAME
,DECODE(IbyValidationParamsVl.VALIDATION_PARAMETER_TYPE, 'NUMBER', TO_CHAR(IbyValidationValues.VAL_PARAM_NUMBER_VALUE), 'VARCHAR2', IbyValidationValues.VAL_PARAM_VARCHAR2_VALUE) RES_VALUE
,IbyValidationValues.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,IbyValidationValues.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,IbyValidationValues.CREATED_BY RSC_CREATED_BY
,IbyValidationValues.CREATION_DATE RSC_CREATION_DATE
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
,IBY_VALIDATION_VALUES IbyValidationValues
,IBY_VALIDATION_PARAMS_VL IbyValidationParamsVl
WHERE IbyFormatsVl.FORMAT_CODE = IbyValAssignments.ASSIGNMENT_ENTITY_ID
AND IbyValAssignments.VALIDATION_SET_CODE = IbyValidationSetsVl.VALIDATION_SET_CODE
AND IbyValAssignments.VALIDATION_ASSIGNMENT_ID = IbyValidationValues.VALIDATION_ASSIGNMENT_ID
AND IbyValAssignments.VALIDATION_SET_CODE = IbyValidationParamsVl.VALIDATION_SET_CODE
AND IbyValidationValues.VALIDATION_PARAMETER_CODE = IbyValidationParamsVl.VALIDATION_PARAMETER_CODE
AND IbyValAssignments.FIELD_NAME_CODE IS NULL
AND DECODE(IbyValidationParamsVl.VALIDATION_PARAMETER_TYPE, 'NUMBER', TO_CHAR(IbyValidationValues.VAL_PARAM_NUMBER_VALUE), 'VARCHAR2', IbyValidationValues.VAL_PARAM_VARCHAR2_VALUE) IS NOT NULL
ORDER BY IbyFormatsVl.FORMAT_NAME
,IbyFormatsVl.FORMAT_CODE
,IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME
,IbyValidationParamsVl.VALIDATION_PARAM_DISPLAY_NAME