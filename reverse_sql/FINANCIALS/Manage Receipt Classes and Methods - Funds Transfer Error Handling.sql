/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Funds%20Transfer%20Error%20Handling.sql $:
 * $Id: Manage Receipt Classes and Methods - Funds Transfer Error Handling.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT ArReceiptClasses.name     AS RES_NAME
,ARM.NAME                        AS RES_RECEIPT_METHODS_NAME
,ArCcErrorMappings.CC_ERROR_CODE AS RES_ERROR_CODE
,ArCcErrorMappings.CC_ERROR_TEXT AS RES_DESCRIPTION
,(SELECT MEANING
	FROM ar_lookups
	WHERE lookup_type = 'CC_TRX_CATEGORY'
	AND lookup_code   = ArCcErrorMappings.CC_TRX_CATEGORY
	) AS RES_ACTIVITY_CLASS
,(SELECT MEANING
	FROM ar_lookups
	WHERE lookup_type = 'AR_CC_ACTION_CODES'
	AND lookup_code   = ArCcErrorMappings.CC_ACTION_CODE
	)                             AS RES_ACTION
,ArCcErrorMappings.ERROR_NOTES AS RES_NOTES
,ArCcErrorMappings.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ArCcErrorMappings.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ArCcErrorMappings.CREATED_BY  RSC_CREATED_BY
,ArCcErrorMappings.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_CC_ERROR_MAPPINGS ArCcErrorMappings
,AR_RECEIPT_METHODS ARM
,AR_RECEIPT_CLASSES ArReceiptClasses
WHERE ARM.RECEIPT_METHOD_ID = ArCcErrorMappings.RECEIPT_METHOD_ID
AND ARM.RECEIPT_CLASS_ID    = ArReceiptClasses.RECEIPT_CLASS_ID
ORDER BY 1