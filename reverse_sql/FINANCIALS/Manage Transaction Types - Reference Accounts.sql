/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Reference%20Accounts.sql $:
 * $Id: Manage Transaction Types - Reference Accounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- FIELD_TO_APPLY_FUNCTION=RES_REVENUE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_RECEIVABLEBILLS_RECEIVABLE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_TAX/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_FREIGHT/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_UNEARNED_REVENUE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_UNBILLED_RECEIVABLE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_AUTOINVOICE_CLEARING/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_UNPAID_BILLS_RECEIVABLE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_REMITTED_BILLS_RECEIVABLE/GET_CODE_COMBINATION
 -- FIELD_TO_APPLY_FUNCTION=RES_FACTORED_BILLS_RECEIVABLE/GET_CODE_COMBINATION
 
SELECT
	(SELECT SET_NAME
	FROM fusion.FND_SETID_SETS_VL
	WHERE SET_ID = RaCustTrxTypesAll.SET_ID
	)                                                                                           AS RES_TRANSACTION_TYPE_SET
, RaCustTrxTypesAll.NAME                                                                     AS RES_NAME
,(BusinessUnitPEO.bu_name)                                                                   AS RES_BUSINESS_UNIT
, GlLedgers.name                                                                             AS RES_LEDGER
, ArRefAccountsAll.REV_CCID AS RES_REVENUE
, ArRefAccountsAll.REC_CCID AS RES_RECEIVABLEBILLS_RECEIVABLE
, ArRefAccountsAll.TAX_CCID      AS RES_TAX
, ArRefAccountsAll.FREIGHT_CCID  AS RES_FREIGHT
, ArRefAccountsAll.UNEARNED_CCID AS	RES_UNEARNED_REVENUE
, ArRefAccountsAll.UNBILLED_CCID AS	RES_UNBILLED_RECEIVABLE
, ArRefAccountsAll.CLEARING_CCID AS	RES_AUTOINVOICE_CLEARING
, ArRefAccountsAll.BR_UNPAID_CCID AS RES_UNPAID_BILLS_RECEIVABLE
, ArRefAccountsAll.BR_REMIT_CCID AS	RES_REMITTED_BILLS_RECEIVABLE
, ArRefAccountsAll.BR_FACTOR_CCID AS RES_FACTORED_BILLS_RECEIVABLE
, ArRefAccountsAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, ArRefAccountsAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, ArRefAccountsAll.CREATED_BY  RSC_CREATED_BY
, ArRefAccountsAll.CREATION_DATE  RSC_CREATION_DATE
, ArRefAccountsAll.LEDGER_ID RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, ArRefAccountsAll.BU_ID RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM fusion.AR_REF_ACCOUNTS_ALL ArRefAccountsAll
, fusion.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
, fusion.GL_LEDGERS GlLedgers
, fusion.RA_CUST_TRX_TYPES_ALL RaCustTrxTypesAll
WHERE ArRefAccountsAll.BU_ID               = BusinessUnitPEO.BU_ID
AND ArRefAccountsAll.LEDGER_ID             = GlLedgers.LEDGER_ID
AND ArRefAccountsAll.SOURCE_REF_ACCOUNT_ID = RaCustTrxTypesAll.CUST_TRX_TYPE_SEQ_ID
ORDER BY 1
