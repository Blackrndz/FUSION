/* ****************************************************************************
 * $Revision: 78622 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-05-31 16:38:11 +0700 (Tue, 31 May 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Rate%20Schedules%20-%20Job%20Rates.sql $:
 * $Id: Manage Rate Schedules - Job Rates.sql 78622 2022-05-31 09:38:11Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT rateSchedulesE0.RATE_SCHEDULE_NAME RES_NAME
,(SELECT NAME 
	FROM PER_JOBS_F_TL 
	WHERE LANGUAGE = USERENV('LANG')
	AND JOB_ID = rateScheduleLinesE0.JOB_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_JOB
,(SELECT JOB_CODE 
	FROM PER_JOBS_F 
	WHERE JOB_ID = rateScheduleLinesE0.JOB_ID
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_JOB_CODE
,(CASE
	WHEN rateScheduleLinesE0.RATE_UNIT = 'HOURS' THEN
		'Hours'
	WHEN rateScheduleLinesE0.RATE_UNIT = 'DOLLARS' THEN
		'Currency'
	ELSE
		(SELECT UNIT_OF_MEASURE 
		FROM INV_UNITS_OF_MEASURE_VL
		WHERE UOM_CODE = rateScheduleLinesE0.RATE_UNIT)
	END) RES_UNIT_OF_MEASURE
,rateScheduleLinesE0.RATE RES_RATE
,TO_CHAR(rateScheduleLinesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(rateScheduleLinesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,rateScheduleLinesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,rateScheduleLinesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,rateScheduleLinesE0.CREATED_BY RSC_CREATED_BY
,rateScheduleLinesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RATE_SCHEDULES_VL rateSchedulesE0
,PJF_RATE_SCHEDULE_LINES rateScheduleLinesE0
WHERE rateSchedulesE0.SCHEDULE_TYPE = 'JOB'
AND rateSchedulesE0.RATE_SCHEDULE_ID = rateScheduleLinesE0.RATE_SCHEDULE_ID
ORDER BY rateSchedulesE0.RATE_SCHEDULE_NAME,2