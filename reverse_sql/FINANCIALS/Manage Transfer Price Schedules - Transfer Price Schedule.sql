/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transfer%20Price%20Schedules%20-%20Transfer%20Price%20Schedule.sql $:
* $Id: Manage Transfer Price Schedules - Transfer Price Schedule.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfTPSchedule.TP_SCHEDULE_NAME					RES_NAME
,pjfTPSchedule.DESCRIPTION								RES_DESCRIPTION
,TO_CHAR(pjfTPSchedule.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjfTPSchedule.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
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
ORDER BY pjfTPSchedule.TP_SCHEDULE_NAME