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
,DECODE(xccBCEFUNCE0.BC_ENABLED_FLAG,'Y','Yes','N','No') RES_BUSINESS_UNIT_BUDGETARY_CO
,DECODE(xccBCEFUNCE0.RESERVE_ON_SUBMIT_FLAG,'Y','Submission','N','Approval') RES_BUSINESS_UNIT_BUDGETARY__0
,DECODE(xccBCEFUNCE0.EA_ENABLED_FLAG,'Y','Yes','N','No') RES_BUSINESS_UNIT_ENCUMBRANCE_

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
WHERE xccBCEBUE0.LEDGER_ID = xccBCEFUNCE0.LEDGER_ID
AND xccBCEBUE0.BUSINESS_UNIT_ID = xccBCEFUNCE0.BUSINESS_UNIT_ID 
ORDER BY 1,2