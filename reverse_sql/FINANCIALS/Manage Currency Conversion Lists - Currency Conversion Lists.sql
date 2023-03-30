/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-29 $:
 * $HeadURL:  $:
 * $Id: Manage Currency Conversion Lists - Currency Conversion Lists.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_ALL_B


SELECT   A.NAME                      					RES_NAME,
A.DESCRIPTION                        					RES_DESCRIPTION,
(select BU_NAME from FUN_ALL_BUSINESS_UNITS_V		 	BusinessUnitPEO
 where BusinessUnitPEO.BU_ID = A.ORG_ID 
)                                     					RES_BUSINESS_UNIT,
(select meaning from fnd_lookups
where  LOOKUP_TYPE =  'ORA_QP_APPROVAL_STATUSES' 
and lookup_code =   A.STATUS_CODE                )      RES_STATUS,
to_char(B.START_DATE,'DD-Mon-YYYY HH24:MI:SS')          RES_START_DATE,
to_char(B.END_DATE,'DD-Mon-YYYY HH24:MI:SS')            RES_END_DATE
,A.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,A.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,A.CREATED_BY  RSC_CREATED_BY
,A.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,A.ORG_ID  RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_CURR_CONV_LISTS_VL  A
     ,QP_CURR_CONV_LISTS_ALL_B B
WHERE   A.CURRENCY_CONV_LIST_ID =   B.CURRENCY_CONV_LIST_ID
