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
,cmpBUDGETPOOLEO.POOL_NAME RES_POOL_NAME
,DECODE(cmpBUDGETPOOLEO.ENABLE_SCOREBOARD_VIEW_FLAG,'Y','Yes','No') RES_ENABLE_SCOREBOARD_VIEW
,cmpINSTRUCE0.INSTRUCTION_TEXT RES_INSTRUCTION_TEXT
 
,cmpBUDGETPOOLEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpBUDGETPOOLEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpBUDGETPOOLEO.CREATED_BY RSC_CREATED_BY
,cmpBUDGETPOOLEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,CMP_BUDGET_POOLS_VL cmpBUDGETPOOLEO
,CMP_INSTRUCTIONS_VL cmpINSTRUCE0
WHERE cmpPLANEO.PLAN_ID = cmpBUDGETPOOLEO.PLAN_ID
AND cmpBUDGETPOOLEO.POOL_ID = cmpINSTRUCE0.INSTRUCTION_KEY
AND cmpPLANEO.COMP_TYPE = 'CWB'
ORDER BY cmpPLANEO.PLAN_NAME,cmpBUDGETPOOLEO.POOL_NAME