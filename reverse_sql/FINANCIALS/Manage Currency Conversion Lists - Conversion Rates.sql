/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-29 $:
 * $HeadURL:  $:
 * $Id: Manage Currency Conversion Lists - Conversion Rates.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_DETAILS

SELECT A.NAME RES_NAME
,detail.FROM_CURRENCY_CODE RES_BASE_CURRENCY
,detail.TO_CURRENCY_CODE RES_TO_CURRENCY
,to_char(detail.START_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_START_DATE
,to_char(detail.END_DATE,'DD-Mon-YYYY HH24:MI:SS') RES_END_DATE
,(select meaning 
	from fnd_lookups
	where LOOKUP_TYPE =  'ORA_QP_CURRENCY_CONV_TYPES'
	and lookup_code = detail.CONVERSION_TYPE_CODE         
	) RES_CONVERSION_TYPE
,detail.CONVERSION_RATE RES_CONVERSION_RATE
,(SELECT USER_CONVERSION_TYPE
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = detail.GL_CONVERSION_TYPE_CODE
	) RES_GL_CONVERSION_TYPE
,(select meaning 
	from fnd_lookups
	where LOOKUP_TYPE =  'ORA_QP_CURRENCY_ADJ_TYPES'
	and lookup_code =  detail.ADJUSTMENT_TYPE_CODE  
	) RES_ADJUSTMENT_TYPE
,detail.ADJUSTMENT_VALUE RES_ADJUSTMENT_AMOUNT
,detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,detail.CREATED_BY  RSC_CREATED_BY
,detail.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,A.ORG_ID  RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_CURR_CONV_LISTS_VL  A
,QP_CURR_CONV_DETAILS detail
WHERE A.CURRENCY_CONV_LIST_ID = detail.CURRENCY_CONV_LIST_ID