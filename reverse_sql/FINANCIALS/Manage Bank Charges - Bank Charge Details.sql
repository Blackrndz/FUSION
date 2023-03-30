/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Charges%20-%20Bank%20Charge%20Details.sql $:
* $Id: Manage Bank Charges - Bank Charge Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DECODE(NVL(BankChargeHeaderEO.LEGAL_ENTITY_ID, - 99), - 99,(SELECT displayed_field
	FROM ap_lookup_codes
	WHERE lookup_type = 'LITERAL'
	AND lookup_code   = BankChargeHeaderEO.LEGAL_ENTITY_ID
	),(SELECT NAME
	FROM XLE_ENTITY_PROFILES
	WHERE LEGAL_ENTITY_ID = BankChargeHeaderEO.LEGAL_ENTITY_ID
	))                                                 AS RES_LEGAL_ENTITY
,BankChargeHeaderEO.CURRENCY_CODE                   AS RES_CURRENCY
,TO_CHAR(BankChargeLineEO.START_DATE,'DD-Mon-YYYY') AS RES_DATE_FROM
,TO_CHAR(BankChargeLineEO.END_DATE,'DD-Mon-YYYY')   AS RES_DATE_TO
,BankChargeLineEO.TRANS_AMOUNT_FROM                 AS RES_PAYMENT_AMOUNT_FROM
,BankChargeLineEO.TRANS_AMOUNT_TO                   AS RES_PAYMENT_AMOUNT_TO
,BankChargeLineEO.BANK_CHARGE_STANDARD              AS RES_BANK_CHARGE_AMOUNT_STANDAR
,BankChargeLineEO.BANK_CHARGE_NEGOTIATED            AS RES_BANK_CHARGE_AMOUNT_NEGOTIA
,BankChargeLineEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BankChargeLineEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BankChargeLineEO.CREATED_BY RSC_CREATED_BY
,BankChargeLineEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,BankChargeHeaderEO.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_BANK_CHARGE_LINES BankChargeLineEO
,AP_BANK_CHARGES BankChargeHeaderEO
WHERE BankChargeLineEO.BANK_CHARGE_ID = BankChargeHeaderEO.BANK_CHARGE_ID
ORDER BY RES_LEGAL_ENTITY