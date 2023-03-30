/* ****************************************************************************
 * $Revision: 48716 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2015-08-05 15:45:27 +0700 (Wed, 05 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 48716 2015-08-05 08:45:27Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT IbyPaymentMethodsTl.PAYMENT_METHOD_NAME RES_NAME
  , IbyPaymentMethodsTl.PAYMENT_METHOD_CODE    RES_CODE
  , (
        SELECT LookupPEO.MEANING
        FROM FND_LOOKUPS LookupPEO
        WHERE LookupPEO.lookup_type   = 'IBY_VALIDATION_FIELDS'
            AND LookupPEO.LOOKUP_CODE = IbyValAssignments.field_name_code )                                                                                              RES_FIELD
  , IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME                                                                                                                      RES_CONDITION
  , TO_CHAR(IbyValAssignments.START_DATE,'DD-Mon-YYYY')                                                                                                         		RES_FROM_DATE
  , DECODE(Extract(Year From IbyValAssignments.END_DATE),'4712',null,TO_CHAR(IbyValAssignments.END_DATE,'DD-Mon-YYYY'))       											RES_TO_DATE
  /*, IbyValidationParamsVl.VALIDATION_PARAM_DISPLAY_NAME                                                                                                                  RES_PARAMETERS_NAME
  , DECODE(IbyValidationParamsVl.validation_parameter_type ,'VARCHAR2',IbyValidationValues.VAL_PARAM_VARCHAR2_VALUE,'NUMBER',IbyValidationValues.VAL_PARAM_NUMBER_VALUE) RES_PARAMETERS_VALUE*/
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
	AND IbyPaymentMethodsTl.LANGUAGE = USERENV('LANG')
    AND
    (
        (
            IbyValidationSetsVl.VALIDATION_SET_CODE LIKE ( 'RULE'
                || '%')
        )
        AND
        (
            IbyValAssignments.VAL_ASSIGNMENT_ENTITY_TYPE = 'METHOD'
        )
    )
ORDER BY RES_NAME,RES_CODE,IbyValidationSetsVl.VALIDATION_SET_DISPLAY_NAME

  