/* ****************************************************************************
 * $Revision: 56649 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-07-12 11:20:44 +0700 (Tue, 12 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Rate%20Types.sql $:
 * $Id: Currency Rates Manager - Rate Types.sql 56649 2016-07-12 04:20:44Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT DISTINCT applicationsE0.APPLICATION_NAME RES_SUBLEDGER_APPLICATION
,accountingMethodsE0.NAME RES_NAME
,accountingMethodsE0.ACCOUNTING_METHOD_CODE RES_SHORT_NAME
,accountingMethodsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,accountingMethodsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,accountingMethodsE0.CREATED_BY RSC_CREATED_BY
,accountingMethodsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,accountingMethodsE0.ACCOUNTING_COA_ID RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_ACCTG_METHODS_VL accountingMethodsE0
,XLA_SLAM_JE_RULE_SETS jeRuleSetsAssE0
,XLA_SUBLEDGERS_TL applicationsE0
WHERE accountingMethodsE0.ACCOUNTING_METHOD_CODE = jeRuleSetsAssE0.ACCOUNTING_METHOD_CODE
AND accountingMethodsE0.ACCOUNTING_METHOD_TYPE_CODE = jeRuleSetsAssE0.ACCOUNTING_METHOD_TYPE_CODE
AND jeRuleSetsAssE0.APPLICATION_ID = applicationsE0.APPLICATION_ID
AND applicationsE0.LANGUAGE = USERENV('LANG')
and accountingMethodsE0.ENABLED_FLAG = 'Y'
ORDER BY applicationsE0.APPLICATION_NAME
,accountingMethodsE0.NAME