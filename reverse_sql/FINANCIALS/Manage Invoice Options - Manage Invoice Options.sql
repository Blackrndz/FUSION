/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Invoice%20Options%20-%20Manage%20Invoice%20Options.sql $:
* $Id: Manage Invoice Options - Manage Invoice Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
-- FIELD_TO_APPLY_FUNCTION=RES_INTEREST_INTEREST_EXPENSE_/GET_CODE_COMBINATION

-- RSC_PREREQUISITE_OBJECTS=AP_SYSTEM_PARAMETERS_ALL

SELECT
	(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = ApSystemParametersAll.ORG_ID
	) AS RES_BUSINESS_UNIT
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.REQUIRE_INVOICE_GROUP_FLAG
	),'No') AS RES_INVOICE_ENTRY_REQUIRE_INVO
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.INV_DOC_CATEGORY_OVERRIDE
	),'No') AS RES_INVOICE_ENTRY_ALLOW_DOCUME
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALLOW_PAID_INVOICE_ADJUST
	),'No') AS RES_INVOICE_ENTRY_ALLOW_ADJUST
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALLOW_INV_THIRD_PARTY_OVRD
	),'No') AS RES_INVOICE_ENTRY_ALLOW_REMIT_
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.RECALC_PAY_SCHEDULE_FLAG
	),'No') AS RES_INVOICE_ENTRY_RECALCULATE_
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = financSystemParametersAll.HOLD_UNMATCHED_INVOICES_FLAG
	),'No')                 AS RES_INVOICE_ENTRY_HOLD_UNMATCH
,DECODE(ApSystemParametersAll.ROUTING_FLAG,'Y','Yes','N','No') RES_INVOICE_ENTRY_ENABLE_INVOI
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.DISALLOW_ATTACHMENT_DEL_FLAG
	),'No')   RES_INVOICE_ENTRY_PREVENT_DELE
,ApSystemParametersAll.RECEIPT_ACCEPTANCE_DAYS AS RES_INVOICE_ENTRY_RECEIPT_ACCE
,nvl2(ApSystemParametersAll.INVOICE_CURRENCY_CODE,(ApSystemParametersAll.INVOICE_CURRENCY_CODE||' - '||
	(SELECT NAME
	FROM fnd_currencies_vl
	WHERE CURRENCY_CODE = ApSystemParametersAll.INVOICE_CURRENCY_CODE
	)),ApSystemParametersAll.INVOICE_CURRENCY_CODE) AS RES_INVOICE_ENTRY_INVOICE_CURR
,nvl2(ApSystemParametersAll.PAYMENT_CURRENCY_CODE,(ApSystemParametersAll.PAYMENT_CURRENCY_CODE||' - '||
	(SELECT NAME
	FROM fnd_currencies_vl
	WHERE CURRENCY_CODE = ApSystemParametersAll.PAYMENT_CURRENCY_CODE
	)),ApSystemParametersAll.PAYMENT_CURRENCY_CODE)                            AS RES_INVOICE_ENTRY_PAYMENT_CURR
,ApSystemParametersAll.VENDOR_PAY_GROUP_LOOKUP_CODE AS RES_INVOICE_ENTRY_PAY_GROUP
,ApSystemParametersAll.PAYMENT_PRIORITY             AS RES_INVOICE_ENTRY_PAYMENT_PRIO
,(SELECT name
	FROM AP_TERMS_VL
	WHERE TERM_ID = ApSystemParametersAll.TERMS_ID
	) AS RES_INVOICE_ENTRY_PAYMENT_TERM
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'TERMS DATE BASIS'
	AND lookup_code   = ApSystemParametersAll.TERMS_DATE_BASIS
	) AS RES_INVOICE_ENTRY_TERMS_DATE_B
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'DATE RANGE'
	AND lookup_code   = ApSystemParametersAll.PAY_DATE_BASIS_LOOKUP_CODE
	) AS RES_INVOICE_ENTRY_PAY_DATE_BAS
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'ACCOUNTING DATE BASIS'
	AND lookup_code   = ApSystemParametersAll.GL_DATE_FROM_RECEIPT_FLAG
	) AS RES_INVOICE_ENTRY_ACCOUNTING_D
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'BUDGET_DATE_BASIS'
	AND lookup_code   = ApSystemParametersAll.BUDGET_DATE_BASIS
	) AS RES_INVOICE_ENTRY_BUDGET_DATE_
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALLOW_FINAL_MATCH_FLAG
	),'No') AS RES_MATCHING_ALLOW_FINAL_MATCH
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALLOW_FLEX_OVERRIDE_FLAG
	),'No') AS RES_MATCHING_ALLOW_MATCHING_DI
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.TRANSFER_DESC_FLEX_FLAG
	),'No') AS RES_MATCHING_TRANSFER_PO_DISTR
,(SELECT TOLERANCE_NAME
	FROM AP_TOLERANCE_TEMPLATES
	WHERE TOLERANCE_ID = ApSystemParametersAll.TOLERANCE_ID
	AND TOLERANCE_TYPE = 'QUANTITY BASED'
	) AS RES_MATCHING_QUANTITY_TOLERANC
,(SELECT TOLERANCE_NAME
	FROM AP_TOLERANCE_TEMPLATES
	WHERE TOLERANCE_ID = ApSystemParametersAll.SERVICES_TOLERANCE_ID
	AND TOLERANCE_TYPE = 'AMOUNT BASED'
	) AS RES_MATCHING_AMOUNT_TOLERANCES
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.DISC_IS_INV_LESS_TAX_FLAG
	),'No') AS RES_DISCOUNT_EXCLUDE_TAX_FROM_
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.EXCLUDE_FREIGHT_FROM_DISCOUNT
	),'No') AS RES_DISCOUNT_EXCLUDE_FREIGHT_F
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'DISCOUNT_DIST_OPTIONS'
	AND lookup_code   = ApSystemParametersAll.DISCOUNT_DISTRIBUTION_METHOD
	) AS RES_DISCOUNT_DISCOUNT_ALLOCATI
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALWAYS_TAKE_DISC_FLAG
	),'No') AS RES_DISCOUNT_ALWAYS_TAKE_DISCO
,(SELECT name
	FROM AP_TERMS_VL
	WHERE TERM_ID = ApSystemParametersAll.PREPAYMENT_TERMS_ID
	)                        AS RES_PREPAYMENT_PAYMENT_TERMS
,ApSystemParametersAll.ADD_DAYS_SETTLEMENT_DATE AS RES_PREPAYMENT_SETTLEMENT_DAYS
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.BUILD_PREPAYMENT_ACCOUNTS_FLAG
	),'No') AS RES_PREPAYMENT_USE_DISTRIBUTIO
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.PREPAYMENT_AVAILABLE_MESG_FLAG
	),'No') AS RES_PREPAYMENT_SHOW_AVAILABLE_
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.APPROVAL_WORKFLOW_FLAG
	),'No') AS RES_APPROVAL_ENABLE_INVOICE_AP
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ALLOW_FORCE_APPROVAL_FLAG
	),'No') AS RES_APPROVAL_ALLOW_FORCE_APPRO
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.VALIDATE_BEFORE_APPROVAL_FLAG
	),'No') AS RES_APPROVAL_REQUIRE_VALIDATIO
,DECODE(ApSystemParametersAll.APPROVAL_TIMING,'A','Require approval before accounting','Y','Require accounting before approval','N','Account regardless of approval status') RES_APPROVAL_ACCOUNTING_PREFER
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.AUTO_CALCULATE_INTEREST_FLAG
	),'No')                   AS RES_INTEREST_CREATE_INTEREST_I
,INTEREST_TOLERANCE_AMOUNT AS RES_INTEREST_MINIMUM_INTEREST_
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'INTEREST_ALLOCATION_OPTIONS'
	AND lookup_code   = ApSystemParametersAll.PRORATE_INT_INV_ACROSS_DISTS
	)                            AS RES_INTEREST_INTEREST_ALLOCATI
,INTEREST_CODE_COMBINATION_ID AS RES_INTEREST_INTEREST_EXPENSE_
,(SELECT name
	FROM AP_TERMS_VL
	WHERE TERM_ID = ApSystemParametersAll.EMPLOYEE_TERMS_ID
	)                              AS RES_PAYMENT_REQUEST_PAYMENT_TE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PAY GROUP'
	AND LOOKUP_CODE = ApSystemParametersAll.EMPLOYEE_PAY_GROUP_LOOKUP_CODE
	) AS RES_PAYMENT_REQUEST_PAY_GROUP
,ApSystemParametersAll.EMPLOYEE_PAYMENT_PRIORITY      AS RES_PAYMENT_REQUEST_PAYMENT_PR
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.SS_LIMIT_TO_SINGLE_PO_FLAG
	),'No') AS RES_SELF_SERVICE_INVOICES_LIMI
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.SS_INVOICE_BACKDATING_FLAG
	),'No') AS RES_SELF_SERVICE_INVOICES_ALLO
,(SELECT DISPLAYED_FIELD
	FROM ap_lookup_codes
	WHERE lookup_type = 'UNITPRICE CHANGES QTY MATCH'
	AND lookup_code   = ApSystemParametersAll.SS_UPRICE_CHANGE_FOR_QTYMATCH
	) AS RES_SELF_SERVICE_INVOICES_AL_0
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = ApSystemParametersAll.ATTACHMENT_MANDATORY_SS_FLAG
	),'No') RES_SELF_SERVICE_INVOICES_REQU
,ApSystemParametersAll.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ApSystemParametersAll.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ApSystemParametersAll.CREATED_BY RSC_CREATED_BY
,ApSystemParametersAll.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,ApSystemParametersAll.ORG_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_SYSTEM_PARAMETERS_ALL ApSystemParametersAll
,FINANCIALS_SYSTEM_PARAMS_ALL financSystemParametersAll
WHERE ApSystemParametersAll.ORG_ID = financSystemParametersAll.ORG_ID
ORDER BY RES_BUSINESS_UNIT