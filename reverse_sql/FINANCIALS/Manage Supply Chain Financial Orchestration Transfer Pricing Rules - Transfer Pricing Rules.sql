/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Lot Grades - Lot Grades.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PRICING_OPTION_NAME RES_NAME
,PRICING_OPTION_DESC RES_DESCRIPTION
,DECODE(TP_TXN_COST_BASIS_FLAG,'Y','Transaction Cost Basis','Source Document Price Basis') RES_ACCOUNTING_TRANSFER_PRICE
,DECODE(TP_USE_SOPRICE_FLAG,'Y','Yes','No') RES_USE_SALES_ORDER_PRICE_FOR_
,TO_CHAR(EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,DECODE(Extract(YEAR FROM EFFECTIVE_END_DATE),'4712',NULL,TO_CHAR(EFFECTIVE_END_DATE,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,TP_DOC_MARKUP_VALUE RES_MARKUP_PERCENTAGE
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FOS_PRICING_OPTION_F
WHERE PRICING_ID > 0
ORDER BY PRICING_OPTION_NAME