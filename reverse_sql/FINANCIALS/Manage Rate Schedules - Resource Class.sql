/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT rateSchedulesE0.RATE_SCHEDULE_NAME RES_NAME
,rateSchedulesE0.DESCRIPTION RES_DESCRIPTION
,(SELECT SET_CODE
	FROM FND_SETID_SETS
	WHERE LANGUAGE = USERENV('LANG')
	AND SET_ID = NVL(rateSchedulesE0.JOB_SET_ID,0)
	) RES_PROJECT_RATES_SET
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PJF_SCHEDULE_TYPE'
	AND LOOKUP_CODE = rateSchedulesE0.SCHEDULE_TYPE
	) RES_SCHEDULE_TYPE
,rateSchedulesE0.CURRENCY_CODE RES_CURRENCY
,rateSchedulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rateSchedulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rateSchedulesE0.CREATED_BY RSC_CREATED_BY
,rateSchedulesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RATE_SCHEDULES_VL rateSchedulesE0
WHERE rateSchedulesE0.SCHEDULE_TYPE = 'RESOURCE_CLASS'
ORDER BY rateSchedulesE0.RATE_SCHEDULE_NAME