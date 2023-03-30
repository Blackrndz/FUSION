/* ****************************************************************************
* $Revision: 67218 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2018-03-21 11:56:22 +0700 (Wed, 21 Mar 2018) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Key%20Flexfield%20Segment.sql $:
* $Id: Manage Key Flexfields - Key Flexfield Segment.sql 67218 2018-03-21 04:56:22Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_SOP_PLAN_CYCLE_VL

SELECT 'Default_PlanCycle' RES_PLANNING_CYCLE_TO_COPY
,PlanCycleE0.PLAN_CYCLE_NAME RES_PLANNING_CYCLE
,PlanCycleE0.PLAN_CYCLE_DESC RES_DESCRIPTION
,TO_CHAR(PlanCycleE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(PlanCycleE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_ID = PlanCycleE0.OWNER
	AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,SYSDATE + 1)
	) RES_OWNER
,PlanCycleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PlanCycleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PlanCycleE0.CREATED_BY RSC_CREATED_BY
,PlanCycleE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SOP_PLAN_CYCLE_VL PlanCycleE0
ORDER BY PlanCycleE0.PLAN_CYCLE_NAME