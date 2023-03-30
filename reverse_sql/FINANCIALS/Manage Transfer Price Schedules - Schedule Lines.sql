/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transfer%20Price%20Schedules%20-%20Schedule%20Lines.sql $:
* $Id: Manage Transfer Price Schedules - Schedule Lines.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfTPSchedule.TP_SCHEDULE_NAME				RES_NAME
,pjfTPScheLine.SORT_ORDER							RES_LINE_NUMBER
,(SELECT NAME FROM HR_ORGANIZATION_UNITS 
		WHERE ORGANIZATION_ID = pjfTPScheLine.PRVDR_ORGANIZATION_ID) RES_PROVIDER_ORGANIZATION
,(SELECT NAME FROM HR_ORGANIZATION_UNITS 
		WHERE ORGANIZATION_ID = pjfTPScheLine.RECVR_ORGANIZATION_ID) RES_RECEIVER_ORGANIZATION
,(SELECT TP_RULE_NAME FROM PJF_TP_RULES
	WHERE TP_RULE_ID = pjfTPScheLine.TP_RULE_ID
		) RES_LABOR_RULE
,pjfTPScheLine.LABOR_PERCENTAGE_APPLIED 			RES_LABOR_MARKUP_OR_DISCOUNT_P
,(SELECT TP_RULE_NAME FROM PJF_TP_RULES
	WHERE TP_RULE_ID = pjfTPScheLine.NL_TP_RULE_ID
		) RES_NONLABOR_RULE
,pjfTPScheLine.NL_PERCENTAGE_APPLIED				RES_NONLABOR_MARKUP_OR_DISCOUN
,(SELECT MEANING FROM FND_LOOKUPS
	WHERE  LOOKUP_TYPE = 'PJF_TP_AMT_TYPE_CODE'
		AND LOOKUP_CODE = pjfTPScheLine.TP_AMT_TYPE_CODE
			) RES_AMOUNT_TYPE
,TO_CHAR(pjfTPScheLine.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjfTPScheLine.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(pjfTPScheLine.DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT_RULE
,pjfTPSchedule.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfTPSchedule.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfTPSchedule.CREATED_BY  RSC_CREATED_BY
,pjfTPSchedule.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_TP_SCHEDULES pjfTPSchedule
,PJF_TP_SCHEDULE_LINES pjfTPScheLine
WHERE pjfTPSchedule.TP_SCHEDULE_ID = pjfTPScheLine.TP_SCHEDULE_ID
ORDER BY pjfTPSchedule.TP_SCHEDULE_NAME

