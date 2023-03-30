/* ****************************************************************************
 * $Revision: 80397 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-03-03 16:25:55 +0700 (Fri, 03 Mar 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Transaction Types.sql 80397 2023-03-03 09:25:55Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT
	(SELECT SET_NAME
	FROM fusion.FND_SETID_SETS_VL
	WHERE SET_ID = RaCustTrxTypesAll.SET_ID
	) AS RES_TRANSACTION_TYPE_SET
,(SELECT name
	FROM fusion.XLE_ENTITY_PROFILES
	WHERE legal_entity_id = RaCustTrxTypesAll.legal_entity_id
	) AS RES_LEGAL_ENTITY_NAME
,(SELECT LEGAL_ENTITY_IDENTIFIER
	FROM fusion.XLE_ENTITY_PROFILES
	WHERE legal_entity_id = RaCustTrxTypesAll.legal_entity_id
	) AS RES_LEGAL_ENTITY_IDENTIFIER
,(SELECT REGISTRATION_NUMBER
	FROM fusion.XLE_REGISTRATIONS XleRegistrations
	WHERE source_id = RaCustTrxTypesAll.legal_entity_id
	 and identifying_flag     = 'Y'
	)                              AS RES_REGISTRATION_NUMBER
, RaCustTrxTypesAll.NAME        AS RES_NAME
, RaCustTrxTypesAll.DESCRIPTION AS RES_DESCRIPTION
,(SELECT meaning
	FROM fusion.ar_lookups
	WHERE lookup_type = 'INV/CM'
	AND lookup_code   = RaCustTrxTypesAll.TYPE
	) AS RES_TRANSACTION_CLASS
,(SELECT meaning
	FROM fusion.ar_lookups
	WHERE LOOKUP_TYPE = 'INVOICE_TRX_STATUS'
	AND lookup_code   = RaCustTrxTypesAll.DEFAULT_STATUS
	)                                                    AS RES_TRANSACTION_STATUS
, TO_CHAR(RaCustTrxTypesAll.START_DATE,'DD-Mon-YYYY') AS RES_FROM_DATE
, TO_CHAR(RaCustTrxTypesAll.END_DATE,'DD-Mon-YYYY')   AS RES_TO_DATE
,(SELECT meaning
	FROM fusion.ar_lookups
	WHERE LOOKUP_TYPE = 'SIGN'
	AND lookup_code   = RaCustTrxTypesAll.CREATION_SIGN
	)                                                                       AS RES_CREATION_SIGN
, DECODE(RaCustTrxTypesAll.DEFAULT_PRINTING_OPTION,'N','No','PRI','Yes') AS RES_GENERATE_BILL
, NULL                                                                   AS RES_INVOICE_TYPE
,(SELECT NAME
	FROM fusion.RA_CUST_TRX_TYPES_ALL
	WHERE CUST_TRX_TYPE_SEQ_ID = RaCustTrxTypesAll.CREDIT_MEMO_TYPE_SEQ_ID
	AND type                   = 'CM'
	)                            AS RES_CREDIT_MEMO_TYPE
, ArAppRuleSets.RULE_SET_NAME AS RES_APPLICATION_RULE_SET
,(SELECT NAME
	FROM fusion.RA_TERMS_VL
	WHERE TERM_ID = RaCustTrxTypesAll.DEFAULT_TERM
	)  AS RES_PAYMENT_TERMS
, (SELECT SET_NAME
	FROM fusion.FND_SETID_SETS_VL
WHERE SET_ID = (select SET_ID from RA_TERMS_VL where TERM_ID = RaCustTrxTypesAll.DEFAULT_TERM)) AS RES_PAYMENT_TERMS_SET
, (SELECT MEANING FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = RaCustTrxTypesAll.CONTROL_COMPLETION_LEVEL_CODE 
	AND LOOKUP_TYPE = 'ORA_AR_CNTRL_COMPLETION_LEVEL' AND LANGUAGE = USERENV('LANG')
	) RES_LEVEL_OF_CONTROL_OF_TRANSA
, DECODE(RaCustTrxTypesAll.ACCOUNTING_AFFECT_FLAG,'Y','Yes','No')        AS RES_OPEN_RECEIVABLE
, DECODE(RaCustTrxTypesAll.ALLOW_FREIGHT_FLAG,'Y','Yes','No')            AS RES_ALLOW_FREIGHT
, DECODE(RaCustTrxTypesAll.POST_TO_GL,'Y','Yes','No')                    AS RES_POST_TO_GL
, DECODE(RaCustTrxTypesAll.ADJ_POST_TO_GL_FLAG,'Y','Yes','No')           AS RES_ALLOW_ADJUSTMENT_POSTING
, DECODE(RaCustTrxTypesAll.TAX_CALCULATION_FLAG,'Y','Yes','No')          AS RES_DEFAULT_TAX_CLASSIFICATION
, DECODE(RaCustTrxTypesAll.NATURAL_APPLICATION_ONLY_FLAG,'Y','Yes','No') AS RES_NATURAL_APPLICATION_ONLY
, DECODE(RaCustTrxTypesAll.ALLOW_OVERAPPLICATION_FLAG,'Y','Yes','No')    AS RES_ALLOW_OVERAPPLICATION
, DECODE(RaCustTrxTypesAll.EXCLUDE_FROM_LATE_CHARGES,'Y','Yes','No')     AS RES_EXCLUDE_FROM_LATE_CHARGES_
, DECODE(RaCustTrxTypesAll.ALLOW_FUTURE_ACCT_DATE_FLAG,'N','Yes','No')   AS RES_NO_FUTURE_DATES_WITH_CHRON
, DECODE(RaCustTrxTypesAll.SIGNED_FLAG,'Y','Yes','No')                   AS RES_SIGNED
, DECODE(RaCustTrxTypesAll.DRAWEE_ISSUED_FLAG,'Y','Yes','No')            AS RES_ISSUED_BY_DRAWEE
, RaCustTrxTypesAll.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, RaCustTrxTypesAll.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, RaCustTrxTypesAll.CREATED_BY  RSC_CREATED_BY
, RaCustTrxTypesAll.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, RaCustTrxTypesAll.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM fusion.RA_CUST_TRX_TYPES_ALL RaCustTrxTypesAll
, fusion.AR_APP_RULE_SETS ArAppRuleSets
WHERE RaCustTrxTypesAll.RULE_SET_ID   = ArAppRuleSets.RULE_SET_ID(+)
order by DECODE(RaCustTrxTypesAll.TYPE,'CM','1','INV','2',RaCustTrxTypesAll.TYPE)