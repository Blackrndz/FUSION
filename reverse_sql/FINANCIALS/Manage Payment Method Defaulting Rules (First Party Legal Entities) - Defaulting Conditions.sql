/* ****************************************************************************
 * $Revision: 78776 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-17 11:32:13 +0700 (Fri, 17 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Method%20Defaulting%20Rules%20(First%20Party%20Legal%20Entities)%20-%20Defaulting%20Conditions.sql $:
 * $Id: Manage Payment Method Defaulting Rules (First Party Legal Entities) - Defaulting Conditions.sql 78776 2022-06-17 04:32:13Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

with IBYRC as(
  SELECT DefaultingRuleConditionEO.RULE_CONDITION_ID,
  DefaultingRuleConditionEO.PAYMENT_RULE_ID,
  DefaultingRuleConditionEO.RULE_CONDITION_TYPE_CODE,
  DefaultingRuleConditionEO.OPERATOR_CODE,
  DefaultingRuleConditionEO.RULE_CONDITION_VALUE,
  DefaultingRuleConditionEO.RULE_CONDITION_ENTRY_SEQUENCE,
  (SELECT name
  FROM fusion.Xle_Entity_Profiles
  WHERE legal_entity_id = DefaultingRuleConditionEO.RULE_CONDITION_VALUE
  AND DefaultingRuleConditionEO.RULE_CONDITION_TYPE_CODE='PAYER_LE'
  ) AS APLE,
    (SELECT LEGAL_ENTITY_IDENTIFIER
  FROM fusion.Xle_Entity_Profiles
  WHERE legal_entity_id = DefaultingRuleConditionEO.RULE_CONDITION_VALUE
  AND DefaultingRuleConditionEO.RULE_CONDITION_TYPE_CODE='PAYER_LE'
  ) AS APIDENTI
FROM fusion.IBY_RULE_CONDITIONS DefaultingRuleConditionEO)

SELECT DefaultingPaymentRuleEO.PAYMENT_RULE_NAME AS RES_NAME,
	
   DECODE(DefaultingPaymentRuleEO.APPLICATION_ID,200,'Payables',222,'Receivables for Customer Refunds') AS RES_USAGE,
     (DECODE(
   (SELECT COUNT(1) 
   FROM fusion.IBY_RULE_CONDITIONS 
   WHERE RULE_CONDITION_TYPE_CODE = 'PAYER_LE'
   AND PAYMENT_RULE_ID = DefaultingPaymentRuleEO.PAYMENT_RULE_ID
   AND RULE_CONDITION_VALUE is not null
   ), 0, 'All', 'Specific')) AS RES_FIRST_PARTY_LEGAL_ENTITIES, 
   IBYRC.aple AS RES_FIRST_PARTY_LEGAL_ENTITY_L,
   IBYRC.APIDENTI AS RES_FIRST_PARTY_LEGAL_ENTITY_0
  ,DefaultingPaymentRuleEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,DefaultingPaymentRuleEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,DefaultingPaymentRuleEO.CREATED_BY  RSC_CREATED_BY
  ,DefaultingPaymentRuleEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM fusion.IBY_PAYMENT_RULES DefaultingPaymentRuleEO, IBYRC
WHERE IBYRC.PAYMENT_RULE_ID = DefaultingPaymentRuleEO.PAYMENT_RULE_ID
and IBYRC.RULE_CONDITION_TYPE_CODE = 'PAYER_LE'
order by DefaultingPaymentRuleEO.APPLICATION_ID
,DefaultingPaymentRuleEO.PAYMENT_RULE_PRIORITY