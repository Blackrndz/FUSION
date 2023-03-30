/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-28 $:
 * $HeadURL:  $:
 * $Id: Manage Pricing Bases - Criteria for Excluded Charges.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_PRICING_BASIS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_PRC_BASIS_CHARGE_CRITERIA
 
select A.NAME                       												RES_NAME
,( select MEANING 
   from FND_LOOKUP_VALUES_VL
  where LOOKUP_TYPE = 'ORA_QP_BASIS_USAGES'
and LOOKUP_CODE =  A.BASIS_USAGE_CODE )              								RES_USAGE
,  NVL((select MEANING from FND_LOOKUPs 
    where LOOKUP_TYPE = 'ORA_QP_PRICE_TYPES' 
   and LOOKUP_CODE = B.PRICE_TYPE_CODE) ,'All' )                              		RES_PRICE_TYPE
, NVL(( select MEANING 
    from FND_LOOKUP_VALUES_VL
  where LOOKUP_TYPE = 'ORA_QP_CHARGE_TYPES'
   and LOOKUP_CODE =  B.CHARGE_TYPE_CODE )   ,'All')                             	RES_CHARGE_TYPE
, NVL(( select MEANING 
   from FND_LOOKUP_VALUES_VL
  where LOOKUP_TYPE = 'ORA_QP_CHARGE_SUBTYPES'
   and LOOKUP_CODE = B.CHARGE_SUBTYPE_CODE   ),'All')                              	RES_CHARGE_SUBTYPE
,decode(B.PRICE_PERIODICITY_CODE,'zz5','YR','zzJ','SEC','zzM','WK','zzS','QTR','zzZ','MON','zze','MIN','zzn','HR','ALL','All')     RES_PRICE_PERIODICITY
  , B.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  , B.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  , B.CREATED_BY  RSC_CREATED_BY
  , B.CREATION_DATE  RSC_CREATION_DATE
  , null RSC_LEDGER_ID
  , null RSC_CHART_OF_ACCOUNTS_ID
  , null RSC_BUSINESS_UNIT_ID
  , null RSC_LEGAL_ENTITY_ID
  , null RSC_ORGANIZATION_ID
  , null RSC_BUSINESS_GROUP_ID
  , NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM  QP_PRICING_BASIS_VL A
     ,QP_PRC_BASIS_CHARGE_CRITERIA   B
WHERE A.PRICING_BASIS_ID    =  B.PRICING_BASIS_ID
AND INCLUDE_FLAG = 'N'
