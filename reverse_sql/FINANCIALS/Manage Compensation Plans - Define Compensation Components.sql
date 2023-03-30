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
,cmpCOMPONENTEO.SYSTEM_ORDER_NUM RES_COMPONENT_NUMBER
,cmpCOMPONENTEO.COMPONENT_NAME RES_NAME
,cmpCOMPONENTEO.ORDER_NUM RES_DISPLAY_ORDER
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = cmpCOMPONENTEO.CURRENCY_DETERMINATION_CODE
			AND LOOKUP_TYPE = 'CMP_CURR_DETERMINATION' AND LANGUAGE = USERENV('LANG')
			AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_LOCAL_CURRENCY_DETERMINATI
,(SELECT FORMULA_NAME
			FROM FF_FORMULAS_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND FORMULA_ID = cmpCOMPONENTEO.RULE_ID) RES_FORMULA
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = cmpCOMPONENTEO.NON_MONETARY_UOM 
			AND LOOKUP_TYPE = 'CMP_NONMONETARY_UOM' AND LANGUAGE = USERENV('LANG')
			AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_NONMONETARY_UNITS
,cmpBUDGETPOOLEO.POOL_NAME RES_BUDGET_POOL
,(CASE WHEN cmpBUDGETPOOLEO.PRIMARY_COMPONENT_ID IS NOT NULL
	THEN 'Yes'
	ELSE 'No' END) RES_PRIMARY_COMPONENT_FOR_BUDG
,DECODE(cmpCOMPONENTEO.USE_FOR_ASG_SEG_FLAG,'Y','Yes','No') RES_COMPONENT_FOR_ASSIGNMENT_S
,cmpCOMPONENTEO.ASG_SEG_WS_COLUMN_CODE RES_AMOUNT_COLUMN_FOR_ASSIGNME
,DECODE(cmpCOMPONENTEO.ASG_SEG_AUTO_PUBLISH_FLAG,'Y','Yes','No') RES_PUBLISH_AMOUNT_FOR_ASSIGNM

	

 
,cmpCOMPONENTEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,cmpCOMPONENTEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,cmpCOMPONENTEO.CREATED_BY RSC_CREATED_BY
,cmpCOMPONENTEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,CMP_COMPONENTS_VL cmpCOMPONENTEO
,CMP_BUDGET_POOLS_VL cmpBUDGETPOOLEO
WHERE cmpPLANEO.PLAN_ID = cmpCOMPONENTEO.PLAN_ID
AND cmpPLANEO.PLAN_ID = cmpBUDGETPOOLEO.PLAN_ID
AND cmpBUDGETPOOLEO.POOL_ID	 = cmpCOMPONENTEO.POOL_ID_TO_CONSUME
AND cmpPLANEO.COMP_TYPE = 'CWB'
ORDER BY cmpPLANEO.PLAN_NAME