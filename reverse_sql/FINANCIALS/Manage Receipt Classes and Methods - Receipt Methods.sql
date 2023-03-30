/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Receipt%20Methods.sql $:
 * $Id: Manage Receipt Classes and Methods - Receipt Methods.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT DISTINCT ArReceiptClasses.Name     AS RES_NAME
,ARM.NAME                        AS RES_RECEIPT_METHODS_NAME
,ARM.PRINTED_NAME                AS RES_PRINTED_NAME
,TO_CHAR(ARM.START_DATE,'DD-Mon-YYYY')                  AS RES_EFFECTIVE_START_DATE
,TO_CHAR(ARM.END_DATE,'DD-Mon-YYYY')                    AS RES_EFFECTIVE_END_DATE
,DECODE(ARM.DM_INHERIT_RECEIPT_NUM_FLAG,'Y','Yes','No') AS RES_DEBIT_MEMOS_INHERIT_RECEIP
,ARM.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ARM.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ARM.CREATED_BY  RSC_CREATED_BY
,ARM.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_RECEIPT_METHODS ARM
,AR_RECEIPT_CLASSES ArReceiptClasses
,AR_RECEIPT_METHOD_ACCOUNTS_ALL ArReceiptMethodAccountsAll
,AR_CC_ERROR_MAPPINGS ArCcErrorMappings
WHERE ARM.RECEIPT_CLASS_ID                          = ArReceiptClasses.RECEIPT_CLASS_ID
AND ArReceiptMethodAccountsAll.RECEIPT_METHOD_ID(+) = ARM.RECEIPT_METHOD_ID
AND ARM.RECEIPT_METHOD_ID                           = ArCcErrorMappings.RECEIPT_METHOD_ID(+)
ORDER BY 1