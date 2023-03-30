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
,resClassesE0.NAME RES_RESOURCE_CLASS
,(SELECT NAME 
	FROM HR_ORGANIZATION_UNITS 
	WHERE ORGANIZATION_ID = RES_CLASS_ORGANIZATION_ID
	) RES_ORGANIZATION
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
,rateScheduleLinesE0.MARKUP_PERCENTAGE RES_MARKUP_PERCENT
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
,PJF_RESOURCE_CLASSES_TL resClassesE0
WHERE rateSchedulesE0.SCHEDULE_TYPE = 'RESOURCE_CLASS'
AND rateSchedulesE0.RATE_SCHEDULE_ID = rateScheduleLinesE0.RATE_SCHEDULE_ID
AND rateScheduleLinesE0.RESOURCE_CLASS_ID = resClassesE0.RESOURCE_CLASS_ID
AND resClassesE0.LANGUAGE = USERENV('LANG')
ORDER BY rateSchedulesE0.RATE_SCHEDULE_NAME
,resClassesE0.NAME