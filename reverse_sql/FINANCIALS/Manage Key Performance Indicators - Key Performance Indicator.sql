/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Receivables%20Descriptive%20Flexfields%20-%20Manage%20Descriptive%20Flexfields.sql $:
* $Id: Manage Receivables Descriptive Flexfields - Manage Descriptive Flexfields.sql 53187 2016-03-01 11:52:21Z
dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT (SELECT NAME FROM HR_ALL_ORGANIZATION_UNITS
		WHERE ORGANIZATION_ID =pjsPERFRULEEO.PROJECT_UNIT_ID) RES_PROJECT_UNIT
,pjsPERFRULEEO.RULE_NAME RES_KPI_NAME
,(SELECT NAME FROM PJS_MT_MEASURES_VL WHERE MEASURE_ID = pjsPERFRULEEO.MEASURE_ID) RES_MEASURE
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = pjsPERFRULEEO.MEASURE_FORMAT 
	AND LOOKUP_TYPE = 'PJS_MEASURE_FORMATS' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD')))RES_MEASURE_FORMAT 
,pjsPERFRULEEO.RULE_DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = pjsPERFRULEEO.KPA_CODE
	AND LOOKUP_TYPE = 'PJS_PERF_KEY_AREAS' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_KPI_CATEGORY
,(SELECT MEANING FROM  FND_LOOKUP_VALUES WHERE LOOKUP_CODE = pjsPERFRULEEO.CURRENCY_TYPE
	AND LOOKUP_TYPE = 'PJF_CURRENCY_TYPE' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_CURRENCY_TYPE
,(SELECT MEANING FROM  FND_LOOKUP_VALUES WHERE LOOKUP_CODE = pjsPERFRULEEO.PERIOD_TYPE
	AND LOOKUP_TYPE = 'PJF_CALENDAR_TYPE' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_CALENDAR_TYPE  
,TO_DATE(pjsPERFRULEEO.START_DATE_ACTIVE,'YYYY-MM-DD') RES_FROM_DATE
,TO_DATE(pjsPERFRULEEO.END_DATE_ACTIVE,'YYYY-MM-DD') RES_TO_DATE
,(SELECT MEANING FROM  FND_LOOKUP_VALUES WHERE LOOKUP_CODE = pjsPERFRULEEO.TREND_INDICATOR_TYPE
	AND LOOKUP_TYPE = 'PJS_TREND_INDICATOR_TYPE' AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_TREND_INDICATOR
,pjsPERFRULEEO.TOLERANCE_PERCENT RES_TOLERANCE_PERCENTAGE
,DECODE(pjsPERFRULEEO.THRESHOLD_LEVEL,'M','Multiple threshold levels','S','Single threshold level value','R','Single threshold level range') RES_THRESHOLD_LEVEL_RULE
,(SELECT DISTINCT PRECISION FROM PJS_PERF_THRESHOLDS WHERE THRES_OBJ_ID = pjsPERFRULEEO.RULE_ID) RES_DECIMAL_DISPLAY


,pjsPERFRULEEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pjsPERFRULEEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pjsPERFRULEEO.CREATED_BY RSC_CREATED_BY
,pjsPERFRULEEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJS_PERF_RULES_VL pjsPERFRULEEO
WHERE pjsPERFRULEEO.MEASURE_FORMAT <> 'CURRENCY'
AND SYSDATE BETWEEN pjsPERFRULEEO.START_DATE_ACTIVE AND NVL(pjsPERFRULEEO.END_DATE_ACTIVE,TO_DATE('4712-12-31','YYYY-MM-DD'))