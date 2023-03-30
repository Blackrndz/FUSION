 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HRG_GOAL_PLAN_DOC_TYPES

WITH GOAL_DOC_TYPES AS (SELECT DISTINCT GOAL_PLAN_ID
	,hraDOCE0.NAME
	,hraDOCE0.DOC_TYPE_ID
	FROM HRG_GOAL_PLAN_DOC_TYPES planDocTypesE0
	,HRA_DOC_TYPES_TL hraDOCE0)

SELECT goldPlansE0.GOAL_PLAN_NAME RES_GOAL_PLAN
,GOAL_DOC_TYPES.NAME RES_PERFORMANCE_DOCUMENT_TYPES
,(CASE WHEN DOC_TYPE_ID IN (SELECT DOC_TYPE_ID FROM HRG_GOAL_PLAN_DOC_TYPES WHERE GOAL_PLAN_ID = GOAL_DOC_TYPES.GOAL_PLAN_ID) 
	THEN 'Yes' ELSE 'No' END) RES_ENABLE

,goldPlansE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,goldPlansE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,goldPlansE0.CREATED_BY  RSC_CREATED_BY
,goldPlansE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,goldPlansE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRG_GOAL_PLANS_VL goldPlansE0
,GOAL_DOC_TYPES

WHERE goldPlansE0.GOAL_PLAN_ID = GOAL_DOC_TYPES.GOAL_PLAN_ID
ORDER BY goldPlansE0.GOAL_PLAN_NAME,GOAL_DOC_TYPES.NAME