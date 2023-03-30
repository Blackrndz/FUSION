/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HRA_FEEDBACK_REQ_TMPLS_VL

SELECT RES_NAME
,RES_ATTRIBUTES_NAME
,RES_ATTRIBUTES_VALUE
,RSC_LAST_UPDATED_BY
,RSC_LAST_UPDATE_DATE
,RSC_CREATED_BY
,RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 FROM
(SELECT hraFEEDBACKE0.NAME RES_NAME
 ,DECODE((TRIM(REGEXP_SUBSTR(hraFEEDBACKE0.GOAL_ATTRIBUTE_LIST, '[^,]+', 1, levels.column_value))),'DESC','Goal Description'
 ,'STATUS','Goal Status','COMP_PERCENT','Completion Percentage','SUCCESS_CRIT','Success Criteria','WEIGHT','Goal Weight'
 ,'MEASUREMENT','Goal Measurements','TASKS','Goal Tasks') RES_ATTRIBUTES_NAME
,'Yes' RES_ATTRIBUTES_VALUE
,hraFEEDBACKE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hraFEEDBACKE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hraFEEDBACKE0.CREATED_BY RSC_CREATED_BY
,hraFEEDBACKE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_FEEDBACK_REQ_TMPLS_VL hraFEEDBACKE0
 ,table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(hraFEEDBACKE0.GOAL_ATTRIBUTE_LIST, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
 ORDER BY hraFEEDBACKE0.NAME,RES_ATTRIBUTES_NAME)
 WHERE RES_ATTRIBUTES_NAME IS NOT NULL