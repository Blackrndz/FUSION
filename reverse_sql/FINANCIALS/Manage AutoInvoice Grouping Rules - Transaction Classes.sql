/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Grouping%20Rules%20-%20Transaction%20Classes.sql $:
* $Id: Manage AutoInvoice Grouping Rules - Transaction Classes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
SELECT DISTINCT RaGroupingRules.NAME RES_NAME
  , (
        SELECT meaning
        FROM AR_LOOKUPS ArLookupEO
        WHERE ArLookupEO.LOOKUP_TYPE   = 'GROUPING_TRX_TYPE'
            AND ArLookupEO.LOOKUP_CODE = detail.class)    RES_TRANSACTION_CLASS
  , Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , Detail.CREATED_BY  RSC_CREATED_BY
  , Detail.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
  , null RSC_BUSINESS_UNIT_ID
  , null RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM RA_GROUPING_RULES RaGroupingRules
  , RA_GROUPING_TRX_TYPES Detail
  , RA_GROUP_BYS RaGroupBys
WHERE RaGroupingRules.grouping_rule_id = detail.grouping_rule_id
    AND Detail.GROUPING_TRX_TYPE_ID    = RaGroupBys.GROUPING_TRX_TYPE_ID(+)
ORDER BY RaGroupingRules.NAME