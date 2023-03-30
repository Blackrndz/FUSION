/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receipt%20Classes%20and%20Methods%20-%20Bills%20Receivable.sql $:
 * $Id: Manage Receipt Classes and Methods - Bills Receivable.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT ArReceiptClasses.name AS RES_NAME
,ARM.NAME                    AS RES_RECEIPT_METHODS_NAME
,NVL((SELECT MEANING
	FROM ar_lookups
	WHERE lookup_type = 'YES/NO'
	AND lookup_code   = ARM.BR_INHERIT_INV_NUM_FLAG
	),'No') AS RES_BILLS_RECEIVABLE_INHERIT_T
,(SELECT MEANING
	FROM ar_lookups
	WHERE lookup_type = 'AUTO_RECEIPT_CREATION_RULES'
	AND lookup_code   = ARM.RECEIPT_CREATION_RULE_CODE
	) AS RES_NUMBER_OF_BILLS_RECEIVABLE
,(SELECT MEANING
	FROM ar_lookups
	WHERE lookup_type = 'RECEIPT_MATURITY_DATE_RULES'
	AND lookup_code   = ARM.MATURITY_DATE_RULE_CODE
	) AS RES_BILLS_RECEIVABLE_MATURITY_
,(SELECT name
	FROM RA_CUST_TRX_TYPES_ALL
	WHERE CUST_TRX_TYPE_SEQ_ID = ARM.BR_CUST_TRX_TYPE_ID
	)                        AS RES_TRANSACTION_TYPE
,ARM.LEAD_DAYS            AS RES_LEAD_DAYS
,ARM.BR_MIN_ACCTD_AMOUNT  AS RES_MINIMUM_AMOUNT
,ARM.BR_MAX_ACCTD_AMOUNT  AS RES_MAXIMUM_AMOUNT
,decode(ARM.PAYMENT_CHANNEL_CODE,'BILLS_RECEIVABLE','Bills Receivable','BANK_ACCT_XFER','Bank Account Transfer') AS RES_CUSTOMER_PAYMENT_METHOD
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
WHERE ARM.RECEIPT_CLASS_ID                = ArReceiptClasses.RECEIPT_CLASS_ID
AND ArReceiptClasses.CREATION_METHOD_CODE = 'BR'
ORDER BY 1

