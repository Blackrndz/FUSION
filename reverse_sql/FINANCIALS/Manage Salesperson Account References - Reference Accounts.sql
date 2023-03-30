/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Salesperson%20Account%20References%20-%20Reference%20Accounts.sql $:
 * $Id: Manage Salesperson Account References - Reference Accounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
 
-- FIELD_TO_APPLY_FUNCTION=RES_REVENUE/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_RECEIVABLE/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_FREIGHT/GET_CODE_COMBINATION

SELECT RS.name RES_SALESPERSON_NAME
,RS.SALESREP_NUMBER RES_SALESPERSON_NUMBER
,BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,GLLEDGERS.name RES_LEDGER
,ARREFACCOUNTSALL.REV_CCID RES_REVENUE
,ARREFACCOUNTSALL.REC_CCID RES_RECEIVABLE
,ArRefAccountsAll.FREIGHT_CCID RES_FREIGHT
,ArRefAccountsAll.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ArRefAccountsAll.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ArRefAccountsAll.CREATED_BY RSC_CREATED_BY
,ArRefAccountsAll.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM RA_SALESREPS RS
,AR_REF_ACCOUNTS_ALL ArRefAccountsAll
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,GL_LEDGERS GlLedgers
WHERE ArRefAccountsAll.BU_ID               = BusinessUnitPEO.BU_ID
AND ARREFACCOUNTSALL.LEDGER_ID             = GLLEDGERS.LEDGER_ID
AND ARREFACCOUNTSALL.SOURCE_REF_ACCOUNT_ID = RS.RESOURCE_SALESREP_ID
AND ARREFACCOUNTSALL.SOURCE_REF_TABLE      = 'RA_SALESREPS'
order by RS.name
,RS.SALESREP_NUMBER 