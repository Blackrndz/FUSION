/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Reversal%20Reason%20to%20Category%20Mappings%20-%20Manage%20Receivables%20Reversal%20Reason%20to%20Category $:
 * $Id: Manage Receivables Reversal Reason to Category Mappings - Manage Receivables Reversal Reason to Category Mappings.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
 
SELECT AR_LOOKUPS.MEANING  RES_REVERSAL_REASON
,CAT_TYPE.MEANING  RES_REVERSAL_CATEGORY
,DECODE(RECEIPTREVERSALMAPPINGEO.ENABLE_FLAG,'Y','Yes','No') RES_ENABLED
,RECEIPTREVERSALMAPPINGEO.PAYMENT_STANDARD RES_PAYMENT_STANDARD
,ReceiptReversalMappingEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ReceiptReversalMappingEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ReceiptReversalMappingEO.CREATED_BY RSC_CREATED_BY
,ReceiptReversalMappingEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_RCPT_RVRSL_MPNGS ReceiptReversalMappingEO
, AR_LOOKUPS
, AR_LOOKUPS CAT_TYPE
WHERE AR_LOOKUPS.LOOKUP_CODE(+) = ReceiptReversalMappingEO.REVERSAL_REASON_CODE
AND AR_LOOKUPS.LOOKUP_TYPE(+)   = 'CKAJST_REASON'
AND CAT_TYPE.LOOKUP_CODE        = RECEIPTREVERSALMAPPINGEO.REVERSAL_CATEGORY
AND CAT_TYPE.LOOKUP_TYPE        = 'REVERSAL_CATEGORY_TYPE'
ORDER BY ReceiptReversalMappingEO.REVERSAL_CATEGORY
,CAT_TYPE.MEANING