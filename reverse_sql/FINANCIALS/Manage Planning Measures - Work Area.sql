/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_MEASURES_VL

WITH ASSIGN_WORKAREA AS (
	SELECT 1 ID, 'Demand Management' WORK_AREA FROM DUAL

	UNION
	SELECT 2 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 3 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 3 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 4 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 5 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 5 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 6 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 6 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 7 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 7 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 7 ID, 'Supply Planning' WORK_AREA FROM DUAL
	
	UNION
	SELECT 128 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 129 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 129 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 130 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 130 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 131 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 131 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 131 ID, 'Supply Planning' WORK_AREA FROM DUAL
	
	UNION
	SELECT 132 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 132 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 133 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 133 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 133 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 134 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 134 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 134 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 135 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 135 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 135 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 135 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 257 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 257 ID, 'Replenishment Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 258 ID, 'Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 258 ID, 'Replenishment Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 259 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 259 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 259 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 260 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 260 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 261 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 261 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 261 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 262 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 262 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 262 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 263 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 263 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 263 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 263 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 384 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 384 ID, 'Replenishment Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 385 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 385 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 385 ID, 'Replenishment Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 386 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 386 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 386 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 387 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 387 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 387 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 387 ID, 'Supply Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 388 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 388 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 388 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 389 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 389 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 389 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 389 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL

	UNION
	SELECT 390 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 390 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 390 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 390 ID, 'Supply Planning' WORK_AREA FROM DUAL --> MAIN

	UNION
	SELECT 391 ID, 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 391 ID, 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 391 ID, 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 391 ID, 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 391 ID, 'Supply Planning' WORK_AREA FROM DUAL)
,WORK_AREA_STRC AS (SELECT 'Backlog Management' WORK_AREA FROM DUAL
	UNION
	SELECT 'Demand Management' WORK_AREA FROM DUAL
	UNION
	SELECT 'Demand and Supply Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 'Replenishment Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 'Sales and Operations Planning' WORK_AREA FROM DUAL
	UNION
	SELECT 'Supply Planning' WORK_AREA FROM DUAL)


SELECT MeasuresE0.NAME RES_MEASURE
,WORK_AREA_STRC.WORK_AREA RES_WORK_AREA
,(CASE
	WHEN EXISTS (SELECT 1 FROM ASSIGN_WORKAREA
		WHERE ASSIGN_WORKAREA.ID = MeasuresE0.RELEVANT_PLAN_TYPE
		AND WORK_AREA = WORK_AREA_STRC.WORK_AREA) THEN
		'Yes'
	ELSE
		'No'
	END) RES_ENABLE
,MeasuresE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,MeasuresE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MeasuresE0.CREATED_BY  RSC_CREATED_BY
,MeasuresE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_MEASURES_VL MeasuresE0
,WORK_AREA_STRC
ORDER BY MeasuresE0.NAME
,WORK_AREA_STRC.WORK_AREA