/* ****************************************************************************
 * $Revision: 60967 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-08 14:29:52 +0700 (Wed, 08 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Enterprise%20HCM%20Information%20-%20Enterprise.sql $:
 * $Id: Manage Enterprise HCM Information - Enterprise.sql 60967 2017-02-08 07:29:52Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PeriodStatusEO.PERIOD_NAME RES_PERIOD_NAME
,TransactionTypeEO.TRX_TYPE_NAME RES_TRANSACTION_TYPE_NAME
,TransactionTypeEO.TRX_TYPE_CODE RES_TRANSACTION_TYPE_CODE
,TO_CHAR(PeriodStatusEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(PeriodStatusEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,IntercompanyLookupEO.MEANING RES_STATUS
,PeriodStatusEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PeriodStatusEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PeriodStatusEO.CREATED_BY  RSC_CREATED_BY
,PeriodStatusEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FUN_PERIOD_STATUSES PeriodStatusEO
,FUN_SYSTEM_OPTIONS SystemOptionEO
,FUN_TRX_TYPES_VL TransactionTypeEO
,FUN_LOOKUPS IntercompanyLookupEO
WHERE(PeriodStatusEO.INTECO_CALENDAR   = SystemOptionEO.INTECO_CALENDAR)
AND(PeriodStatusEO.INTECO_PERIOD_TYPE  = SystemOptionEO.INTECO_PERIOD_TYPE)
AND(PeriodStatusEO.TRX_TYPE_ID         = TransactionTypeEO.TRX_TYPE_ID)
AND IntercompanyLookupEO.Lookup_Code   = PeriodStatusEO.Status
AND IntercompanyLookupEO.Lookup_Type   = 'FUN_PERIOD_STATUS'
ORDER BY TransactionTypeEO.TRX_TYPE_NAME
,TransactionTypeEO.TRX_TYPE_CODE
,PeriodStatusEO.PERIOD_YEAR
,PeriodStatusEO.PERIOD_NUM