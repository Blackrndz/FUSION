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
,(SELECT USER_TRANSACTION_SOURCE FROM PJF_TXN_SOURCES_VL 
	WHERE TRANSACTION_SOURCE = xccBCETRANSOURCE0.TRANSACTION_SOURCE_CODE) RES_BUSINESS_UNIT_TRANSACTION_


,xccBCETRANSOURCE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,xccBCETRANSOURCE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,xccBCETRANSOURCE0.CREATED_BY RSC_CREATED_BY
,xccBCETRANSOURCE0.CREATION_DATE RSC_CREATION_DATE
,xccBCEBUE0.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,xccBCEBUE0.BUSINESS_UNIT_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM XCC_BCE_BUSINESS_UNITS xccBCEBUE0
,XCC_BCE_TRANSACTION_SOURCES xccBCETRANSOURCE0
WHERE xccBCEBUE0.LEDGER_ID = xccBCETRANSOURCE0.LEDGER_ID
AND xccBCEBUE0.BUSINESS_UNIT_ID = xccBCETRANSOURCE0.BUSINESS_UNIT_ID 
AND xccBCETRANSOURCE0.BUSINESS_FUNCTION_CODE = 'PROJECT_ACCOUNTING_BF'
ORDER BY 1,2