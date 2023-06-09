/* ****************************************************************************
* $Revision: 55345 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-23 12:42:33 +0700 (Mon, 23 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT benELIGYEO.NAME RES_NAME
,benELIGPERGRTEO.ORDR_NUM RES_SEQUENCE
,(SELECT NAME FROM HRA_TMPL_DEFNS_VL WHERE TEMPLATE_DEFN_ID = benELIGPERGRTEO.PERF_TMPL_ID
	AND SYSDATE BETWEEN DATE_FROM AND NVL(DATE_TO,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_TEMPLATE_NAME
,(SELECT RATING_NAME||' '||RATING_MODEL_CODE FROM HRT_RATING_MODELS_VL 
	WHERE RATING_MODEL_ID = benELIGPERGRTEO.RATING_MODEL_ID
	AND SYSDATE BETWEEN DATE_FROM AND NVL(DATE_TO,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_RATING_MODE_NAME
,DECODE(benELIGPERGRTEO.MOST_RECENT_FLAG,'Y','Yes','No') RES_TIMING_MOST_RECENT_OR_LATE
,(SELECT CUSTOMARY_NAME||' '||SHORT_NAME FROM HRA_TMPL_PERIODS_VL 
	WHERE TMPL_PERIOD_ID = benELIGPERGRTEO.TMPL_PERIOD_ID) RES_TIMING_PERIOD_NAME
,(SELECT RATING_LEVEL_CODE||' '||RATING_SHORT_DESCR FROM HRT_RATING_LEVELS_VL 
	WHERE RATING_LEVEL_ID = benELIGPERGRTEO.RATING_LEVEL_ID
	AND SYSDATE BETWEEN DATE_FROM AND NVL(DATE_TO,TO_DATE('4712-12-31','YYYY-MM-DD'))) RES_RATING_LEVEL
,DECODE(benELIGPERGRTEO.EXCLD_FLAG,'Y','Yes','No') RES_EXCLUDE
,TO_CHAR(benELIGPERGRTEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGPERGRTEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE

,benELIGPERGRTEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGPERGRTEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGPERGRTEO.CREATED_BY  RSC_CREATED_BY
,benELIGPERGRTEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_PERF_RTNG_PRTE benELIGPERGRTEO
WHERE benELIGYEO.ELIGY_PRFL_ID = benELIGPERGRTEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGPERGRTEO.START_DATE AND NVL(benELIGPERGRTEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME,benELIGPERGRTEO.ORDR_NUM