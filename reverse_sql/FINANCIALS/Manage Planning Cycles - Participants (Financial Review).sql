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

SELECT PlanCycleE0.PLAN_CYCLE_NAME RES_NAME
,(SELECT USERNAME
	FROM PER_USERS
	WHERE USER_ID = PlanParticipantsE0.PARTICIPANT_ID
	AND SYSDATE BETWEEN START_DATE AND NVL(END_DATE,SYSDATE+1)
	) RES_FINANCIAL_REVIEW
,PlanParticipantsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PlanParticipantsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PlanParticipantsE0.CREATED_BY RSC_CREATED_BY
,PlanParticipantsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SOP_PLAN_CYCLE_VL PlanCycleE0
,MSC_SOP_PLAN_PARTICIPANTS PlanParticipantsE0
WHERE PlanCycleE0.PLAN_CYCLE_ID = PlanParticipantsE0.PLAN_CYCLE_ID
AND PlanParticipantsE0.SUB_PROCESS_ID = 4
ORDER BY PlanCycleE0.PLAN_CYCLE_NAME
,2