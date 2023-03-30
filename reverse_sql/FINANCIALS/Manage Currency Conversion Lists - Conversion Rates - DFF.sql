/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah.Dusenmahamad $:
 * $Date: 2017-08-30 $:
 * $HeadURL:  $:
 * $Id: Manage Currency Conversion Lists - Currency Conversion Lists - DFF.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_LISTS_VL
-- RSC_PREREQUISITE_OBJECTS=QP_CURR_CONV_DETAILS 
 
 -- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=667##RES##QP_CURR_CONV_DETAILS_FLEX
-- DFF_ATTRIBUTES=ATTRIBUTE_CHAR

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields. 


SELECT A.NAME                      										RES_NAME,
detail.FROM_CURRENCY_CODE                        						RES_BASE_CURRENCY,
detail.TO_CURRENCY_CODE                                         		RES_TO_CURRENCY,
to_char(detail.START_DATE,'DD-Mon-YYYY HH24:MI:SS')                     RES_START_DATE,
detail.ATTRIBUTE_CATEGORY 												RES_CONTEXT_CODE
,detail.ATTRIBUTE_CHAR1
,detail.ATTRIBUTE_CHAR2
,detail.ATTRIBUTE_CHAR3
,detail.ATTRIBUTE_CHAR4
,detail.ATTRIBUTE_CHAR5
,detail.ATTRIBUTE_CHAR6
,detail.ATTRIBUTE_CHAR7
,detail.ATTRIBUTE_CHAR8
,detail.ATTRIBUTE_CHAR9
,detail.ATTRIBUTE_CHAR10
,detail.ATTRIBUTE_CHAR11
,detail.ATTRIBUTE_CHAR12
,detail.ATTRIBUTE_CHAR13
,detail.ATTRIBUTE_CHAR14
,detail.ATTRIBUTE_CHAR15
,detail.ATTRIBUTE_CHAR16
,detail.ATTRIBUTE_CHAR17
,detail.ATTRIBUTE_CHAR18
,detail.ATTRIBUTE_CHAR19
,detail.ATTRIBUTE_CHAR20
,detail.LAST_UPDATED_BY 		RSC_LAST_UPDATED_BY
,detail.LAST_UPDATE_DATE 		RSC_LAST_UPDATE_DATE
,detail.CREATED_BY 				RSC_CREATED_BY
,detail.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,A.ORG_ID  RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM QP_CURR_CONV_LISTS_VL  A
     , QP_CURR_CONV_DETAILS detail
WHERE   A.CURRENCY_CONV_LIST_ID =   detail.CURRENCY_CONV_LIST_ID
AND (detail.ATTRIBUTE_CATEGORY IS NOT NULL
	OR detail.ATTRIBUTE_CHAR1            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR2            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR3            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR4            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR5            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR6            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR7            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR8            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR9            IS NOT NULL
	OR detail.ATTRIBUTE_CHAR10           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR11           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR12           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR13           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR14           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR15           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR16           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR17           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR18           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR19           IS NOT NULL
	OR detail.ATTRIBUTE_CHAR20           IS NOT NULL
)


