/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT NAME FROM GL_LEDGERS WHERE LEDGER_ID = xccBCEBUE0.LEDGER_ID) RES_LEDGER_NAME
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = xccBCEBUE0.BUSINESS_UNIT_ID 
	) RES_BUSINESS_UNIT_NAME
,(SELECT BUSINESS_FUNCTION_NAME  FROM FUN_BUSINESS_FUNCTIONS_VL 
	WHERE BUSINESS_FUNCTION_CODE = xccBCEFUNCE0.BUSINESS_FUNCTION_CODE) RES_BUSINESS_UNIT_BUSINESS_FUN
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = xccBCETRANTYPEE0.TRANSACTION_TYPE_CODE
			AND LOOKUP_TYPE = 'XCC_TRANSACTION_TYPES' AND LANGUAGE = USERENV('LANG')) RES_BUSINESS_UNIT_TRANSACTION_
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = xccBCETRANTYPEE0.TRANSACTION_SUBTYPE_CODE
			AND LOOKUP_TYPE = 'XCC_TRANSACTION_SUBTYPES' AND LANGUAGE = USERENV('LANG')) RES_BUSINESS_UNIT_TRANSACTIO_0
,DECODE(xccBCETRANTYPEE0.BC_ENABLED_FLAG,'Y','Yes','N','No') RES_BUSINESS_UNIT_TRANSACTIO_1
,DECODE(xccBCETRANTYPEE0.EA_ENABLED_FLAG,'Y','Yes','N','No') RES_BUSINESS_UNIT_TRANSACTIO_2

,xccBCEFUNCE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,xccBCEFUNCE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,xccBCEFUNCE0.CREATED_BY RSC_CREATED_BY
,xccBCEFUNCE0.CREATION_DATE RSC_CREATION_DATE
,xccBCEBUE0.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,xccBCEBUE0.BUSINESS_UNIT_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM XCC_BCE_BUSINESS_UNITS xccBCEBUE0
,XCC_BCE_BUSINESS_FUNCTIONS xccBCEFUNCE0
,XCC_BCE_TRANSACTION_TYPES xccBCETRANTYPEE0
WHERE xccBCEBUE0.LEDGER_ID = xccBCEFUNCE0.LEDGER_ID
AND xccBCEBUE0.BUSINESS_UNIT_ID = xccBCEFUNCE0.BUSINESS_UNIT_ID 
AND xccBCEFUNCE0.LEDGER_ID = xccBCETRANTYPEE0.LEDGER_ID
AND xccBCEFUNCE0.BUSINESS_UNIT_ID = xccBCETRANTYPEE0.BUSINESS_UNIT_ID
AND xccBCEFUNCE0.BUSINESS_FUNCTION_CODE = xccBCETRANTYPEE0.BUSINESS_FUNCTION_CODE
AND xccBCEFUNCE0.BC_ENABLED_FLAG = 'Y'
ORDER BY 1,2,3