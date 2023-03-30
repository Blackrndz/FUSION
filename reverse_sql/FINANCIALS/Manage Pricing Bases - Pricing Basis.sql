/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-28 $:
 * $HeadURL:  $:
 * $Id: Manage Pricing Bases - Pricing Basis.sql 54097 2016-03-30 09:27:56Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_BASIS_VL

 
select NAME                       																					RES_NAME
,( select MEANING 
   from FND_LOOKUP_VALUES_VL
   where LOOKUP_TYPE = 'ORA_QP_BASIS_USAGES'
   and LOOKUP_CODE =  BASIS_USAGE_CODE )              																RES_USAGE
,decode(PRICE_ELEMENT_CODE,'QP_FLOOR_PRICE','List Floor Price','QP_LIST_PRICE','List Price','QP_BASE_CEILING_PRICE','Base Ceiling Price','QP_BASE_FLOOR_PRICE',
                           'Base Floor Price','QP_BASE_GSA_PRICE','Base GSA Price','QP_BASE_LIST_PRICE','Base List Price','QP_CEILING_PRICE','Ceiling Price','QP_GSA_PRICE','GSA Price'
                           ,'QP_INVOICE_PRICE','Invoice Price','QP_NET_PRICE','Your Price','QP_NET_PRICE_EXC_INCLUSIVE_TAX','Net Price Excluding Inclusive Tax','QP_NET_PRICE_PLUS_TAX'
						   ,'Net Price Plus Tax' ,'QP_POCKET_PRICE','Pocket Price')                   			RES_PRICE_ELEMENT
,DESCRIPTION                          																			RES_DESCRIPTION
,decode(ACTIVE_FLAG,'Y','Yes','No')                          												RES_ACTIVE
  , A.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , A.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , A.CREATED_BY  RSC_CREATED_BY
  , A.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
  , null RSC_BUSINESS_UNIT_ID
  , null RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM  QP_PRICING_BASIS_VL A
