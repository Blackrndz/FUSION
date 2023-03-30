/* ****************************************************************************
 * $Revision: 78776 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-17 11:32:13 +0700 (Fri, 17 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payment%20Method%20Defaulting%20Rules%20-%20Payment%20Method%20Defaulting%20Rule.sql $:
 * $Id: Manage Payment Method Defaulting Rules - Payment Method Defaulting Rule.sql 78776 2022-06-17 04:32:13Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PAYMENT_RULE_NAME AS RES_NAME,
  DECODE(DefaultingPaymentRuleEO.APPLICATION_ID,200,'Payables',222,'Receivables for Customer Refunds') AS RES_USAGE,
  (select IbyPaymentMethodsVl.PAYMENT_METHOD_NAME 
   from fusion.IBY_PAYMENT_METHODS_VL IbyPaymentMethodsVl 
   where IbyPaymentMethodsVl.PAYMENT_METHOD_CODE = DefaultingPaymentRuleEO.PAYMENT_METHOD_CODE) AS RES_PAYMENT_METHOD_NAME,
  DefaultingPaymentRuleEO.PAYMENT_METHOD_CODE AS RES_PAYMENT_METHOD_CODE,
  
  (select meaning 
   from fusion.fnd_lookups 
   where lookup_type = 'IBY_CURRENCY_CONDITIONS' 
   and lookup_code in (select RULE_CONDITION_VALUE 
                       from fusion.IBY_RULE_CONDITIONS 
                       where RULE_CONDITION_TYPE_CODE = 'FOREIGN_CURRENCY_FLAG' 
                       and PAYMENT_RULE_ID = DefaultingPaymentRuleEO.PAYMENT_RULE_ID)) AS RES_CURRENCY,
  (select meaning 
   from fusion.fnd_lookups 
   where lookup_type = 'IBY_PAYEE_LOCATION_CONDITIONS' 
   and lookup_code in (select RULE_CONDITION_VALUE 
                      from fusion.IBY_RULE_CONDITIONS 
                      where RULE_CONDITION_TYPE_CODE = 'CROSS_BORDER_FLAG' 
                      and PAYMENT_RULE_ID = DefaultingPaymentRuleEO.PAYMENT_RULE_ID)) AS RES_PAYEE_LOCATION
  ,LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,CREATED_BY  RSC_CREATED_BY
  ,CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM fusion.IBY_PAYMENT_RULES DefaultingPaymentRuleEO
order by RES_USAGE
,DefaultingPaymentRuleEO.PAYMENT_RULE_PRIORITY