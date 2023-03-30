/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Receipt%20Class%20and%20Methods.sql $:
 * $Id: Manage Receipt Classes and Methods - Receipt Class and Methods.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT DISTINCT ArReceiptClasses.NAME AS RES_NAME
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE lookup_type = 'RECEIPT_CREATION_METHOD'
	AND lookup_code   = ArReceiptClasses.CREATION_METHOD_CODE
	) AS RES_CREATION_METHOD
,(SELECT meaning
	FROM ar_lookups
	WHERE lookup_type = 'REMITTANCE_METHOD'
	AND lookup_code   = ArReceiptClasses.REMIT_METHOD_CODE
	) AS RES_REMITTANCE_METHOD
,(SELECT meaning
	FROM ar_lookups
	WHERE lookup_type = 'REQUIRE_CLEARANCE'
	AND lookup_code   = ArReceiptClasses.CLEAR_FLAG
	) AS RES_CLEARANCE_METHOD
,NVL((SELECT meaning
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'YES_NO_SKIP'
	AND LOOKUP_CODE   = ArReceiptClasses.CONFIRM_FLAG
	),'No') AS RES_REQUIRE_CONFIRMATION
,ArReceiptClasses.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ArReceiptClasses.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ArReceiptClasses.CREATED_BY  RSC_CREATED_BY
,ArReceiptClasses.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHODS ARM
WHERE ARM.RECEIPT_CLASS_ID = ArReceiptClasses.RECEIPT_CLASS_ID
ORDER BY 1