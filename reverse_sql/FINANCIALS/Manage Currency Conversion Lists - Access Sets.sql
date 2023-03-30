/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-30 $:
 * $HeadURL:  $:
 * $Id: Manage Currency Conversion Lists - Access Sets.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_ALL_B_ST
 
 
select Head.NAME RES_NAME
,BB.SET_CODE RES_SET_CODE
,BB.SET_NAME RES_SET_NAME
,BB.DESCRIPTION RES_SET_DESCRIPTION
,AA.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,AA.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,AA.CREATED_BY  RSC_CREATED_BY
,AA.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,Head.ORG_ID  RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from QP_CURR_CONV_LISTS_VL Head
,QP_CURR_CONV_LISTS_ALL_B_ST AA
,FND_SETID_SETS BB 
where Head.CURRENCY_CONV_LIST_ID =   AA.CURRENCY_CONV_LIST_ID
AND AA.SET_ID = BB.SET_ID
AND BB.language = USERENV('LANG')