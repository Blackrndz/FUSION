/* ****************************************************************************
 * $Revision: 78776 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-17 11:32:13 +0700 (Fri, 17 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Method%20Defaulting%20Rules%20(Payment%20Process%20Transaction%20Types)%20-%20Defaulting%20Conditions.sql $:
 * $Id: Manage Payment Method Defaulting Rules (Payment Process Transaction Types) - Defaulting Conditions.sql 78776 2022-06-17 04:32:13Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

WITH IBYRC AS
	(SELECT DefaultingRuleConditionEO.RULE_CONDITION_ID
	, DefaultingRuleConditionEO.PAYMENT_RULE_ID
	, DefaultingRuleConditionEO.RULE_CONDITION_TYPE_CODE
	, DefaultingRuleConditionEO.OPERATOR_CODE
	, DefaultingRuleConditionEO.RULE_CONDITION_VALUE
	, DefaultingRuleConditionEO.RULE_CONDITION_ENTRY_SEQUENCE
	FROM fusion.IBY_RULE_CONDITIONS DefaultingRuleConditionEO
	)
SELECT DefaultingPaymentRuleEO.PAYMENT_RULE_NAME AS RES_NAME
,DECODE(DefaultingPaymentRuleEO.APPLICATION_ID,200,'Payables',222,'Receivables for Customer Refunds') AS RES_USAGE
,(DECODE(
	(SELECT COUNT(1) FROM fusion.IBY_RULE_CONDITIONS WHERE RULE_CONDITION_TYPE_CODE = 'PAY_PROC_TRXN_TYPE'
	AND PAYMENT_RULE_ID  =	DefaultingPaymentRuleEO.PAYMENT_RULE_ID
	AND RULE_CONDITION_VALUE IS NOT NULL
	),0,'All','Specific')) AS RES_PAYMENT_PROCESS_TRANSACTIO
,DECODE(IBYRC.RULE_CONDITION_VALUE,NULL,NULL,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'IBY_OPERATIONS'
	AND LookupPEO.LOOKUP_CODE   = IBYRC.OPERATOR_CODE
	)) AS RES_OPERATOR
,(SELECT TransactionTypeEO.NAME
	FROM IBY_TRXN_TYPES_VL TransactionTypeEO
	WHERE TransactionTypeEO.PAY_PROC_TRXN_TYPE_CODE = IBYRC.RULE_CONDITION_VALUE
	) AS RES_TYPE
,DefaultingPaymentRuleEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DefaultingPaymentRuleEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DefaultingPaymentRuleEO.CREATED_BY RSC_CREATED_BY
,DefaultingPaymentRuleEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM fusion.IBY_PAYMENT_RULES DefaultingPaymentRuleEO
,IBYRC
WHERE IBYRC.PAYMENT_RULE_ID        = DefaultingPaymentRuleEO.PAYMENT_RULE_ID
AND IBYRC.RULE_CONDITION_TYPE_CODE = 'PAY_PROC_TRXN_TYPE'
ORDER BY DefaultingPaymentRuleEO.APPLICATION_ID
,DefaultingPaymentRuleEO.PAYMENT_RULE_PRIORITY