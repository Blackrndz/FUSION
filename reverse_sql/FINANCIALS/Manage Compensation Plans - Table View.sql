/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 --RSC_PREREQUISITE_OBJECTS=CMP_BUDGET_POOLS_VL 
 
SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,cmpBUDGETPOOLE0.POOL_NAME RES_POOL_NAME
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = cmpCSTME0.REGION_NAME
			AND LOOKUP_TYPE = 'CMP_BUDGET_SUMM_MCOLS' AND LANGUAGE = USERENV('LANG')
			AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_PARENT_COLUMN
,DECODE(cmpCSTME0.ITEM_NAME,'AllocationUsed','Allocated', 'BdgtAvailableVal','Available to Distribute', 'BdgtVal','Budget Amount', 'BdgtValPct','Budget Percentage', 'PoolName','Budget Pool', 'Currency','Currency'
, 'BdgtUsedVal','Distributed Amount', 'BdgtUsedPct','Distributed Percentage', 'EligSalVal','Eligible Salary', 'EligCount','Eligible Workers', 'GroupView','Group View', 'InEligEmployees','Ineligible Workers', 'Misc1Val'
,'Miscellaneous Rate 1', 'Misc2Val','Miscellaneous Rate 2', 'Misc3Val','Miscellaneous Rate 3', 'Misc4Val','Miscellaneous Rate 4', 'Misc5Val','Miscellaneous Rate 5', 'Misc6Val','Miscellaneous Rate 6', 'AllocationUnused'
,'Remaining Budget', 'TargetVal','Target Allocation', 'TargetMaxVal','Target Compensation Amount Maximum', 'TargetMinVal','Target Compensation Amount Minimum', 'TargetValPct','Target Compensation Percentage', 'Unit','Units'
, 'NonIssBdgtAmt','Unpublished') RES_COLUMN
,DECODE(cmpCSTME0.DISPLAY_FLAG,'Y','Yes','No') RES_ENABLE
,cmpCSTME0.DISPLAY_NAME RES_DISPLAY_NAME
,cmpCSTME0.ORDER_NUM RES_DEFAULT_SEQUENCE
,cmpCSTME0.DESCRIPTION RES_INSTRUCTION_TEXT
 
,cmpCSTME0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpCSTME0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpCSTME0.CREATED_BY RSC_CREATED_BY
,cmpCSTME0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,CMP_BUDGET_POOLS_VL cmpBUDGETPOOLE0
,CMP_CSTM_REGION_ITEMS_VL cmpCSTME0

WHERE cmpPLANEO.PLAN_ID = cmpBUDGETPOOLE0.PLAN_ID
AND cmpBUDGETPOOLE0.POOL_ID = cmpCSTME0.CUSTOM_KEY
AND cmpPLANEO.COMP_TYPE = 'CWB'
AND cmpCSTME0.REGION_NAME LIKE 'SUMMARY_TABLE%MCOL'
ORDER BY cmpPLANEO.PLAN_NAME,cmpBUDGETPOOLE0.POOL_NAME,RES_PARENT_COLUMN,RES_COLUMN