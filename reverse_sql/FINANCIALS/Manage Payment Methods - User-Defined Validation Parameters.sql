/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-11-29  $:
 * $HeadURL:  $:
 * $Id: Manage Payment Methods - User-Defined Validation Parameters.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

 
SELECT IbyPaymentMethodsTl.PAYMENT_METHOD_NAME RES_NAME
  , IbyPaymentMethodsTl.PAYMENT_METHOD_CODE    RES_CODE
  , (SELECT LookupPEO.MEANING
     FROM FND_LOOKUPS LookupPEO
     WHERE LookupPEO.lookup_type   = 'IBY_VALIDATION_FIELDS'
     AND LookupPEO.LOOKUP_CODE = IbyValAssignments.field_name_code )                                                                                              RES_FIELD
  , IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME                                                                                                                      RES_CONDITION
  , IbyValidationParamsVl.VALIDATION_PARAM_DISPLAY_NAME                                                                                                                  RES_PARAMETERS_NAME
  , DECODE(IbyValidationParamsVl.validation_parameter_type ,'VARCHAR2',IbyValidationValues.VAL_PARAM_VARCHAR2_VALUE,'NUMBER',IbyValidationValues.VAL_PARAM_NUMBER_VALUE) RES_PARAMETERS_VALUE
  , IbyValAssignments.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , IbyValAssignments.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , IbyValAssignments.CREATED_BY  RSC_CREATED_BY
  , IbyValAssignments.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
  , null RSC_BUSINESS_UNIT_ID
  , null RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_METHODS_TL IbyPaymentMethodsTl
  , IBY_VAL_ASSIGNMENTS IbyValAssignments
  , IBY_VALIDATION_SETS_VL IbyValidationSetsVl
  , IBY_VALIDATION_VALUES IbyValidationValues
  , IBY_VALIDATION_PARAMS_VL IbyValidationParamsVl
WHERE IbyPaymentMethodsTl.PAYMENT_METHOD_CODE         = ibyvalassignments.assignment_entity_id(+)
    AND IbyValAssignments.VALIDATION_SET_CODE         = IbyValidationSetsVl.VALIDATION_SET_CODE(+)
    AND IbyValidationValues.VALIDATION_SET_CODE       = IbyValidationParamsVl.VALIDATION_SET_CODE(+)
    AND IbyValidationValues.VALIDATION_PARAMETER_CODE = IbyValidationParamsVl.VALIDATION_PARAMETER_CODE(+)
    AND ibyvalassignments.validation_assignment_id    = IbyValidationValues.VALIDATION_ASSIGNMENT_ID(+)
    AND IbyValidationSetsVl.VALIDATION_SET_CODE LIKE ( 'RULE'|| '%')
    AND IbyValAssignments.VAL_ASSIGNMENT_ENTITY_TYPE = 'METHOD'
AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
ORDER BY RES_NAME,RES_CODE,IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME

  

  